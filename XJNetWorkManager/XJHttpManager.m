//
//  XJHttpManager.m
//  XJNetWorkManager-Example
//
//  Created by 江鑫 on 2018/5/12.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJHttpManager.h"
#import "AFNetworking.h"
#import "XJNewWorkConfig.h"

@interface XJHttpManager()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray<XJBaseRequest *> * allRequestArray;

@end

@implementation XJHttpManager

+ (XJHttpManager*)shareManager
{
    
    static XJHttpManager *sharemanager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharemanager) {
            
            sharemanager = [[XJHttpManager alloc]init];
            
        }
    });
    return sharemanager;
    
}

- (id) init
{
    self = [super init];
    if (self) {
        
        //待优化,可依据库外配置,暂时写死:
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 30.f;//默认时间;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/xml", @"text/plain", @"application/javascript", @"application/x-www-form-urlencoded", @"image/*", nil];
        _manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
       
    }
    
    return self;
    
    
}


/**
 根据request发起请求,包括get、post、delete、put...并处理相应返回结果:
 **/
- (void) configBaseRequest:(XJBaseRequest*)request completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;
{

    //是否打印请求log日志:
    [self logapi:request.api param:request.params];
    
    request.requestURL = [NSString stringWithFormat:@"%@%@",[XJNewWorkConfig shareManager].baseUrl,request.api];
    
    switch (request.requestmethod) {
        case XJRequestMethodGET:
        {
            
            request.requestTask = [self.manager GET:request.requestURL parameters:request.params progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self handleResponseTask:task isSuccess:YES baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failblock)failblock(error,nil);
                [self handleResponseTask:task isSuccess:NO baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:nil];
                
            }];
        }
            break;
        case XJRequestMethodPOST:
        {
            request.requestTask = [self.manager POST:request.requestURL parameters:request.params progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self handleResponseTask:task isSuccess:YES baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            if(failblock)failblock(error,nil);
                [self handleResponseTask:task isSuccess:NO baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:nil];
                
            }];
        }
            break;
        case XJRequestMethodDELETE:
        {
            request.requestTask = [self.manager DELETE:request.requestURL parameters:request.params  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self handleResponseTask:task isSuccess:YES baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            if(failblock)failblock(error,error.localizedDescription);
                [self handleResponseTask:task isSuccess:NO baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:nil];
                
            }];
        }
            break;
        case XJRequestMethodHEAD:
        {
            request.requestTask = [self.manager HEAD:request.requestURL parameters:request.params success:^(NSURLSessionDataTask * _Nonnull task) {
                
               [self handleResponseTask:task isSuccess:YES baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:nil];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failblock)failblock(error,nil);
                [self handleResponseTask:task isSuccess:NO baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:nil];
                
            }];
            

        }
            break;
        case XJRequestMethodPUT:
        {
            request.requestTask = [self.manager PUT:request.requestURL parameters:request.params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self handleResponseTask:task isSuccess:YES baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failblock)failblock(error,error.localizedDescription);
                [self handleResponseTask:task isSuccess:NO baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:nil];
                
            }];
        }
            break;
        default:
            break;
    }
    
    
    [self.allRequestArray addObject:request];
    
    
}


/**
 处理请求返回的结果:
 **/
