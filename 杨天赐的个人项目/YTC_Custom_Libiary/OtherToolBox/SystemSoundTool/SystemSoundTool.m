//
//  SystemSoundTool.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/17.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "SystemSoundTool.h"

#import <AudioToolbox/AudioToolbox.h>

@interface SystemSoundTool ()

@end

@implementation SystemSoundTool

//带震动
+(void)PlayAlertSoundWithSoundsID:(NSInteger)ID{
    //参数为 1000-2000 之间数字时就是播放系统声音
    uint32_t soundId = [SystemSoundTool JudgementNumberRightfulWithID:ID];
    AudioServicesPlayAlertSound(soundId);
}

//不带震动
+(void)PlaySystemSoundWithSoundsID:(NSInteger)ID{
    uint32_t soundId = [SystemSoundTool JudgementNumberRightfulWithID:ID];
    AudioServicesPlaySystemSound(soundId);
}


+(uint32_t)JudgementNumberRightfulWithID:(NSInteger)ID{
    if (ID == 0) {
        return kSystemSoundID_Vibrate;
    }else{
        if (ID > 2000 || ID < 1000) {
            CLog(@"超出合法范围");
            return 1006;
        }else{
            uint32_t soundId = (uint32_t)ID;
            return  soundId;
        }
    }
}

//播放本地文件
+(void)PlaySoundsWithFileName:(NSString *)fileName isDispose:(BOOL)isdispose{
    
    //1.获得音效文件的全路径
    NSURL *url=[[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    
    //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    SystemSoundID soundID = arc4random_uniform(500) + 2000;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);

    //3.播放音效文件
    //下面的两个函数都可以用来播放音效文件，第一个函数伴随有震动效果
    AudioServicesPlayAlertSound(soundID);
    
    // 完成播放之后执行的soundCompleteCallback函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL,ComplietMethod , NULL);

    //把需要销毁的音效文件的ID传递给它既可销毁
    if (isdispose) {
        AudioServicesDisposeSystemSoundID(soundID);
    }
    
}

//完成后执行的方法
void ComplietMethod(){
    //null
}


@end
