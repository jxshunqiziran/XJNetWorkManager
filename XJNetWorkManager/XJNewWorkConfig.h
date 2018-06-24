//
//  XJNewWorkConfig.h
//  XJNetWorkManager-Example
//
//  Created by 江鑫 on 2018/5/12.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XJHttpConfigDlegate<NSObject>

- (id) uploadAPIError:(NSString*)api statusCode:(NSInteger)statusCode params:(id)params response:(id)response;

@end

@interface XJNewWorkConfig : NSObject

/************请求baseURL************/
@property (nonatomic, copy)  NSString *baseUrl;

/************是否打印请求日志*********/
@property (nonatomic, assign) BOOL isShowRequestLog;

/***********是否上传错误API**********/
@property (nonatomic, assign) BOOL isUploadErrorAPI;

/***********NO:正式环境;YES:测试环境**********/
@property (nonatomic, assign) BOOL isDebugEnvironment;

@property (nonatomic,assign) id<XJHttpConfigDlegate>delegate;

+ (XJNewWorkConfig*)shareManager;

- (void) configBaseURL:(NSString*)URL debugBaseURL:(NSString*)debugUrl isShowRequestLog:(BOOL)showlog uploadErrorAPI:(BOOL)isUpload httpDlegate:(id)delegate;

@end
