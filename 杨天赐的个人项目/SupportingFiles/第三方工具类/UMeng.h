//
//  UMeng.h
//  杨天赐的个人项目
//
//  Created by yang on 2017/2/9.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UMSocialCore/UMSocialCore.h>

/**
 
 集成友盟第三方功能
 1.三方分享
 
 */

@interface UMeng : NSObject

/**
 友盟三方分享
 */

//开启分享功能 - 用于application初始化
-(void)StartShare;

//分享
-(void)UShareWithPlatform:(UMSocialPlatformType)platformType Success:(void(^)(NSError *error))success Fail:(void(^)(id data))fail;

//三方登录

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType Success:(void(^)(NSError *error))success Fail:(void(^)(id data))fail;


//友盟统计
- (void)StartStatistics;
    




@end
