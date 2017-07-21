//
//  BaseViewModel.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/27.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.DataSourceArray = [NSMutableArray array];
    }
    return self;
}

@end
