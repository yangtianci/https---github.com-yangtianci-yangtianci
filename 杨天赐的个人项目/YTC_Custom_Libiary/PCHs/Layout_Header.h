//
//  Layout_Header.h
//  杨天赐的个人项目
//
//  Created by yang on 16/12/20.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#ifndef Layout_Header_h
#define Layout_Header_h


#pragma mark - ---------- Cell样式 ----------

#define CellIdentifier_Default @"CustomTableViewCell_Identifier_Default"

#import "MostSimpleCell.h"

#pragma mark - ---------- Item样式 ----------

#define ItemIdentifier_Default @"CustomCollectionViewItem_Identifier_Default"


#pragma mark - ---------- 通用view头文件 ----------

#import "UIImage+EffectLibiary.h"
#import "UIColor+Hex.h"
#import "UIView+Extension.h"



#pragma mark - ---------- 常用数据宏 ----------

//默认边距
#define DefaultMargin 5
//默认内间距
#define DefaultInset UIEdgeInsetsMake(10, 10, 10, 10)


//物理宽高

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenSize [UIScreen mainScreen].bounds.size

//主view宽高
#define ViewWidth self.view.frame.size.width
#define ViewHeight self.view.frame.size.height
#define ViewSize self.view.frame.size


//随机颜色

#define CRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:0.9]

//---浅蓝
#define LightBule [UIColor colorWithRed:109/255.0 green:170/255.0 blue:239/255.0 alpha:1]


#endif /* Layout_Header_h */
