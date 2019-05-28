//
//  XJNetWorkConfig.m
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/22.
//  Copyright © 2019年 XJ. All rights reserved.
//

#import "XJNetWorkConfig.h"

@implementation XJNetWorkConfig

+ (instancetype)shareConfig;
{
    static XJNetWorkConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[XJNetWorkConfig alloc]init];
    });
    return config;
}

@end