- (void) handleResponseTask:(NSURLSessionTask*)task isSuccess:(BOOL)isSuccess baseRequest:(XJBaseRequest*)request SuccessBlock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock response:(id)responseObject;
{
    
    
    if (isSuccess) {

        //根据不同的响应类型,需要解析不同的返回,json,xml,http,待添加...
        NSError *dataError;
        NSObject *resultObecjt = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&dataError];
        
        if (!dataError) {
            
           NSError *resultError  = [self validateResponseObjectFormat:resultObecjt];
            
            if (resultError) {
                if (failblock) failblock(resultError,resultError.localizedDescription);
            }else{
                NSDictionary *jsondic = (NSDictionary *)resultObecjt;
                NSObject *resultSuccessObecjt = jsondic[@"data"];
                if (successBlock)successBlock(resultSuccessObecjt);
            }
            
        }else{
            
            //返回数据格式无法解析:
            NSDictionary * userInfo = [NSDictionary dictionaryWithObject:@"返回数据异常,无法解析" forKey:NSLocalizedDescriptionKey];
            NSError * aError = [NSError errorWithDomain:XJRequestErrorDomain code:XJResponseErrorCodeUnknow userInfo:userInfo];
            failblock(aError,aError.localizedDescription);
            
        }
        
        
    }else{
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        request.response = response;
        request.statsusCode = response.statusCode;//并非error.code
        
        //需要将错误上报服务器:
        if (!request.isUploadErrorAPI && [XJNewWorkConfig shareManager].isUploadErrorAPI) {
             [self uploadAPIError:request];
        }
        
    }
    
    [self.allRequestArray removeObject:request];
    
}


/**
 验证成功返回结果的格式

 @param responseObject 返回数据
 @return error
 */
- (NSError*) validateResponseObjectFormat:(id)responseObject
{
    
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *jsondic = (NSDictionary *)responseObject;
        NSString *result = jsondic[@"result"];
        
        //返回正确的格式;
        if (result.integerValue == 1) {
            
            return nil;
            
        }else{
            
            //构建XJRequest NSError;
            NSDictionary *errorDic = jsondic[@"error"];
            NSString *msg = errorDic[@"msg"];
            NSInteger errorNum = [errorDic[@"code"]integerValue];
            NSDictionary * userInfo = [NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey];
            NSError * aError = [NSError errorWithDomain:XJRequestErrorDomain code:errorNum userInfo:userInfo];
            return aError;
            
        }
        
    }
    
    return nil;
    
}

- (NSString*) httpMethodTransform:(XJRequestMethod)method
{
    switch (method) {
        case XJRequestMethodPOST:
            return @"POST";
            break;
        case XJRequestMethodGET:
            return @"GET";
            break;
        case XJRequestMethodHEAD:
            return @"HEAD";
            break;
        case XJRequestMethodPUT:
            return @"PUT";
            break;
        case XJRequestMethodDELETE:
            return @"DELETE";
            break;
        default:
            break;
    }
    
}



/**同步上传多图片:
*该方式不能获取具体上传到哪一张图片,以及每张图片的上传进度,只能知道上传的总进度额;
 而且上传过程中失败后需重新开始上传所有;
 */
- (void) xj_uploadImageArray:(XJBaseRequest*)request progressBlock:(XJSynUploadImagesBlock)progressBlock completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;
{
    
    request.requestURL = [NSString stringWithFormat:@"%@%@",[XJNewWorkConfig shareManager].baseUrl,request.api];
    
    [self.manager POST:request.requestURL parameters:request.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSData*imagedata in request.uploadImageArray) {
            [formData appendPartWithFileData:imagedata name:[NSString stringWithFormat:@"xjimage-%ld",[request.uploadImageArray indexOfObject:imagedata]] fileName:@"file" mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //回到主线程,以便外部直接刷新UI:
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (progressBlock) {
                progressBlock(uploadProgress.fractionCompleted);
            }
            
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self handleResponseTask:task isSuccess:YES baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
       [self handleResponseTask:task isSuccess:NO baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:nil];
        
    }];

    [self.allRequestArray addObject:request];
    
}


