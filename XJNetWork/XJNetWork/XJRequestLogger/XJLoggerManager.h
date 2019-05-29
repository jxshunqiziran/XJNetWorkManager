//
//  XJLoggerManager.h
//  XJNetWork
//
//  Created by 江鑫 on 2019/5/28.
//  Copyright © 2019年 XJ. All rights reserved.

/*
1.打印请求参数、返回类型、队列名称、请求带参数的完整路径,可单独打印也可按规范格式打印;(后续优化可配置你想知道的信息)
2.错误日志上报服务器;
  包括: 错误的接口、完整路径、(机型、平台、udid、版本号 可缓存),errorCode,考虑是否保存本地;
3.全局开启,不全局开启,单个request也支持开启;
*/

#import <Foundation/Foundation.h>

@class XJBaseRequest;

NS_ASSUME_NONNULL_BEGIN

@interface XJLoggerManager : NSObject

+ (instancetype)shareLogger;

- (void)setupLogRequest:(XJBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
