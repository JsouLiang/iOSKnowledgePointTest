//
//  RunloopSource.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/12/9.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "RunloopSource.h"
#import "AppDelegate.h"

void RunloopSourceScheduleRoutine(void *info, CFRunLoopRef rl, CFStringRef mode) {
    RunloopSource *source = (__bridge RunloopSource *)info;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    RunloopContext *context = [[RunloopContext alloc] initWithSource:source andLoop:rl];
    [delegate performSelectorOnMainThread:@selector(registerSource:) withObject:context waitUntilDone:NO];
}
void RunloopSourcePerformRoutine(void *info) {
    RunloopSource *source = (__bridge RunloopSource *)info;
    [source sourceFired];
}
void RunloopSourceCancelRoutine(void *info, CFRunLoopRef rl, CFStringRef mode) {
    RunloopSource *source = (__bridge RunloopSource *)info;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    RunloopContext *context = [[RunloopContext alloc] initWithSource:source andLoop:rl];
    [delegate performSelectorOnMainThread:@selector(removeSource:) withObject:context waitUntilDone:NO];
}

@implementation RunloopSource
- (instancetype)init {
    if (self = [super init]) {
        CFRunLoopSourceContext sourceContext = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
            &RunloopSourceScheduleRoutine,
            RunloopSourceCancelRoutine,
            RunloopSourcePerformRoutine};
        runloopSource = CFRunLoopSourceCreate(NULL, 0, &sourceContext);
        commands = [NSMutableArray array];
    }
    return self;
}

- (void)addToCurrentRunloop {
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runloop, runloopSource, kCFRunLoopDefaultMode);
}

- (void)fireAllCommandsOnRunloop:(CFRunLoopRef)runloop {
    CFRunLoopSourceSignal(runloopSource);
    CFRunLoopWakeUp(runloop);
}


@end

@implementation RunloopContext
@end

