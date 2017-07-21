//
//  KeyChinaTool.h
//  杨天赐的个人项目
//
//  Created by yang on 17/1/18.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import <Foundation/Foundation.h>

//http://www.cnblogs.com/Jenaral/p/5663096.html

/**
    钥匙串
 猜想 : 根据不同类型的数据创建不同的表(SecClass) 保密策略(Policy)
 指定了表,并且设置了关键的SecAtt之后就等于创建了数据库一条数据
 */

/**
http://www.cnblogs.com/Jenaral/p/5663096.html
 ios钥匙串使用指南
    核心在数据库操作上
 1.普通数据库 : 表名->表 字段ID->字段 每一步是分步骤的
 2.钥匙串 : 表名+字段+... 全部作为字典,钥匙串根据字典自行进行查找最后返回字典
 
 主要使用方法
 SecItem + add / update / delete / copymaching
 主要对象
 字典

*/

/*
使用策略
 核心问题 : 开启ability
 类方法直接存储数据即可
 */

#import <Security/Security.h>
#define Key_DataDictName @"DataDict" //作为keychain中data的键存在,data(dict)的键值对自己指定

@interface KeyChinaTool : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
