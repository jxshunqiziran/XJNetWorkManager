//
//  XJLoggerManager.m
//  XJNetWork
//
//  Created by 江鑫 on 2019/5/28.
//  Copyright © 2019年 XJ. All rights reserved.
//

#import "XJLoggerManager.h"

@implementation XJLoggerManager

+ (instancetype)shareLogger;
{
    static XJLoggerManager *logger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logger = [[XJLoggerManager alloc]init];
    });
    return logger;
}

- (void)setupLogRequest:(XJBaseRequest *)request;
{
    
    
    
}

@end
