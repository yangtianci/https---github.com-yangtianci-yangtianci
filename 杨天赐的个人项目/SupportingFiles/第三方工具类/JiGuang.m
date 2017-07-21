//
//  JiGuang.m
//  杨天赐的个人项目
//
//  Created by yang on 2017/2/14.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "JiGuang.h"

#import "JSMSSDK.h"

@implementation JiGuang


//注册极光短信
-(void)StartJiGuangSMS{
    [JSMSSDK registerWithAppKey:@"57e2661cb42d674957ef74eb"];
    [JSMSSDK setMinimumTimeInterval:120];
}

//获取短信验证码
-(void)JiGuang_SendTextMessageWithPhoneNumber:(NSString*)PN Success:(void(^)(id result))success Fail:(void(^)(NSError *error))fail{
    
    [JSMSSDK getVerificationCodeWithPhoneNumber:PN andTemplateID:@"1" completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            success(resultObject);
        }else{
            fail(error);
        }
    }];

}

//获取语音验证码
-(void)JiGuang_SendVoiceMessageWithPhoneNumber:(NSString*)PN Success:(void(^)(id result))success Fail:(void(^)(NSError *error))fail{
    
    [JSMSSDK getVoiceVerificationCodeWithPhoneNumber:PN completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            success(resultObject);
        }else{
            fail(error);
        }
    }];
    
}

//验证码是否正确
-(void)JiGuang_GetBoolWithPhoneNumber:(NSString*)PN Code:(NSString*)code Success:(void(^)(id result))success Fail:(void(^)(NSError *error))fail{
    
    [JSMSSDK commitWithPhoneNumber:PN verificationCode:code completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            success(resultObject);
        }else{
            fail(error);
        }
    }];
    
}

-(void)setSMSInterval:(NSInteger)SMSInterval{
    _SMSInterval = SMSInterval;
    [JSMSSDK setMinimumTimeInterval:SMSInterval];
}

@end
