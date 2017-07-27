//
//  CalenderTool.m
//  测试专用项目
//
//  Created by YangTianCi on 2017/7/27.
//  Copyright © 2017年 QianBuXian. All rights reserved.
//

#import "CalenderTool.h"

#import <EventKit/EventKit.h>

@interface CalenderTool ()

@property (nonatomic,strong) EKEventStore *EStore;

@property (nonatomic,strong) EKEvent *BeAddEvent;


@end



@implementation CalenderTool

+ (instancetype)manager{
    
    static id manager = nil;
    
    static dispatch_once_t tokenForCalenderTool;
    
    dispatch_once(&tokenForCalenderTool, ^{
        
        manager = [[CalenderTool alloc]init];
        
    });
    
    return manager;
}


//日历更新事件
-(void)UpdateEventWithIdentifier:(NSString*)identifier title:(NSString*)title Notes:(NSString*)note SDate:(NSDate*)sDate EDate:(NSDate*)eDate isAddAlarm:(BOOL)isAlarm CallBack:(void(^)(BOOL isSuccess , NSString *newIdentifier))callBack{

    EKEvent *event = [self.EStore eventWithIdentifier:identifier];
    
    NSString *Ntitle;
    NSString *Nnote;
    NSDate *NSD;
    NSDate *NED;
    
    if (title.length > 0) {
        Ntitle = title;
    }else{
        Ntitle = event.title;
    }
    
    
    if (note.length > 0) {
        Nnote = note;
    }else{
        Nnote = event.notes;
    }
    
    
    if (![sDate isEqualToDate:event.startDate]) {
        NSD = sDate;
    }else{
        NSD = event.startDate;
    }
    
    
    if (![eDate isEqualToDate:event.endDate]) {
        NED = eDate;
    }else{
        NED = event.endDate;
    }
    
    
    
    [self DeleteEventWithIdentifier:identifier CallBack:^(BOOL isSuccess) {
        if (isSuccess) {
            
         [self AddCalenderWith:Ntitle Notes:Nnote SDate:NSD EDate:NED isAddAlarm:isAlarm CallBack:^(BOOL isSuccess, NSString *identifier) {
            
             if (isSuccess) {
                 callBack(YES, identifier);
             }else{
                 callBack(NO,nil);
             }
         }];
            
        }else{
            callBack(NO, nil);
        }
    }];
}


//日历删除事件
-(void)DeleteEventWithIdentifier:(NSString*)identifier CallBack:(void(^)(BOOL isSuccess))callBack{

    EKEvent *event = [self.EStore eventWithIdentifier:identifier];
    [event setCalendar:[self.EStore defaultCalendarForNewEvents]];
    if (event) {
        
        NSError *error;
        
        BOOL isSuccess = [self.EStore removeEvent:event span:EKSpanThisEvent error:&error];
        
        if (isSuccess) {
            callBack(YES);
        }else{
            callBack(NO);
        }
    }
}






//日历添加事件
-(void)AddCalenderWith:(NSString*)title Notes:(NSString*)note SDate:(NSDate*)sDate EDate:(NSDate*)eDate isAddAlarm:(BOOL)isAlarm CallBack:(void(^)(BOOL isSuccess , NSString *identifier))callBack{
    
    [self isAuthorizationCalenderWithBlcok:^(BOOL isAutho) {
        
        if (isAutho) {
            
            if ([self Creat_EventWith:title Notes:note SDate:sDate EDate:eDate isAddAlarm:isAlarm]) {
                
                callBack(YES , self.BeAddEvent.eventIdentifier);
            }else{
                callBack(NO, nil);
            }
        }else{
            callBack(NO, nil);
        }
    }];

}

//创建事件
-(BOOL)Creat_EventWith:(NSString*)title Notes:(NSString*)note SDate:(NSDate*)sDate EDate:(NSDate*)eDate isAddAlarm:(BOOL)isAlarm{
    
    EKEvent *event = [EKEvent eventWithEventStore:self.EStore];
    
    if (title.length > 0) {
        event.title = title;
    }else{
        event.title = @"默认标题";
    }
    event.notes = note;
    event.startDate = sDate;
    event.endDate = eDate;
    
    if (isAlarm) {
        EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:[sDate dateByAddingTimeInterval:- 30]];
        [event addAlarm:alarm];
    }
    
    [event setCalendar:[self.EStore defaultCalendarForNewEvents]];
    
    NSError *error;
    
    BOOL isAddSuccess = [self.EStore saveEvent:event span:EKSpanThisEvent error:&error];
    
    NSLog(@"%@",event.eventIdentifier);
    
    self.BeAddEvent = event;
    
    return isAddSuccess;
}





//创建提醒
-(void)CreatRemind{
    
    //  EKReminder *reminder = [EKReminder reminderWithEventStore:self.EStore];
    
    //...待续/
    
}



//检测权限是否打开 - 日历 + 提醒

-(void)isAuthorizationCalenderWithBlcok:(void(^)(BOOL isAutho))AuthoBlock{
    
    EKAuthorizationStatus statue = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    if (statue == EKAuthorizationStatusNotDetermined) {
        
        [self.EStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            
            if (!error) {
                AuthoBlock(YES);
            }else{
                AuthoBlock(NO);
            }
        }];
        
    }else if (statue == EKAuthorizationStatusAuthorized){
        AuthoBlock(YES);
    }else{
        NSLog(@"其他状态");
        AuthoBlock(NO);
    }
}

-(void)isAuthorizationReminderWithBlcok:(void(^)(BOOL isAutho))AuthoBlock{
    
    EKAuthorizationStatus statue = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    if (statue == EKAuthorizationStatusNotDetermined) {
        
        [self.EStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
            
            if (!error) {
                AuthoBlock(YES);
            }else{
                AuthoBlock(NO);
            }
        }];
        
    }else if (statue == EKAuthorizationStatusAuthorized){
        AuthoBlock(YES);
    }else{
        NSLog(@"其他状态");
        AuthoBlock(NO);
    }
    
}



-(EKEventStore *)EStore{
    if (!_EStore) {
        _EStore = [[EKEventStore alloc]init];
    }
    return _EStore;
}




@end
