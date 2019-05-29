//
//  XJNetWorkConfig.h
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/22.
//  Copyright © 2019年 XJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XJNetWorkConfig : NSObject

/********* baseURL ***********/
@property (nonatomic,copy) NSString *baseURL;

/********* 默认参数 ***********/
@property (nonatomic,copy) NSString *defaultParameters;

/********* 自定义网络不好重试次数 ***********/
@property (nonatomic, assign) NSUInteger retryCount;


// 日志相关的配置;
@property (nonatomic,assign) BOOL isEnableLog;

@property (nonatomic,assign) BOOL isEnableErrorUpload;

@property (nonatomic,copy) NSString *errorUploadAPI;

@property (nonatomic,assign) SEL addSignMethod;//可以利用消息转发来做;

+ (instancetype)shareConfig;

@end




NS_ASSUME_NONNULL_END
