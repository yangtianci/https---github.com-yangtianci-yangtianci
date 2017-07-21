//
//  CustomLayout_YTC.h
//  SmallTest
//
//  Created by yang on 16/12/14.
//  Copyright © 2016年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLayout_YTC : UICollectionViewLayout

#pragma mark - ---------- 可选属性,非必须 ----------

//可选属性-读取数据的地方-supplement
@property (strong, nonatomic) NSMutableArray *supplement_DataArray;

//可选属性-读取数据的地方-decoration
@property (strong, nonatomic) NSMutableArray *decoration_DataArray;

#pragma mark - ---------- 必须属性,必须传值 ----------

//必须属性-读取数据的地方-item
@property (strong, nonatomic) NSMutableArray *item_DataArray;

//必须属性-根据数据生成的属性的地方
@property (strong, nonatomic) NSMutableArray *AttributeArray;

@end
