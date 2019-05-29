//
//  XJLoggerManager.m
//  XJNetWork
//
//  Created by 江鑫 on 2019/5/28.
//  Copyright © 2019年 XJ. All rights reserved.
//

#import "XJLoggerManager.h"
#import "XJBaseRequest.h"

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
    NSMutableString *desc = [NSMutableString string];
    NSMutableArray  *arr = [NSMutableArray new];
    [request.parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *keystr = [NSString stringWithFormat:@"%@=%@",key,obj];
        [arr addObject:keystr];
    }];
    NSString *allParamString = [arr componentsJoinedByString:@"&"];
    
    NSString *fullPath = [NSString stringWithFormat:@"%@%@",request.fullURLString,allParamString];
    [desc appendString:[NSString stringWithFormat:@"\n****************%@****************\n",fullPath]];
    [desc appendFormat:@"Parameters: %@\n", request.parameters ?: @"无参数"];
    [desc appendFormat:@"API: %@\n", request.api ?: @"无API"];
    NSLog(@"%@",desc);//也可重新request的description方法;
}

@end
