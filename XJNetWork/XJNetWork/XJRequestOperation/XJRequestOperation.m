//
//  XJRequestOperation.m
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/21.
//  Copyright © 2019年 XJ. All rights reserved.
//

#import "XJRequestOperation.h"
#import <AFNetworking.h>

@implementation XJRequestOperation

+ (instancetype)shareOperation;
{
    static XJRequestOperation *operation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operation = [[XJRequestOperation alloc]init];
    });
    return operation;
}

- (void)sendRequest:(XJBaseRequest *)request;
{
    
    //1、准备好AFHTTPSessionManager;
    //2、根据请求方式发起请求;
    //3、回调、错误的处理;
    AFHTTPSessionManager *sessionManager = [self getSessionManager:request];
    NSString *requestUrlString = request.fullURLString;
    id parameters = request.parameters;
    NSURLSessionDataTask *task;//考虑记录到request;
    
    void (^success)(NSURLSessionDataTask * _Nonnull task,id resultObj) = ^(NSURLSessionDataTask * _Nonnull task,id resultObj){
        
        if (request.successBlock) {
            request.successBlock(resultObj);
        }
        
    };
    
    void (^failure)(NSURLSessionDataTask * _Nonnull task,NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nonnull task,NSError * _Nonnull error){
        
        if (request.failureBlock) {
            request.failureBlock(error);
        }
        
    };
    
    switch (request.method) {
        case GET:{
            task =  [sessionManager GET:requestUrlString parameters:parameters progress:nil success:success failure:failure];
        }
            
            break;
        case POST:{
            task =  [sessionManager POST:requestUrlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:success failure:failure];
            
        }
            
            break;
        case PUT:{
            task =  [sessionManager PUT:requestUrlString parameters:parameters success:success failure:failure];
        }
            
            break;
        case DELETE:{
            task =  [sessionManager DELETE:requestUrlString parameters:parameters  success:success failure:failure];
        }
            
            break;
        case PATCH:{
            task =  [sessionManager PATCH:requestUrlString parameters:parameters  success:success failure:failure];
        }
            
            break;
        default:
            break;
    }
    
}

- (AFHTTPSessionManager *)getSessionManager:(XJBaseRequest*)request;
{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [self getRequestSerializer:request];
    switch (request.responseType) {
        case XJResponseSerializerHTTP:
        {
            sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
            break;
        case XJResponseSerializerJSON:
        {
            sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        }
            break;
        case XJResponseSerializerXML:
        {
            sessionManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        }
            break;
        case XJResponseSerializerPLIST:
        {
            sessionManager.responseSerializer = [AFPropertyListResponseSerializer serializer];
        }
            break;
        default:
        {
            sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
            break;
    }
    //后续考虑也放到request里面;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    return sessionManager;
}

- (AFHTTPRequestSerializer *)getRequestSerializer:(XJBaseRequest*)request;
{
    AFHTTPRequestSerializer *requestSerializer;
    switch (request.requestType) {
        case XJRequestSerializerHTTP:
            requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case XJRequestSerializerJSON:
            requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case XJRequestSerializerPLIST:
            requestSerializer = [AFPropertyListRequestSerializer serializer];
            break;
        default:
            requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
    }
    /***添加请求头相关设置****/
    requestSerializer.timeoutInterval = request.timeOutInterval;
    return requestSerializer;
    
}
@end