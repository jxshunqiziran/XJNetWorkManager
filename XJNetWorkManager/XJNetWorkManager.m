//
//  XJNetWorkManager.m
//  XJNetWorkManager-Example
//
//  Created by 江鑫 on 2018/5/11.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJNetWorkManager.h"
#import "XJHttpManager.h"

@implementation XJNetWorkManager

+ (XJBaseRequest*) xj_GETRequestWithURL:(NSString*)url parameter:(id)parameter successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock;
{
    
   return  [self xj_RequestWithURL:url parameter:parameter timeoutInterval:0 method:XJRequestMethodGET successBlock:successblock failBlock:failblock];
  
}

+ (XJBaseRequest*) xj_PostRequestWithURL:(NSString*)url parameter:(id)parameter successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock;
{
    
   return  [self xj_RequestWithURL:url parameter:parameter timeoutInterval:0 method:XJRequestMethodPOST successBlock:successblock failBlock:failblock];
    
}

+ (XJBaseRequest*) xj_RequestMethod:(XJRequestMethod)method url:(NSString*)url parameter:(id)parameter  successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock;
{
   return [self xj_RequestWithURL:url parameter:parameter timeoutInterval:0 method:method successBlock:successblock failBlock:failblock];
}

+ (XJBaseRequest*) xj_GETRequestWithURL:(NSString*)url parameter:(id)parameter timeoutInterval:(CGFloat)timeoutSecond successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock;
{
  return  [self xj_RequestWithURL:url parameter:parameter timeoutInterval:timeoutSecond method:XJRequestMethodGET successBlock:successblock failBlock:failblock];
}

+ (XJBaseRequest*) xj_PostRequestWithURL:(NSString*)url parameter:(id)parameter timeoutInterval:(CGFloat)timeoutSecond successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock;
{
    
   return [self xj_RequestWithURL:url parameter:parameter timeoutInterval:timeoutSecond method:XJRequestMethodPOST successBlock:successblock failBlock:failblock];
    
}


+ (XJBaseRequest*) xj_RequestWithURL:(NSString*)url parameter:(id)parameter timeoutInterval:(CGFloat)timeoutSecond method:(XJRequestMethod)method successBlock:(XJSuccessBlock)successblock failBlock:(XJFailBlock)failblock
{
    XJBaseRequest *baseRequest = [[XJBaseRequest alloc]init];
    
    baseRequest.api = url;
    baseRequest.params = parameter;
    if (timeoutSecond == 0)baseRequest.timeoutInterval = timeoutSecond;
    baseRequest.requestmethod = method;
    
    [[XJHttpManager shareManager]configBaseRequest:baseRequest completionSuccessblock:^(id response) {
        
        successblock(response);
        
    } completionFailblock:^(NSError *error,NSString*msg) {
        
        failblock(msg);
        
    }];
    
    return baseRequest;
    
    
}


- (void) xj_uploadImageArray:(NSArray*)dataArray url:(NSString*)url parameter:(id)parameter;
{
    
    XJBaseRequest *baseRequest = [[XJBaseRequest alloc]init];
    
    baseRequest.api = url;
    baseRequest.params = parameter;

   
    
    
}


/**
 异步上传多张图片
 
 */
+ (void) xj_asyUploadImageArray:(NSArray*)dataArray url:(NSString*)url parameter:(id)parameter completionSuccessblock:(XJAsynUploadImagesSuccessProgressBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;
{
    
    XJBaseRequest *baseRequest = [[XJBaseRequest alloc]init];
    
    baseRequest.api = url;
    baseRequest.params = parameter;
    
    [[XJHttpManager shareManager]xj_asyUploadImageArray:dataArray url:url parameter:parameter completionSuccessblock:^(NSArray *resultArray) {
        
        if (successBlock) {
            successBlock(resultArray);
        }
        
    } completionFailblock:^(NSError *error, NSString *errormsg) {
        
        if (failblock) {
            failblock(error,errormsg);
        }
        
    }];
    
}




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
{
    
    //构建baseRequet:
    XJBaseRequest*request = [[XJBaseRequest alloc]init];
    request.uploadImageData = imagedata;
    request.api = url;
    request.params = parameter;
    
    //发请求:
    [[XJHttpManager shareManager]xj_uploadImage:request progressBlock:^(CGFloat progress) {
        
        progressBlock(progress);
        
    } completionSuccessblock:^(id response) {
        
        successBlock(response);
        
    } completionFailblock:^(NSError *error, NSString *errormsg) {
        
        failblock(error,errormsg);
        
    }];
    
    return request;
    
}




- (void) cancleAllRequest;
{
    return [[XJHttpManager shareManager]cancleAllRequest];
}

- (NSArray<NSURLSessionTask*>*) allCurrentSessionTaskRequest;
{
    return [[XJHttpManager shareManager]allCurrentSessionTaskRequest];
}

- (NSArray<NSString*>*) allCurrentURLRequest;
{
    return [[XJHttpManager shareManager]allCurrentURLRequest];
}

- (NSArray<XJBaseRequest*>*) allCurrentBaseRequest;
{
    return [[XJHttpManager shareManager]allCurrentBaseRequest];
}

@end
