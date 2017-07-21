//
//  ArchiveModel.h
//  杨天赐的个人项目
//
//  Created by yang on 17/1/19.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 1.实现效果需要实现两个代理方法 存储时需要两个方法
 2.使用时需要两个方法
 3.存储于读取通过path连接
 
 */

@interface ArchiveModel : NSObject<NSCoding>

@property (copy, nonatomic) NSString *className;

@property (assign, nonatomic) NSInteger classteger;

@property (assign, nonatomic) BOOL classbool;

@end
