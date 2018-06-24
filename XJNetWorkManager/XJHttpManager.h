//
//  XJHttpManager.h
//  XJNetWorkManager-Example
//
//  Created by 江鑫 on 2018/5/12.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJBaseRequest.h"

typedef NS_ENUM(NSInteger,XJResponseErrorCode)
{
    XJResponseErrorCodeUnknow = 101,//返回数据异常,无法解析
    XJResponseErrorCodeUnkff = 102,
};

@interface XJHttpManager : NSObject

+ (XJHttpManager*)shareManager;

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


/**
 发送XJRequest请求

 @param request baseRequest
 @param successBlock 成功回调
 @param failblock 失败回调
 */
- (void) configBaseRequest:(XJBaseRequest*)request completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;


/**
 单张图片上传
 
 @param request baseRequest
 @param progressBlock 进度
 @param successBlock 成功回调
 @param failblock 失败回调
 */
- (void) xj_uploadImage:(XJBaseRequest*)request progressBlock:(XJUploadImageSingleBlock)progressBlock completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;

- (void) xj_uploadImageArray:(XJBaseRequest*)request progressBlock:(XJSynUploadImagesBlock)progressBlock completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;

- (void) xj_synUploadImageArrayDetail:(XJBaseRequest*)request uploadIndexProgress:(XJSynUploadImagesDetailProgressBlock)progressblock completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;



/**
 异步上传多张图片

 @param imageDataArray 图片数据流数组
 @param url url
 @param parameter 参数
 @param successBlock 成功回调
 @param failblock 失败回调
 */
- (void) xj_asyUploadImageArray:(NSArray*)imageDataArray url:(NSString*)url parameter:(id)parameter completionSuccessblock:(XJAsynUploadImagesSuccessProgressBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;

@end
