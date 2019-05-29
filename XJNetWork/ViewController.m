//
//  ViewController.m
//  XJNetWork
//
//  Created by 江鑫 on 2019/3/21.
//  Copyright © 2019年 XJ. All rights reserved.
//

#import "ViewController.h"
#import "XJNetWorkManager.h"
#import "XJBaseRequest.h"
#import "XJNetWorkConfig.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [XJNetWorkManager setupConfig:^(XJNetWorkConfig * _Nonnull config) {
        config.baseURL = @"http://bzsns.cn";
        config.isEnableLog = YES;
    }];
    
    [XJBaseRequest request].setAPI(@"api/app/check").setParameters(@{@"id":@"96377",@"type":@"activity"})
    .completionSuccessBlock(^(id  resultObject){
        
    })
    .completionFailureBlock(^(id reObj){
        
    }).startRequest;
    
}


@end
