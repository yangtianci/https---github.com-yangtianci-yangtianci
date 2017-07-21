//
//  AppDelegate.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/5.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "AppDelegate.h"
#import "YTC_TabbarController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "JiGuang.h"
#import "AppDelegate+JPush.h"

//讯飞头文件
#import "iflyMSC/iflyMSC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    #pragma mark - ---------- 修改界面入口 ----------
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    YTC_TabbarController *rootTabbarC = [[YTC_TabbarController alloc]init];
    
    self.window.rootViewController = rootTabbarC;
    
    [self.window makeKeyWindow];
    
    //开启友盟分享工具
    UMeng *umeng = [[UMeng alloc]init];
    [umeng StartShare];
    //开启友盟统计工具
    [umeng StartStatistics];
    //开启极光短信
    JiGuang *jg = [[JiGuang alloc]init];
    [jg StartJiGuangSMS];
    //开启极光推送
    [self CreatAPNs];
    [self CreatJPushWithLunchOption:launchOptions];
    //注册小红点
    ApplicationTool *tool = [[ApplicationTool alloc]init];
    [tool RegistRedPoint];
    //开启讯飞语音
    NSString *iflyIDStr = @"appid=58b62355";
    [IFlySpeechUtility createUtility:iflyIDStr];
    
    return YES;
}




//切换控制器方法
-(void)SwitchKeyWindowWithController:(UIViewController *)controller{
    
    self.window.rootViewController = controller;
    
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
