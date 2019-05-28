//
//  XJNetWorkManager.h
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/21.
//  Copyright © 2019年 XJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XJBaseRequest;
@class XJNetWorkConfig;

NS_ASSUME_NONNULL_BEGIN

@interface XJNetWorkManager : NSObject

@property (nonatomic, strong) XJNetWorkConfig *config;

+ (instancetype)manager;

- (void)sendRequest:(XJBaseRequest *)request;

+ (void)setupConfig:(void(^)(XJNetWorkConfig *config))configBlock;

@end

NS_ASSUME_NONNULL_END
