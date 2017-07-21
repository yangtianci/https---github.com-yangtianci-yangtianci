//
//  ArchiveModel.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/19.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "ArchiveModel.h"

@implementation ArchiveModel

//通过ADecoder进行活动

//取值时 将对象的属性如何对应
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self) {
        self.className = [aDecoder decodeObjectForKey:@"name"];
        self.classteger = [aDecoder decodeIntegerForKey:@"teger"];
        self.classbool = [aDecoder decodeBoolForKey:@"bool"];
    }
    return self;
}

//存储时 将对象对应的属性如何存储
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.className forKey:@"name"];
    [aCoder encodeInteger:self.classteger forKey:@"teger"];
    [aCoder encodeBool:self.classbool forKey:@"bool"];
}


@end
