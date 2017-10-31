//
//  LRUCacheStrategy.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/10/31.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "LRUCacheStrategy.h"
#import <pthread.h>
@interface _LinkNode : NSObject {
    @package
    __unsafe_unretained _LinkNode *_prevNode;
    __unsafe_unretained _LinkNode *_nextNode;
    id _key;
    id _value;
}
@end

@implementation _LinkNode

- (instancetype)init {
    return [self initWithKey:nil value:nil];
}

- (instancetype)initWithKey: (id)key value:(id)value {
    if (self = [super init]) {
        _prevNode = _prevNode = nil;
        _key = key; _value = value;
    }
    return self;
}

@end

@interface _LinkMap: NSObject
- (void)setValue:(id)value forKey:(id)key;

- (id)getValueForKey: (id)key;

- (void)removeAll;
- (void)allValue;
@end

@implementation _LinkMap {
    CFMutableDictionaryRef _dic;
    _LinkNode *_head;
    _LinkNode *_tail;
    NSUInteger _currentCount;
    NSInteger _totalCount;
    pthread_mutex_t _lock;
}

- (instancetype)init {
    return [self initWithCount:10];
}

- (instancetype)initWithCount: (NSUInteger)count {
    if (self = [super init]) {
        pthread_mutex_init(&_lock, NULL);

        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        _totalCount = count;
        _currentCount = 0;
        _head = [[_LinkNode alloc] init];
        _tail = [[_LinkNode alloc] init];
        _head->_nextNode = _tail;
        _tail->_prevNode = _head;
    }
    return self;
}

- (void)dealloc {
    CFRelease(_dic);
}

- (void)threadSafeOption: (void (^)(void))option{
    pthread_mutex_lock(&_lock);
    option();
    pthread_mutex_unlock(&_lock);
}

- (void)insertNodeAtHead:(_LinkNode *)node {
    [self threadSafeOption:^{
        node->_prevNode = _head;
        node->_nextNode = _head->_nextNode;
        _head->_nextNode->_prevNode = node;
        _head->_nextNode = node;
    }];
}

- (void)removeNode:(_LinkNode *)node {
    [self threadSafeOption:^{
        node->_nextNode->_prevNode = node->_prevNode;
        node->_prevNode->_nextNode = node->_nextNode;
    }];
   
}

- (_LinkNode *)popTail {
    pthread_mutex_lock(&_lock);
        _LinkNode *tail = self->_tail->_prevNode;
        [self removeNode:tail];
    pthread_mutex_unlock(&_lock);
    
    return tail;
}

- (void)movieNodeToHead: (_LinkNode *)node {
    [self threadSafeOption:^{
        [self removeNode:node];
        [self insertNodeAtHead:node];
    }];
}

- (id)getValueForKey:(id)key {
    pthread_mutex_lock(&_lock);
    if (!key) {
        return key;
    }
    _LinkNode *node = CFDictionaryGetValue(_dic, (__bridge void *)key);
    if (node == nil) {
        pthread_mutex_unlock(&_lock);
        return nil;
    } else {
        [self movieNodeToHead:node];
        pthread_mutex_unlock(&_lock);
        return node->_value;
    }
}

- (void)setValue:(id)value forKey:(id)key {
    [self threadSafeOption:^{
        _LinkNode *node = CFDictionaryGetValue(_dic, (__bridge void *)(key));
        // 当前缓存中不存在 node
        if (node == NULL) {
            _LinkNode *newNode = [[_LinkNode alloc] initWithKey:key value:value];
            // 将节点保存到缓存字典
            CFDictionarySetValue(_dic, (__bridge void *)key, (__bridge void *)newNode);
            _currentCount++;
            if (_currentCount > _totalCount) {
                _LinkNode *removedNode = [self popTail];
                // 将最久的节点移除
                CFDictionaryRemoveValue(_dic, (__bridge void *)(removedNode->_key));
                _currentCount--;
            }
        } else {
            node->_value = value;
            // 最近的使用移动到链表最前端
            [self movieNodeToHead:node];
        }
    }];
}

//- (void)allValue {
//    CFIndex count = CFDictionaryGetCount(_dic);
//    void **keys;
//    void **values;
//    keys = (void **)malloc(sizeof(void *) * count);
//    values = (void **)malloc(sizeof(void *) * count);
//    CFDictionaryGetKeysAndValues(_dic, keys, values);
//    free(keys);
//    free(values);
//}

- (void)removeAll {
}

@end

@implementation LRUCacheStrategy {
    _LinkMap *_cache;
}

- (instancetype)initWithCount:(NSUInteger)totailCount {
    if (self = [super init]) {
        _cache = [[_LinkMap alloc] initWithCount:totailCount];
    }
    return self;
}

- (void)setValue:(id)value forKey:(id)key {
    [_cache setValue:value forKey:key];
}

- (id)valueForKey:(id)key {
    return [_cache getValueForKey:key];
}


//
//- (void)allCacheValues {
//    [_cache allValue];
//}

@end
