//
//  ApplicationTool.m
//  杨天赐的个人项目
//
//  Created by yang on 2017/2/16.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "ApplicationTool.h"

@interface ApplicationTool ()



@end

@implementation ApplicationTool

#pragma mark - ---------- 消息红点功能 ----------

-(void)RegistRedPoint{
    UIUserNotificationSettings  *setting=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
}

-(void)setRedPointCount:(NSInteger)RedPointCount{
    _RedPointCount = RedPointCount;
    [UIApplication  sharedApplication].applicationIconBadgeNumber = RedPointCount;
}


@end
