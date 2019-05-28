//
//  XJNetWorkManager.m
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/21.
//  Copyright © 2019年 XJ. All rights reserved.
//

#import "XJNetWorkManager.h"
#import "XJRequestOperation.h"
#import "XJNetWorkConfig.h"

const  NSString *handleXJNewWorkQueuelable = @"com.xjnetwork.queue";

@implementation XJNetWorkManager

+ (instancetype)manager;
{
    static XJNetWorkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XJNetWorkManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _config = [XJNetWorkConfig shareConfig];
    }
    return self;
}

- (void)sendRequest:(XJBaseRequest *)request;
{
    //发送请求:
    if (!request.queue) {
        //放到自定义的并行队列:
        request.queue = [self handleXJNewWorkQueue];
    }else{
        
    }
    dispatch_async(request.queue, ^{
        [[XJRequestOperation shareOperation]sendRequest:request];
    });
}

- (dispatch_queue_t )handleXJNewWorkQueue
{
    static dispatch_queue_t queue ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.xjnetwork.queue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    });
    return queue;
}


+ (void)setupConfig:(void(^)(XJNetWorkConfig *config))configBlock;
{
    [[self manager]setupConfig:configBlock];
}

- (void)setupConfig:(void(^)(XJNetWorkConfig *config))configBlock;
{
    configBlock(self.config);
}


@end
