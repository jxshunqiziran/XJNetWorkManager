//
//  XJBaseRequest.m
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/21.
//  Copyright © 2019年 XJ. All rights reserved.
//

#import "XJBaseRequest.h"
#import "XJNetWorkManager.h"
#import "XJNetWorkConfig.h"


@interface XJBaseRequest()
@property (nonatomic,copy,nullable) NSString *BaseURL;
@property (nonatomic,copy) NSString *api;
@property (nonatomic,copy,nullable) NSString *parameters;
@property (nonatomic,copy,nullable) NSString *customBaseURL;
@property (nonatomic,assign) XJRequestSendType method;
@property (nonatomic,copy) NSString *fullURLString;
@property (nonatomic,copy,nullable) NSString *customURL;
@property (nonatomic,assign) XJResponseSerializer responseType;
@property (nonatomic,assign) XJRequestSerializer requestType;
@property (nonatomic,assign) NSTimeInterval timeOutInterval;
@property (nonatomic,assign) BOOL isUseDefaultParameters;

@end

@implementation XJBaseRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /*****相关默认值****/
        _requestType = XJRequestSerializerHTTP;
        _responseType = XJResponseSerializerJSON;
        
    }
    return self;
}


+ (XJBaseRequest *)request;
{
    return [[self alloc]init];
}

- (XJBaseRequest *(^)(NSString *api))setAPI;
{
    return  ^XJBaseRequest * (NSString *api){
        self.api = api;
        return self;
    };
}

- (XJBaseRequest *(^)(NSString *parameters))setParameters;
{
    return ^XJBaseRequest *(NSString *parameters){
        self.parameters = parameters;
        return self;
    };
}

- (XJBaseRequest *(^)(XJRequestSuccessBlock))completionSuccessBlock {
    return ^XJBaseRequest *(XJRequestSuccessBlock objBlock) {
        self.successBlock = objBlock;
        return self;
    };
}

- (XJBaseRequest *(^)(XJRequestFailureBlock successblock))completionFailureBlock;
{
    return ^XJBaseRequest *(XJRequestFailureBlock objBlock) {
        self.failureBlock = objBlock;
        return self;
    };
}

- (XJBaseRequest *)startRequest;
{
    [[XJNetWorkManager manager]sendRequest:self];
    return self;
}

- (XJBaseRequest *)stopRequest;
{
    return self;
}




/**
 请求的完整URL;
 */
- (NSString *)fullURLString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.customURL) {
            self->_fullURLString = self.customURL;
        }else{
            
            NSString *baseUrlString = self.customBaseURL?self.customBaseURL:[XJNetWorkConfig shareConfig].baseURL;
            
            self->_fullURLString = [NSString stringWithFormat:@"%@/%@",baseUrlString,self.api];
        }
    });
    return _fullURLString;
}

@end