//总进度,上传到哪张图片了,上传那张图片的进度;
- (void) xj_synUploadImageArrayDetail:(XJBaseRequest*)request uploadIndexProgress:(XJSynUploadImagesDetailProgressBlock)progressblock completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;
{
    
    if (!request.requestURL) {
        request.requestURL = [NSString stringWithFormat:@"%@%@",[XJNewWorkConfig shareManager].baseUrl,request.api];
    }

    if (!request.totalUploadDataLength) {
        for (NSData*data in request.uploadImageArray) {
            request.totalUploadDataLength += data.length;
        }
    }
    
    [self.manager POST:request.requestURL parameters:request.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData*imagedata = request.uploadImageArray[request.currentUploadIndex];
            
        [formData appendPartWithFileData:imagedata name:[NSString stringWithFormat:@"xjimage-%ld",request.currentUploadIndex] fileName:@"file" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //回到主线程,以便外部直接刷新UI:
        dispatch_async(dispatch_get_main_queue(), ^{
            
         CGFloat currentProgress = uploadProgress.fractionCompleted;
         
         request.currentUploadLength += uploadProgress.completedUnitCount;
    progressblock(request.currentUploadIndex,currentProgress,request.currentUploadLength/request.totalUploadDataLength);
            
            
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        request.currentUploadIndex +=1;
        
        if (request.currentUploadIndex == request.uploadImageArray.count) {
            
            if (successBlock) successBlock(responseObject);
            
            //调用成功的block:
            [self.allRequestArray removeObject:request];
            
        }else{
            
          [self xj_synUploadImageArrayDetail:request uploadIndexProgress:progressblock completionSuccessblock:successBlock completionFailblock:failblock];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    if (request.currentUploadIndex == 0) {
        [self.allRequestArray addObject:request];
    }
    
    
}


- (void) xj_asyUploadImageArray:(NSArray*)imageDataArray url:(NSString*)url parameter:(id)parameter completionSuccessblock:(XJAsynUploadImagesSuccessProgressBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;
{
    
    __block  CGFloat currentUploadSize = 0.0f;
    
    __block CGFloat allUploadSize = 0.0f;
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:imageDataArray.count];
    for (int i = 0; i < imageDataArray.count; i++) {
        [resultArray addObject:[NSNull null]];
        NSData *data = imageDataArray[i];
        allUploadSize += data.length;
    }
    
    //同步多线程:
    dispatch_group_t group = dispatch_group_create();

    for (int i = 0 ; i < imageDataArray.count;i++) {
        
        NSData* data  = imageDataArray[i];
       
        dispatch_group_enter(group);
            XJBaseRequest *request = [[XJBaseRequest alloc]init];
            request.uploadImageData = data;
            request.api = url;
            request.params = parameter;
            request.currentUploadIndex = i;
            
            [self xj_uploadImage:request progressBlock:^(CGFloat progress) {
                
                
//                NSLog(@"vv--%d---%f--%@",i,progress,[NSThread currentThread]);
                @synchronized(self){
                    currentUploadSize += progress*(request.uploadImageData.length);
                    NSLog(@"BB--%d--%f",i,currentUploadSize);
//                    NSLog(@"kk----%f",currentUploadSize/allUploadSize);
                }

                
            } completionSuccessblock:^(id response) {
                
                dispatch_group_leave(group);
                resultArray[request.currentUploadIndex] = response;
                
            } completionFailblock:^(NSError *error, NSString *errormsg) {
                
                if (failblock) {
                    failblock(error,errormsg);
                }
                
            }];
      
        
    }
    
    //所有图片上传完毕,按照数组内图片索引返回图片返回数据:
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        if (successBlock) {
            successBlock(resultArray);
        }
        
    });
    
}


/**
 单张图片上传

 @param request baseRequest
 @param progressBlock 进度
 @param successBlock 成功回调
 @param failblock 失败回调
 */
- (void) xj_uploadImage:(XJBaseRequest*)request progressBlock:(XJUploadImageSingleBlock)progressBlock completionSuccessblock:(XJSuccessCompletionBlock)successBlock completionFailblock:(XJFailCompletionBlock)failblock;
{
//    NSLog(@"BB----%lu",(unsigned long)request.uploadImageData.length);
    
    if (!request.requestURL) {
        request.requestURL = [NSString stringWithFormat:@"%@%@",[XJNewWorkConfig shareManager].baseUrl,request.api];
    }
    
    [self.manager POST:request.requestURL parameters:request.params  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //focus on the name and fileName:
        [formData appendPartWithFileData:request.uploadImageData name:[NSString stringWithFormat:@"file"] fileName:@"1.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //回到主线程,以便外部直接刷新UI:
        dispatch_async(dispatch_get_main_queue(), ^{
        
            if (progressBlock) {
                progressBlock(uploadProgress.fractionCompleted);
            }
            
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
           [self handleResponseTask:task isSuccess:YES baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

           [self handleResponseTask:task isSuccess:NO baseRequest:request SuccessBlock:successBlock completionFailblock:failblock response:nil];
        
    }];
    
    [self.allRequestArray addObject:request];
    
    
}



/**
 提交错误日志报告:

 @param request baseRequest
 */
- (void) uploadAPIError:(XJBaseRequest*)request
{
    
    id params = nil;
    
    if ([XJNewWorkConfig shareManager].delegate && [[XJNewWorkConfig shareManager].delegate respondsToSelector:@selector(uploadAPIError:statusCode:params:response:)]) {
        
       params =  [[XJNewWorkConfig shareManager].delegate uploadAPIError:request.api statusCode:request.statsusCode params:request.params response:request.response];
        
    }
    
    XJBaseRequest *errorRequest = [[XJBaseRequest alloc]init];
    errorRequest.isUploadErrorAPI = YES;
    errorRequest.api = request.api;
    errorRequest.requestmethod = XJRequestMethodPOST;
    errorRequest.params = params;
    [self configBaseRequest:errorRequest completionSuccessblock:nil completionFailblock:nil];
    
    
}



/**
 打印请求日志:

 @param privateUrl 请求url;
 @param dic 参数;
 */
- (void) logapi:(NSString *)privateUrl param:(NSDictionary *)dic
{
    
  if ([XJNewWorkConfig shareManager].isShowRequestLog) {
        
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        NSMutableArray  *arr = [NSMutableArray new];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *keystr = [NSString stringWithFormat:@"%@=%@",key,obj];
            [arr addObject:keystr];
        }];
        NSString *allstr = [arr componentsJoinedByString:@"&"];
        
        NSString *URLString = [NSString stringWithFormat:@"%@%@", [XJNewWorkConfig shareManager].baseUrl, privateUrl];
        
        if ([privateUrl containsString:@"http://"] || [privateUrl containsString:@"https://"])
        {
            URLString = privateUrl;
        }
        NSLog(@"XJRequestLog:---->>>>%@?%@",URLString,allstr);
        
            
    });
        
    }
    
}


/**
 取消当前的所有请求:
 */
- (void) cancleAllRequest;
{
    
    @synchronized(self){
        
        [self.allRequestArray enumerateObjectsUsingBlock:^(XJBaseRequest * _Nonnull request, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [request.requestTask cancel];
            
        }];
        
    }
    
}

/**
 获取当前所有请求task任务:

 */
- (NSArray<NSURLSessionTask*>*) allCurrentSessionTaskRequest;
{
    
    NSMutableArray * tempArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.allRequestArray enumerateObjectsUsingBlock:^(XJBaseRequest * _Nonnull request, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [tempArray addObject:request.requestTask];
        
    }];
    
    return tempArray;
    
}

/**
 获取当前所有请求的url:
 
 */
- (NSArray<NSString*>*) allCurrentURLRequest;
{
    
    NSMutableArray * tempArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.allRequestArray enumerateObjectsUsingBlock:^(XJBaseRequest * _Nonnull request, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [tempArray addObject:request.api];
        
    }];
    
    return tempArray;
    
    
}

/**
 获取所有当前的请求的baseRequest:
 
 */
- (NSArray<XJBaseRequest*>*) allCurrentBaseRequest;
{
    
    NSMutableArray * tempArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.allRequestArray enumerateObjectsUsingBlock:^(XJBaseRequest * _Nonnull request, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [tempArray addObject:request];
    }];
    
    return tempArray;
    
}

//- (AFHTTPSessionManager*) manager
//{
//    if (!_manager) {
//        _manager = [AFHTTPSessionManager manager];
//    }
//    return _manager;
//}

- (NSMutableArray<XJBaseRequest *> *)allRequestArray
{
    if (!_allRequestArray) {
        
        _allRequestArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _allRequestArray;
}

@end
