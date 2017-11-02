//
//  Algorithm.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/2.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "Algorithm.h"

@implementation Algorithm

// 把 " www.zhidao.baidu.com " 这样的字符串改成 "com/baidu/zhidao/www"
- (NSString *)optionString: (NSString *)str {
    // 1. 将 Str 按 . 分割
    NSArray *subStrs = [str componentsSeparatedByString:@"."];
    // 2. 翻转数组
    NSArray *reverseStubStrs = [[subStrs reverseObjectEnumerator] allObjects];
    // 3. 使用 / 拼接字符串数组
    NSString *result = [reverseStubStrs componentsJoinedByString:@"/"];
    return result;
}

/**
 冒泡排序
 */
- (NSArray *)sort: (NSArray *)sortedArray {
    NSMutableArray *tempArray = [sortedArray mutableCopy];
    NSUInteger length = sortedArray.count;
    for (int index = 0; index < length - 1; index++) {
        for (int j = 0; j < length - index - 1; j++) {
            if (tempArray[j] > tempArray[index]) {
                int temp = [tempArray[j] intValue];
                tempArray[j] = tempArray[index];
                tempArray[index] = @(temp);
            }
        }
    }
    return tempArray;
}

void quickSort(int arr[],int _left,int _right) {
    int left = _left;
    int right = _right;
    int temp = 0;
    if(left <= right){   //待排序的元素至少有两个的情况
        temp = arr[left];  //待排序的第一个元素作为基准元素
        while(left != right){   //从左右两边交替扫描，直到left = right
            
            while(right > left && arr[right] >= temp)
                right --;        //从右往左扫描，找到第一个比基准元素小的元素
            arr[left] = arr[right];  //找到这种元素arr[right]后与arr[left]交换
            
            while(left < right && arr[left] <= temp)
                left ++;         //从左往右扫描，找到第一个比基准元素大的元素
            arr[right] = arr[left];  //找到这种元素arr[left]后，与arr[right]交换
            
        }
        arr[right] = temp;    //基准元素归位
        quickSort(arr,_left,left-1);  //对基准元素左边的元素进行递归排序
        quickSort(arr, right+1,_right);  //对基准元素右边的进行递归排序
    }
}

- (void)quickSort: (NSMutableArray *)sortedArray left: (int)left right: (int)right {
    if (left >= right) {
        return ;
    }
    int i = left, j = right;
    int flag = (int)sortedArray[left];
    while (i != j) {
        while (i < j && flag >= [sortedArray[j] intValue]) { j--; }
        
        while (i < j && flag <= [sortedArray[i] intValue]) { i++; }
        
        if (i < j) {
            int temp = (int)sortedArray[i];
            sortedArray[i] = sortedArray[j];
            sortedArray[j] = @(temp);
        }
    }
    
    sortedArray[left] = sortedArray[i];
    sortedArray[i] = @(flag);
    
    [self quickSort:sortedArray left:left right:i - 1];
    [self quickSort:sortedArray left:i + 1 right:right];
}

/**
 二分搜索
 */
int binarySearch (int target, NSArray *array) {
    int start = 0, end = (int)array.count - 1;
    while (start + 1 < end) {   // 留出一个空位
        int mid = start + (end - start) / 2;
        if ([array[mid] intValue] == target) {
            return mid;
        } else if ([array[mid] intValue] < target) {
            start = mid;
        } else {
            end = mid;
        }
    }
    if ([array[start] intValue] == target) {
        return start;
    }
    if ([array[end] intValue] == target) {
        return end;
    }
    return -1;
}

typedef struct Node {
    struct Node *next;
    int value;
} Node;

/**
 翻转链表
 */
Node *reverseLink(Node *head) {
    if (head == NULL) {
        return NULL;
    }
    Node *p, *q;
    (void)(p = head), q = NULL;
    while (p) {
        Node *pNext = p->next;
        p->next = q;
        q = p;
        p = pNext;
    }
    return q;
}


/**
 求公约数
 */
int gcd(int m, int n) {
    if (m % n == 0) {
        return n;
    }
    // 公约数等于第二个数与余数的公约数
    return gcd(n, m%n);
}
/**
 求公约数
 */
int gcdII(int m, int n) {
    if (m == n) {
        return m;
    }
    // 公约数等于 两数之差与更小的数的公约数
    if (m < n) {
        return gcdII(m - n, m);
    } else {
        return gcdII(m - 1, n);
    }
}

@end
