//
//  XJBaseRequest.h
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/21.
//  Copyright © 2019年 XJ. All rights reserved.
//


/*
 1、自定义签名规则;
 2、多个域名baseURL;
 3、测试机正式环境预发布环境;
 4、接口异常上报;
 5、自定义URL;
 6、选择请求方式;
 7、请求埋点;AOP;
 8、日志管理;
 9、返回方式支持block、代理、reform;

 
 
 */

#import <Foundation/Foundation.h>
#import "XJNetWorkConst.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^XJRequestSuccessBlock)(id __nullable resultObject);
typedef void(^XJRequestFailureBlock)(NSError* __nullable error);

@interface XJBaseRequest : NSObject

/*****自定义baseUrl*******/
@property(nonatomic,copy,nullable,readonly) NSString *BaseURL;

/*****自定义baseUrl*******/
@property(nonatomic,copy,nullable,readonly) NSString *customBaseURL;

/*****请求的接口API*******/
@property(nonatomic,copy,readonly) NSString *api;

/*****请求的参数*******/
@property(nonatomic,copy,nullable,readonly) NSDictionary *parameters;

@property(nonatomic,assign,readonly) BOOL isUseDefaultParameters;

@property(nonatomic,copy,nullable,readonly) NSDictionary *allParameters;

@property(nonatomic,copy,readonly) NSString *fullURLString;

/*****请求类型*******/
@property(nonatomic,assign,readonly) XJRequestSendType method;

/*****自定义请求URL*******/
@property(nonatomic,copy,nullable,readonly) NSString *customURL;

@property(nonatomic,assign,readonly) XJResponseSerializer responseType;

@property(nonatomic,assign,readonly) XJRequestSerializer requestType;

/*****请求的超时时间*******/
@property(nonatomic,assign,readonly) NSTimeInterval timeOutInterval;

@property(nonatomic,assign,readonly) BOOL isEnableLogger;

@property(nonatomic,strong) dispatch_queue_t queue;


@property(nonatomic,copy) XJRequestSuccessBlock successBlock;

@property(nonatomic,copy) XJRequestFailureBlock failureBlock;

+ (XJBaseRequest *)request;

- (XJBaseRequest *(^)(NSString *api))setAPI;

- (XJBaseRequest *(^)(NSDictionary *parameters))setParameters;

- (XJBaseRequest *(^)(BOOL isEnable))setisEnableLogger;

- (XJBaseRequest *)startRequest;

- (XJBaseRequest *)stopRequest;

- (XJBaseRequest *(^)(XJRequestSuccessBlock))completionSuccessBlock;

- (XJBaseRequest *(^)(XJRequestFailureBlock successblock))completionFailureBlock;

@end

NS_ASSUME_NONNULL_END
