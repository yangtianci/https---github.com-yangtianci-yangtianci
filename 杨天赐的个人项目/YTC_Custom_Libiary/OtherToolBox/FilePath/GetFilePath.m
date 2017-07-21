//
//  GetFilePath.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/19.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "GetFilePath.h"

@interface GetFilePath ()



@end

@implementation GetFilePath

//拼接文件名
+(NSString *)AppendingFileName:(NSString *)filename filePath:(NSString *)filepath{
    NSString *FullPath = [filepath stringByAppendingPathComponent:filename];
    return FullPath;
}

//itunes会同步,适合重要数据
+(NSString*)Getpath_Document{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return documentPath;
}

//不同步,存储体积大,非重要数据
+(NSString*)Getpath_Caches{
    NSString *CatchPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return CatchPath;
}

//临时文件,系统管理
+(NSString*)Getpath_tmp{
    NSString *TmpPath = NSTemporaryDirectory();
    return TmpPath;
}

//itunes会同步,一般保存设置信息 - 一般不用
//通过 NSUserDefaults使用
+(NSString*)Getpath_Preference{
    NSString *PreferencePath = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES).firstObject;
    return PreferencePath;
}

@end
