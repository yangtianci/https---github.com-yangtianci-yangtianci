//
//  BaseViewController.h
//  杨天赐的个人项目
//
//  Created by yang on 16/12/19.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//设置navbar背景图片
-(void)SetNavBarImageWithName:(NSString*)name;

//描述信息
@property (copy, nonatomic) NSString *DetialInformation;

//设置整体背景图
@property (copy, nonatomic) NSString *BGImageName;

//是否隐藏tabbar //默认执行
@property (assign, nonatomic) BOOL showTabbar;

//展示提示框
-(void)ShowMessage:(NSString*)message;

@end
