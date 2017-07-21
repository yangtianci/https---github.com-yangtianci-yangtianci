//
//  GetFilePath.h
//  杨天赐的个人项目
//
//  Created by yang on 17/1/19.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetFilePath : NSObject

//拼接文件名
+(NSString*)AppendingFileName:(NSString*)filename filePath:(NSString*)filepath;

//itunes会同步,适合重要数据
+(NSString*)Getpath_Document;

//itunes会同步,一般保存设置信息
+(NSString*)Getpath_Preference;

//不同步,存储体积大,非重要数据
+(NSString*)Getpath_Caches;

//临时文件,系统管理
+(NSString*)Getpath_tmp;


@end
