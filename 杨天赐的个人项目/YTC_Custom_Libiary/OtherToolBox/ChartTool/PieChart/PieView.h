//
//  PieView.h
//  PieAnimation
//
//  Created by PC-LiuChunhui on 16/4/5.
//  Copyright © 2016年 Mr.Wendao. All rights reserved.
//

#import <UIKit/UIKit.h>




/**
 
 _pie = [[PieView alloc] initWithFrame:CGRectMake((kScreenWidth - 200) * 0.5f, 100, 200, 200) dataItems:@[@4, @1, @5] colorItems:@[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]]];
 [self.view addSubview:_pie];

 */



@interface PieView : UIView
/**
 *  Pie
 *
 *  @param frame      frame
 *  @param dataItems  数据源
 *  @param colorItems 对应数据的pie的颜色，如果colorItems.count < dataItems 或
 *                      colorItems 为nil 会随机填充颜色
 *
 */
- (id)initWithFrame:(CGRect)frame
          dataItems:(NSArray *)dataItems
         colorItems:(NSArray *)colorItems;
- (void)stroke;
@end
