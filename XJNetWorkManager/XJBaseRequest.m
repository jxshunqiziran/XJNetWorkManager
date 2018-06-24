//
//  XJBaseRequest.m
//  XJNetWorkManager-Example
//
//  Created by 江鑫 on 2018/5/11.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJBaseRequest.h"
#import "XJHttpManager.h"

@implementation XJBaseRequest

- (void) sendHttpRequstSuccessBlock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;
{
    
    [[XJHttpManager shareManager]configBaseRequest:self completionSuccessblock:successBlock completionFailblock:failblock];
    
}

- (void) cancleRequest;
{
    
    @synchronized(self){
        
        if (self.requestTask) {
            [self.requestTask cancel];
        }
        
    }

}


- (void) reUploadImagesUploadIndexProgress:(XJSynUploadImagesDetailProgressBlock)progressblock completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;
{
    
    [[XJHttpManager shareManager]xj_synUploadImageArrayDetail:self uploadIndexProgress:progressblock completionSuccessblock:successBlock completionFailblock:failblock];
    
}

@end
