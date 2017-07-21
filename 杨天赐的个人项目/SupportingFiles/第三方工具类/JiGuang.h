//
//  JiGuang.h
//  杨天赐的个人项目
//
//  Created by yang on 2017/2/14.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JiGuang : NSObject

//注册极光短信
-(void)StartJiGuangSMS;

//获取短信验证码
-(void)JiGuang_SendTextMessageWithPhoneNumber:(NSString*)PN Success:(void(^)(id result))success Fail:(void(^)(NSError *error))fail;

//获取语音验证码
-(void)JiGuang_SendVoiceMessageWithPhoneNumber:(NSString*)PN Success:(void(^)(id result))success Fail:(void(^)(NSError *error))fail;

//验证码是否正确
-(void)JiGuang_GetBoolWithPhoneNumber:(NSString*)PN Code:(NSString*)code Success:(void(^)(id result))success Fail:(void(^)(NSError *error))fail;

//设置短信间隔
@property (assign, nonatomic) NSInteger SMSInterval;






@end
