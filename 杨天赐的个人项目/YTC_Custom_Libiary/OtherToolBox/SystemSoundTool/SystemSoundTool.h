//
//  SystemSoundTool.h
//  杨天赐的个人项目
//
//  Created by yang on 17/1/17.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemSoundTool : NSObject

//不带震动版本
+(void)PlaySystemSoundWithSoundsID:(NSInteger)ID;

//带震动版本
+(void)PlayAlertSoundWithSoundsID:(NSInteger)ID;

//通过文件名播放包内音频
+(void)PlaySoundsWithFileName:(NSString*)fileName isDispose:(BOOL)isdispose;

@end
