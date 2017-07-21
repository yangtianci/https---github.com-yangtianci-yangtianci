//
//  SQLTool.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/19.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

/*
 
 数据库 表 数据条 字段
 
 使用方式 : 原生C语言基础 SQL 框架OC : FMDB
 
 */

#import "SQLTool.h"

@interface SQLTool ()



@end

@implementation SQLTool

#pragma mark - ---------- 不是很想写了,反正之后用的时候再说吧,现在就算写了,也不会对之后又很大的帮助,其实现在看的很多东西都没用好像 ----------

//http://www.cnblogs.com/wendingding/p/3871848.html 直接按照这个写就行了

/*
 
 关键点在于理解数据库的结构构成
 1.最外层为数据库,也就是DB层,内部含有多张表,可以有多个并行的数据库,整体一个path
 2.中间为表,寻址找到数据库,根据名称找到对应表,然后既可以进行操作了
 3.数据条_字段,基本的存储单元
 
 */

@end
