//
//  XJBaseRequest.h
//  XJNetWorkManager-Example
//
//  Created by 江鑫 on 2018/5/11.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XJNewWorkHeader.h"


typedef NS_ENUM(NSInteger,XJRequestMethod)
{
    XJRequestMethodPOST,
    XJRequestMethodGET,
    XJRequestMethodPUT,
    XJRequestMethodDELETE,
    XJRequestMethodHEAD,
};

typedef void(^XJSuccessCompletionBlock)(id response);

typedef void(^XJFailCompletionBlock)(NSError* error,NSString*errormsg);

typedef void(^XJUploadImageSingleBlock)(CGFloat progress);

typedef void(^XJSynUploadImagesBlock)(CGFloat progress);

//多图片上传block: 上传到第几张、正在上传的那张的进度、上传的总进度:
typedef void(^XJSynUploadImagesDetailProgressBlock)(NSInteger index, CGFloat progress,CGFloat totalProgress);

typedef void(^XJAsynUploadImagesSuccessProgressBlock)(NSArray *resultArray);


@class  XJNetWorkManager;

@interface XJBaseRequest : NSObject

/*********请求方式********/
@property (nonatomic, assign) XJRequestMethod requestmethod;

/*********请求api********/
@property (nonatomic, copy) NSString* api;

/*********请求url********/
@property (nonatomic, copy) NSString* requestURL;

/*********请求参数********/
@property (nonatomic, strong) id params;

/*********请求结果状态码********/
@property (nonatomic, assign) NSInteger statsusCode;

/*********当前正在上传图片的索引********/
@property (nonatomic, assign) NSInteger currentUploadIndex;

/*********该请求的task任务********/
@property (nonatomic, strong) NSURLSessionTask *requestTask;

/*********超时时间********/
@property (nonatomic, assign) CGFloat timeoutInterval;

/*********请求返回结果********/
@property (nonatomic, strong) id response;

@property (nonatomic, assign) NSInteger totalUploadDataLength;

@property (nonatomic, assign) NSInteger currentUploadLength;

/*********上传图片的数组,里面是NSData********/
@property (nonatomic, strong) NSMutableArray *uploadImageArray;

@property (nonatomic, copy) XJSuccessCompletionBlock successBlock;

@property (nonatomic, copy) XJFailCompletionBlock failBlock;

@property (nonatomic, strong) NSData * uploadImageData;

@property (nonatomic, assign) BOOL isUploadErrorAPI;


- (void) sendHttpRequstSuccessBlock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;

- (void) cancleRequest;

- (void) reUploadImagesUploadIndexProgress:(XJSynUploadImagesDetailProgressBlock)progressblock completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;

@end
