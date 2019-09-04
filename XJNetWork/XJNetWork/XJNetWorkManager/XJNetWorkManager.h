//
//  XJNetWorkManager.h
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/21.
//  Copyright © 2019年 XJ. All rights reserved.
//
/*
 1、自定义签名规则;
 2、多个域名baseURL;OK
 3、测试机正式环境预发布环境;
 4、接口异常上报;
 5、自定义URL;OK
 6、选择请求方式;
 7、请求埋点;AOP;
 8、日志管理;OK
 9、返回方式支持block、代理、reform;
 10、支持是否添加默认参数;OK
 */

#import <Foundation/Foundation.h>
@class XJBaseRequest;
@class XJNetWorkConfig;

NS_ASSUME_NONNULL_BEGIN

@interface XJNetWorkManager : NSObject

@property (nonatomic, strong) XJNetWorkConfig *config;

+ (instancetype)manager;

- (void)sendRequest:(XJBaseRequest *)request;

+ (void)setupConfig:(void(^)(XJNetWorkConfig *config))configBlock;

@end

NS_ASSUME_NONNULL_END
