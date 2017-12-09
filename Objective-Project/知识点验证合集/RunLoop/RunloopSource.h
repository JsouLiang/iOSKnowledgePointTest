//
//  RunloopSource.h
//  知识点验证合集
//
//  Created by X-Liang on 2017/12/9.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

void RunloopSourceScheduleRoutine(void *info, CFRunLoopRef rl, CFStringRef mode);
void RunloopSourcePerformRoutine(void *info);
void RunloopSourceCancelRoutine(void *info, CFRunLoopRef rl, CFStringRef mode);

@interface RunloopSource : NSObject {
    CFRunLoopSourceRef runloopSource;
    NSMutableArray *commands;
}

- (void)addToCurrentRunloop;
- (void)invalidate;

// Handler method
- (void)sourceFired;

- (void)addCommand: (NSInteger)command withData:(id)data;
- (void)fireAllCommandsOnRunloop: (CFRunLoopRef) runloop;

@end

@interface RunloopContext: NSObject {
    CFRunLoopRef runloop;
    RunloopSource *source;
}

@property (readonly)  CFRunLoopRef runloop;
@property (readonly)  RunloopSource *source;

- (instancetype)initWithSource: (RunloopSource *)src andLoop: (CFRunLoopRef)loop;

@end
