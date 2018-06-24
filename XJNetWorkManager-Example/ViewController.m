//
//  ViewController.m
//  XJNetWorkManager-Example
//
//  Created by 江鑫 on 2018/5/11.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "ViewController.h"
#import "XJNetWorkManager.h"
#import "XJHttpManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSString *uid = @"96377";
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    NSString *dateStr = [NSString stringWithFormat:@"%lld",date];
    NSString *device = @"ios";
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:uid forKey:@"uid"];
    [param setObject:@"1529399446" forKey:@"t"];
    [param setObject:device forKey:@"device"];
    [param setObject:@"RSA" forKey:@"sign_type"];
    [param setObject:@"3.0.3" forKey:@"v"];
    [param setObject:@"mqi9477YUDE+wtPI0VyDqmmFMl2G/oetSAr/Nj8X9wpr3voaWQIhfbWPb20uq2J/qle4xvI+M71mHU1yvImJLT9KawVBTLQtMKYkHFy4Ejn0+n5xAiqh3z3hleLxnC/pC/VYelW86TLkIUL3Kd3UuiTZo3CIB1pyI+XGr+AXiqo=" forKey:@"sign"];
    
    UIImage *image1 = [UIImage imageNamed:@"SDWebImageClassDiagram.png"];
    UIImage *image2 = [UIImage imageNamed:@"SDWebImageClassDiagram.png"];
    UIImage *image3 = [UIImage imageNamed:@"SDWebImageClassDiagram.png"];
    UIImage *image4 = [UIImage imageNamed:@"SDWebImageClassDiagram.png"];
    NSData *data1 = UIImageJPEGRepresentation(image1, 1);
    NSData *data2 = UIImageJPEGRepresentation(image2, 1);
    NSData *data3 = UIImageJPEGRepresentation(image3, 1);
    NSData *data4 = UIImageJPEGRepresentation(image4, 1);
    
//    [XJNetWorkManager xj_uploadImageWithUrl:@"api/upload/img" uploadData:data parameter:param progressBlock:^(CGFloat progress) {
//
//    } completionSuccessblock:^(id response) {
//
//    } completionFailblock:^(NSError *error, NSString *errormsg) {
//
//    }];
    
  
    [[XJHttpManager shareManager] xj_asyUploadImageArray:@[data1,data2,data3,data4] url:@"api/upload/img" parameter:param completionSuccessblock:^(NSArray *resultArray) {
        
    } completionFailblock:^(NSError *error, NSString *errormsg) {
        
    }];
    
   
    
    
//    NSDictionary*dic = @{@"item_model":@"0",@"item_type":@"all",@"sign":@"LQbS4xhezyLawFzurGRwEwSsUTee5vJILhzatX2WhPpNCQHafD8aSWp6XHo/TXoUNnu50OsZqcGkZgItq/lTOJ6sS5T8r8Te8NuryEjvc1Ewyt7U/cHpDNiI3JH7ktlVNxLtHNyWtoaJWxGKkjYUSnzhMCshArTyJquCEgR33VI%3D",@"sign_type":@"RSA",@"uid":@"96377",@"v":@"3.0.2"};
//
//    [XJNetWorkManager xj_PostRequestWithURL:@"api/topic/list" parameter:dic successBlock:^(id response) {
//
//    } failBlock:^(NSString *failMessage) {
//
//    }];
    
    
}






/*
{
    "item_model" = 0;
    "item_type" = all;
    sign = "gPWzKIyeAGkFXhZxUlknIk+fJknP02UPoVbUm3Jx//XqI0cw+Ro2Nk5wzKeB8YOBfkA1T8hwnyTQh3cpIb0jLmyMcbShu/wchrJgM0ygX2Z9neFZz2C5HS35Ift/zGgmhb8RjtsVqUbTOrjEC0aEmwGwqou785bltXAbWMhSMQs=";
    "sign_type" = RSA;
    uid = 30370811;
    v = "3.0.0";
}
2018-05-14 15:51:19.372233+0800 cowork[25223:1223898] ------http://test.bzsns.cn//api/topic/list?item_model=0&item_type=all&sign=gPWzKIyeAGkFXhZxUlknIk%2BfJknP02UPoVbUm3Jx//XqI0cw%2BRo2Nk5wzKeB8YOBfkA1T8hwnyTQh3cpIb0jLmyMcbShu/wchrJgM0ygX2Z9neFZz2C5HS35Ift/zGgmhb8RjtsVqUbTOrjEC0aEmwGwqou785bltXAbWMhSMQs%3D&sign_type=RSA&uid=30370811&v=3.0.0
 */




//{
//    "item_model" = 0;
//    "item_type" = all;
//    sign = "LQbS4xhezyLawFzurGRwEwSsUTee5vJILhzatX2WhPpNCQHafD8aSWp6XHo/TXoUNnu50OsZqcGkZgItq/lTOJ6sS5T8r8Te8NuryEjvc1Ewyt7U/cHpDNiI3JH7ktlVNxLtHNyWtoaJWxGKkjYUSnzhMCshArTyJquCEgR33VI=";
//    "sign_type" = RSA;
//    uid = 96377;
//    v = "3.0.2";
//}
//2018-06-07 09:58:42.082537+0800 cowork[9936:103374] ------

//http://fyj.estt.com.cn/api/topic/list?item_model=0&item_type=all&sign=LQbS4xhezyLawFzurGRwEwSsUTee5vJILhzatX2WhPpNCQHafD8aSWp6XHo/TXoUNnu50OsZqcGkZgItq/lTOJ6sS5T8r8Te8NuryEjvc1Ewyt7U/cHpDNiI3JH7ktlVNxLtHNyWtoaJWxGKkjYUSnzhMCshArTyJquCEgR33VI%3D&sign_type=RSA&uid=96377&v=3.0.2

@end
