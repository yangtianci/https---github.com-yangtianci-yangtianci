//
//  BaseModel.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/27.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"\n\n\n\n\n%@ --- 没有被使用\n\n\n\n\n",key);
    
}

@end
