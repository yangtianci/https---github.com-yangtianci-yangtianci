//
//  TouchIDTool.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/17.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "TouchIDTool.h"

#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIDTool ()

//私有对象
@property (strong, nonatomic) LAContext *Context;


@end

@implementation TouchIDTool

#pragma mark - ---------- 方法-是否可以使用此功能 ----------

-(BOOL)isCanUse{
    self.Context = [[LAContext alloc]init];
    NSError *useError = nil;
    BOOL canUse = [self.Context canEvaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics error:&useError];
    if (canUse) {
        return YES;
    }else{
        self.UseError = useError;
        return NO;
    }
}

#pragma mark - ---------- 方法-验证指纹 ----------
-(void)CheckTouchIDWithSuccess:(void (^)())successBlock Fail:(void (^)(NSError *))failBlock{
    if (self.Reson.length == 0) {
        self.Reson = @"使用TouchID的理由";
    }
    if (self.ButtonTitle.length > 0) {
        self.Context.localizedFallbackTitle = self.ButtonTitle;
    }
    [self.Context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:self.Reson reply:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            successBlock();
        }else{
            failBlock(error);
        }
    }];
}



/**
 
 NSLog(@"%@",error.localizedDescription);
 switch (error.code) {
 case LAErrorSystemCancel:
 {
 NSLog(@"Authentication was cancelled by the system");
 //切换到其他APP，系统取消验证Touch ID
 break;
 }
 case LAErrorUserCancel:
 {
 NSLog(@"Authentication was cancelled by the user");
 //用户取消验证Touch ID
 break;
 }
 case LAErrorUserFallback:
 {
 NSLog(@"User selected to enter custom password");
 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
 //用户选择其他验证方式，切换主线程处理
 }];
 break;
 }
 default:
 {
 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
 //其他情况，切换主线程处理
 }];
 break;
 }
 }
 
 
 switch (error.code) {
 case LAErrorTouchIDNotEnrolled:
 {
 NSLog(@"TouchID is not enrolled");
 break;
 }
 case LAErrorPasscodeNotSet:
 {
 NSLog(@"A passcode has not been set");
 break;
 }
 default:
 {
 NSLog(@"TouchID not available");
 break;
 }
 }
 
 
 */



@end
