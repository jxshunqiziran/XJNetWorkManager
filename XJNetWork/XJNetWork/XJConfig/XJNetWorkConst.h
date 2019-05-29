//
//  XJNetWorkConst.h
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/22.
//  Copyright © 2019年 XJ. All rights reserved.
//

#ifndef XJNetWorkConst_h
#define XJNetWorkConst_h
@class  XJBaseRequest;

#define Weakly(weakSelf) __weak typeof(self) weakSelf = self;
#define Strongly(strongSelf) __strong typeof(weakSelf) strongSelf = weakSelf;

//请求的方式类型:
typedef NS_ENUM (NSUInteger,XJRequestSendType){
    POST = 0,
    GET = 1,
    HEAD = 2,
    PUT = 3,
    PATCH = 4,
    DELETE = 5
};

//请求参数编码的序列化器:
typedef NS_ENUM(NSInteger,XJResponseSerializer)
{
    XJResponseSerializerHTTP,
    XJResponseSerializerJSON,
    XJResponseSerializerPLIST,
    XJResponseSerializerXML,
};

//返回内容编码的序列化器:
typedef NS_ENUM(NSInteger,XJRequestSerializer)
{
    XJRequestSerializerHTTP,
    XJRequestSerializerJSON,
    XJRequestSerializerPLIST,
    XJRequestSerializerXML,
};

typedef void(^XJRequestCallbackBlock)(XJBaseRequest* __nonnull request, id __nullable responseObject, NSError * __nullable error);

#endif /* XJNetWorkConst_h */
