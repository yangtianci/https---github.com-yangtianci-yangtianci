//
//  RuntimeTool.h
//  杨天赐的个人项目
//
//  Created by yang on 17/2/6.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeTool : NSObject


/**

 下列两个替换方法
 无论函数是否为公开函数,均可以替换
 可以是同一个类中的函数交换,也可以是不同类的函数交换,均可以实现
 
 */
//类方法替换
-(void)ExchangeClassIMPWithReplaceClass:(Class)replaceClass ReplaceMehod:(SEL)replaceMehod BereplaceClass:(Class)bereplaceClass BereplaceMethod:(SEL)bereplaceMethod;
//对象方法替换
-(void)ExchangeInstanceIMPWithReplaceClass:(Class)replaceClass ReplaceMehod:(SEL)replaceMehod BereplaceClass:(Class)bereplaceClass BereplaceMethod:(SEL)bereplaceMethod;




@end
