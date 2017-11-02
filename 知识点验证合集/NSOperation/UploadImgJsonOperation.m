//
//  UploadImgJsonOperation.m
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/2.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "UploadImgJsonOperation.h"
/*
 开发中常见情景，比如发送一条微博动态，用户可以在本地界面编辑好一条微博动态上传服务器，上传后要清除本机暂存档，这条微博包含文本JSON和一张图片，所以上传微博动态的工作就包含上传JSON文件和图片两个内容，并且在用户上传过程中可以随时取消，让用户继续编辑重新上传这个微博动态，这比较适合用NSOperation写。
 1.首先我们要写一个NSOperation的子类，要重写掉main中的方法。
 在main里面，要建立自动释放池autorelease pool。
 接下来的问题来了：上传照片和JSON文字时，我们会调用NSURLSession 的相应 API，但是这些API都是非同步的，但是在main中的这些方法里，如果不做特殊的处理，还没收到连续响应，main早就已经执行结束了。我们必须要停在main中，等待API响应。
 2.要在operation的中途停下来的时候等待响应，大致有两种思路，一种是在operation当中执行NSRunloop，另外一种就是使用GCD的semaphore
 3.在还没有GCD之前，如果希望一个operation可以在某一个地方停下来等候其他的事件发生，做法就是在这条线程中执行Runloop。Runloop就是那个之所以让图形化界面（GUI）的程序一直执行，而不会像某个function或者method从头到尾跑圈就结束的循环（也就是跑圈啦）。在iOS中，除了主线程会执行最主要的Runloop（[ NSRunloop mainRunLoop]）之外，每个线程也有属于自己的Run loop，只要调用 [NSRunloop currentRunLoop]，调用的就是当前线程自己的Runloop，所以要注意，虽然在不同的线程，我们调用的都是[NSRunloop currentRunLoop]，但是+currentRunLoop这个类方法回调的并不看做一个类。此外，NSRunloop并不可以手动建立，我们只能使用系统提供的Runloop类。（好像跑偏额~(≧▽≦)/~啦啦啦）
 4.我们要做的是能够在这个operation 执行到一半时喊停，要取消一条operation，那就是要调用 NSOperation的cancel这个方法了，因为我们重写了NSOperation，改变operation里面做的事情，那顺带也重写了cancel，当我们的operation在跑Runloop时候，我们的cancel必须能够通知Runloop停止。当一条线程在跑自己的Runloop之后，如果不同线程之间想要互相通信，那我们就必须在当前的线程建立NSPort类，NSPort介个是个什么东东呢？请移步看苹果爸爸咋说吧。Runloop。将 NSPort 类注册到Runloop内，才可以把消息传到Runloop里面，所以当外部要求Port调用invalidate的时候，就会让Runloop收到消息，停止继续跑，继续执行-main这个方法接下来的方法。
 NSPort 也有封装的 Core Foundation 实现，像CFMessagePort等，但是在iOS7之后就没有办法使用了CFMessagePort。iOS7之后之后，调用CFMessagePortCreateLocal或者CFMessagePortCreateRemote这些新建CFMessagePort的函数都无法建立类，只能回传NULL（可以参照CFMessagePort的文档），苹果不允许让我们使用CFMessagePort的原因是：CFMessagePort不但可以传递消息到其他线程的RunLoop上，甚至可以传到其他进程的Runloop上，而iOS 政策上是不允许进程之间相互连通的。

 */
@implementation UploadImgJsonOperation {
    NSPort *port;
    BOOL runloopRunning;
    dispatch_semaphore_t semaphore;
}
/* 使用 Runloop 控制子线程保活
- (void)main {
    @autoreleasepool {
        if (self.isCancelled) { return;}
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // upload UIImage.....
            // .....
            // upload Image Success
            [self quiteRunloop];
        });
        [self startRunloop];
        if (self.isCancelled) { return; }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // upload JSON.....
            // .....
            // upload JSON Success
            [self quiteRunloop];
        });
        [self startRunloop];
    }
}

- (void)startRunloop {
    runloopRunning = YES;
    port = [NSPort port];
    [[NSRunLoop currentRunLoop] addPort:port forMode:NSRunLoopCommonModes];
    while (runloopRunning && !self.isCancelled) {
        @autoreleasepool {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
        }
    }
}

- (void)quiteRunloop {
    [port invalidate];
    runloopRunning = NO;
}

- (void)cancel {
    [super cancel];
    [self quiteRunloop];
}*/

/*
 使用信号量使子线程暂停，等待上传回调
 */
- (void)main {
    @autoreleasepool {
        if (self.isCancelled) { return; }
        semaphore = dispatch_semaphore_create(0);       // 初始信号量为0
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // upload UIImage.....
            // .....
            // upload Image Success
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);   // 如果信号量值为0 则等待
        if (self.isCancelled) { return; }
        
        semaphore = dispatch_semaphore_create(0);       // 初始信号量为0
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // upload JSON.....
            // .....
            // upload JSON Success
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
}

- (void)cancel {
    [super cancel];
    dispatch_semaphore_signal(semaphore);       // 发送信号，使 wait 可以具体往下执行
}

@end
