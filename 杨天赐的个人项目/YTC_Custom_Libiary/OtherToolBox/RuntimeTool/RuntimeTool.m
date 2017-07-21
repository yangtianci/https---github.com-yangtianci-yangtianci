//
//  RuntimeTool.m
//  杨天赐的个人项目
//
//  Created by yang on 17/2/6.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "RuntimeTool.h"

@implementation RuntimeTool

//类方法替换

-(void)ExchangeClassIMPWithReplaceClass:(Class)replaceClass ReplaceMehod:(SEL)replaceMehod BereplaceClass:(Class)bereplaceClass BereplaceMethod:(SEL)bereplaceMethod{
    //替换之后的方法
    Method ReplaceMethod = class_getClassMethod(replaceClass, replaceMehod);
    //需要被替换的方法
    Method BereplaceMethod = class_getClassMethod(bereplaceClass, bereplaceMethod);
    method_exchangeImplementations(ReplaceMethod, BereplaceMethod);
}

//对象方法替换
-(void)ExchangeInstanceIMPWithReplaceClass:(Class)replaceClass ReplaceMehod:(SEL)replaceMehod BereplaceClass:(Class)bereplaceClass BereplaceMethod:(SEL)bereplaceMethod{
    //替换之后的方法
    Method ReplaceMethod = class_getInstanceMethod(replaceClass, replaceMehod);
    //需要被替换的方法
    Method BereplaceMethod = class_getInstanceMethod(bereplaceClass, bereplaceMethod);
    method_exchangeImplementations(ReplaceMethod, BereplaceMethod);
}


@end
