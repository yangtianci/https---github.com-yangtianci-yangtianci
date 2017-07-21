//
//  CustomLayout_Model_YTC.h
//  SmallTest
//
//  Created by yang on 16/12/14.
//  Copyright © 2016年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/*
 
 如果实现辅助视图自定义,可能需要新建模型
 
 */

@interface CustomLayout_Model_YTC : NSObject

//可选属性

@property (strong, nonatomic) UIColor *RadomBG_Color;//示例属性

//必须要有的属性

@property (assign, nonatomic) CGFloat itemWidth;

@property (assign, nonatomic) CGFloat itemHeight;

-(instancetype)initWithDict:(NSDictionary*)dict;

@end
