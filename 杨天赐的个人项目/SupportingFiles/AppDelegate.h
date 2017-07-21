//
//  AppDelegate.h
//  杨天赐的个人项目
//
//  Created by yang on 16/12/5.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)SwitchKeyWindowWithController:(UIViewController*)controller;

@end

