//
//  XJNewWorkConfig.m
//  XJNetWorkManager-Example
//
//  Created by 江鑫 on 2018/5/12.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJNewWorkConfig.h"

@interface XJNewWorkConfig()

@end

@implementation XJNewWorkConfig

+ (XJNewWorkConfig*)shareManager
{
    
    static XJNewWorkConfig *sharemanager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharemanager) {
            
            sharemanager = [[XJNewWorkConfig alloc]init];
            
        }
    });
    return sharemanager;
    
}

- (void) configBaseURL:(NSString*)URL debugBaseURL:(NSString*)debugUrl isShowRequestLog:(BOOL)showlog uploadErrorAPI:(BOOL)isUpload httpDlegate:(id)delegate;
{
    
    //1,baseUrl;
    self.baseUrl = URL;
    
    //2,是否打印请求url;
    self.isShowRequestLog = showlog;
    
    //3,是否上传错误报告;
    self.isUploadErrorAPI = isUpload;
    
    //4,错误回调代理:
    self.delegate = delegate;
    
}

@end
