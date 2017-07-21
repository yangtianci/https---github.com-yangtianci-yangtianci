//
//  UIImage+EffectLibiary.h
//  杨天赐的个人项目
//
//  Created by yang on 17/1/16.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EffectLibiary)

//对图片的像素颜色进行替换
//http://www.cnblogs.com/guanshenbao/p/5534652.html
-(UIImage*)ReplaceOrginalColor:(UIColor*)orginalColor WithColor:(UIColor*)RColor;

//通过color获取对应的RGBA //获取到的为number
+(NSArray *)getRGBWithColor:(UIColor *)color;

//将彩色图片转换为黑白图片
//黑白图,之后再说
+(UIImage *)grayImage:(UIImage *)sourceImage;

@end
