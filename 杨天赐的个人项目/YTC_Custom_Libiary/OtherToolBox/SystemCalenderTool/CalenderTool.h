//
//  CalenderTool.h
//  测试专用项目
//
//  Created by YangTianCi on 2017/7/27.
//  Copyright © 2017年 QianBuXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalenderTool : NSObject


+ (instancetype)manager;


//写入事件
//日历添加事件
-(void)AddCalenderWith:(NSString*)title Notes:(NSString*)note SDate:(NSDate*)sDate EDate:(NSDate*)eDate isAddAlarm:(BOOL)isAlarm CallBack:(void(^)(BOOL isSuccess , NSString *identifier))callBack;

//日历更新事件
-(void)UpdateEventWithIdentifier:(NSString*)identifier title:(NSString*)title Notes:(NSString*)note SDate:(NSDate*)sDate EDate:(NSDate*)eDate isAddAlarm:(BOOL)isAlarm CallBack:(void(^)(BOOL isSuccess , NSString *newIdentifier))callBack;

//删除
//日历删除事件
-(void)DeleteEventWithIdentifier:(NSString*)identifier CallBack:(void(^)(BOOL isSuccess))callBack;

@end
