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
#import "XJLoggerManager.h"

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
    Weakly(weakSelf);
    if (!request.queue) {
        //放到自定义的并行队列:
        request.queue = [self handleXJNewWorkQueue];
    }else{
        
    }
    dispatch_async(request.queue, ^{
        Strongly(strongSelf);
        [strongSelf setupHandleRequest:request];
    });
}

- (void)setupHandleRequest:(XJBaseRequest *)request
{
    [[XJRequestOperation shareOperation]sendRequest:request config:self.config completionCallback:^(XJBaseRequest*  _Nonnull request, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            //接口异常上报;
            request.failureBlock(error);
        }else{
            request.successBlock(responseObject);
        }
        
        if (self.config.isEnableLog || request.isEnableLogger) {
            [[XJLoggerManager shareLogger]setupLogRequest:request];
        }
        
    }];
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
