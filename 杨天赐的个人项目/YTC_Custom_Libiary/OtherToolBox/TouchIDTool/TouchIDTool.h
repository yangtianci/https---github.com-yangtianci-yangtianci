//
//  TouchIDTool.h
//  杨天赐的个人项目
//
//  Created by yang on 17/1/17.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 状态一 : 弹出提示框-只能选择验证或者取消验证
 状态二 : 验证失败提示框-只能取消验证或者或者重新验证或者其他
 
 */

@interface TouchIDTool : NSObject

/*
 如果不能使用此功能,读取这里的错误信息
 */
@property (strong, nonatomic) NSError *UseError;

/*
 使用Touch的原因
 */
@property (copy, nonatomic) NSString *Reson;

/*
 解锁时左方按钮
 */
@property (copy, nonatomic) NSString *ButtonTitle;


-(BOOL)isCanUse;

-(void)CheckTouchIDWithSuccess:(void(^)())successBlock Fail:(void(^)(NSError *CheckError))failBlock;

@end

//关键点所在,验证成功只有一种,验证失败有很多种,需要根据错误类型判断

/**
 
 typedef NS_ENUM(NSInteger, LAError)
 {
 /// Authentication was not successful, because user failed to provide valid credentials.
 LAErrorAuthenticationFailed = kLAErrorAuthenticationFailed, //验证失败
 
 /// Authentication was canceled by user (e.g. tapped Cancel button).
 LAErrorUserCancel           = kLAErrorUserCancel, //用户取消验证
 
 /// Authentication was canceled, because the user tapped the fallback button (Enter Password).
 LAErrorUserFallback         = kLAErrorUserFallback, //用户选择了另一个按钮
 
 /// Authentication was canceled by system (e.g. another application went to foreground).
 LAErrorSystemCancel         = kLAErrorSystemCancel, //系统取消验证-其他app切入
 
 /// Authentication could not start, because passcode is not set on the device.
 LAErrorPasscodeNotSet       = kLAErrorPasscodeNotSet, //未设置密码
 
 /// Authentication could not start, because Touch ID is not available on the device.
 LAErrorTouchIDNotAvailable  = kLAErrorTouchIDNotAvailable, //设备touchId不可用 - 未打开
 
 /// Authentication could not start, because Touch ID has no enrolled fingers.
 LAErrorTouchIDNotEnrolled = kLAErrorTouchIDNotEnrolled, //设备touchId不可用-未注册
 
 /// Authentication was not successful, because there were too many failed Touch ID attempts and
 /// Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating
 /// LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
 LAErrorTouchIDLockout   NS_ENUM_AVAILABLE(10_11, 9_0) __WATCHOS_AVAILABLE(3.0) __TVOS_AVAILABLE(10.0) = kLAErrorTouchIDLockout, //touchId锁定状态
 
 /// Authentication was canceled by application (e.g. invalidate was called while
 /// authentication was in progress).
 LAErrorAppCancel        NS_ENUM_AVAILABLE(10_11, 9_0) = kLAErrorAppCancel,
 //touchId取消-app取消
 
 /// LAContext passed to this call has been previously invalidated.
 LAErrorInvalidContext   NS_ENUM_AVAILABLE(10_11, 9_0) = kLAErrorInvalidContext
 } NS_ENUM_AVAILABLE(10_10, 8_0) __WATCHOS_AVAILABLE(3.0) __TVOS_AVAILABLE(10.0);


 
 */



