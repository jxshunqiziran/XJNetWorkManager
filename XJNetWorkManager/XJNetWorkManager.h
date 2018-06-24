//
//  XJNetWorkManager.h
//  XJNetWorkManager-Example
//
//  Created by 江鑫 on 2018/5/11.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJBaseRequest.h"
#import <UIKit/UIKit.h>


@interface XJNetWorkManager : NSObject

typedef void(^XJSuccessBlock)(id response);
typedef void(^XJFailBlock)(NSString* failMessage);


#pragma mark  ------------ 请求的控制及获取 ----------

/**
 取消当前所有请求:
 */
- (void) cancleAllRequest;

/**
 获取当前所有请求task任务:

 @return task数组;
 */
- (NSArray<NSURLSessionTask*>*) allCurrentSessionTaskRequest;

/**
 获取当前所有请求的url:

 @return url数组;
 */
- (NSArray<NSString*>*) allCurrentURLRequest;


/**
 获取所有当前的请求的baseRequest:

 @return baseRequest数组;
 */
- (NSArray<XJBaseRequest*>*) allCurrentBaseRequest;



#pragma mark  ------------ 所有基础请求 ----------

/**
 Creates and runs an `XJBaseRequest` with a `GET` request.

 @param url 请求url
 @param parameter 请求参数
 @param successblock 请求成功的block回调
 @param failblock 请求失败的block回调
 @return 该url请求对象
 */
+ (XJBaseRequest*) xj_GETRequestWithURL:(NSString*)url parameter:(id)parameter successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock;


/**
 Creates and runs an `XJBaseRequest` with a `POST` request.
 
 @param url 请求url
 @param parameter 请求参数
 @param successblock 请求成功的block回调
 @param failblock 请求失败的block回调
 @return 该url请求对象
 */
+ (XJBaseRequest*) xj_PostRequestWithURL:(NSString*)url parameter:(id)parameter successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock;


/**
 Creates and runs an `XJBaseRequest` with a optional request.
 
 @param method 请求方式:GET,PUT,POST,HEAD,DELETE
 @param url 请求url
 @param parameter 请求参数
 @param successblock 请求成功的block回调
 @param failblock 请求失败的block回调
 @return 该url请求对象
 */
+ (XJBaseRequest*) xj_RequestMethod:(XJRequestMethod)method url:(NSString*)url parameter:(id)parameter  successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock;


/**
 Creates and runs an `XJBaseRequest` with a 'GET' request.
 
 @param url 请求url
 @param parameter 请求参数
 @param timeoutSecond 请求超时时间
 @param successblock 请求成功的block回调
 @param failblock 请求失败的block回调
 @return 该url请求对象
 */
+ (XJBaseRequest*) xj_GETRequestWithURL:(NSString*)url parameter:(id)parameter timeoutInterval:(CGFloat)timeoutSecond successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock;


/**
 Creates and runs an `XJBaseRequest` with a 'POST' request.
 
 @param url 请求url
 @param parameter 请求参数
 @param timeoutSecond 请求超时时间
 @param successblock 请求成功的block回调
 @param failblock 请求失败的block回调
 @return 该url请求对象
 */
+ (XJBaseRequest*) xj_PostRequestWithURL:(NSString*)url parameter:(id)parameter timeoutInterval:(CGFloat)timeoutSecond successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock;





#pragma mark  ------------ 上传图片 ----------

- (void) xj_uploadImageArray:(NSArray*)dataArray url:(NSString*)url parameter:(id)parameter;


/**
 单张图片上传
 
 @param url url,后续可以固定上传图片api
 @param imagedata data
 @param parameter 参数
 @param progressBlock 进度回调;
 @param successBlock 成功回调;
 @param failblock 失败回调;
 */
+ (XJBaseRequest*) xj_uploadImageWithUrl:(NSString*)url uploadData:(NSData*)imagedata parameter:(id)parameter progressBlock:(XJUploadImageSingleBlock)progressBlock completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;


/**
 异步上传多张图片
 
 @param dataArray 图片数据流数组
 @param url url
 @param parameter 参数
 @param successBlock 成功回调
 @param failblock 失败回调
 */
+ (void) xj_asyUploadImageArray:(NSArray*)dataArray url:(NSString*)url parameter:(id)parameter completionSuccessblock:(XJAsynUploadImagesSuccessProgressBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;


#pragma mark  ------------ 下载 ----------

@end
