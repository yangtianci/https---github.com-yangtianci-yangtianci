//
//  AppDelegate+JPush.h
//  杨天赐的个人项目
//
//  Created by yang on 2017/2/17.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "AppDelegate.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (JPush)<JPUSHRegisterDelegate>

//初始化APNs
-(void)CreatAPNs;

//初始化JPush
-(void)CreatJPushWithLunchOption:(NSDictionary*)lunchOption;

@end
