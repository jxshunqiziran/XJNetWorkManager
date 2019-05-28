//
//  XJRequestOperation.h
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/21.
//  Copyright © 2019年 XJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XJRequestOperation : NSObject

+ (instancetype)shareOperation;

- (void)sendRequest:(XJBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
