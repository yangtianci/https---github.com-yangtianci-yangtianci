//
//  UIImage+EffectLibiary.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/16.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "UIImage+EffectLibiary.h"

@implementation UIImage (EffectLibiary)


#pragma mark - ---------- 方法-替换对应的像素点颜色为其他 ----------
-(UIImage*)ReplaceOrginalColor:(UIColor *)orginalColor WithColor:(UIColor *)RColor{

    //获取原始颜色的RGB值
    NSArray *OrginalRGBA = [UIImage getRGBWithColor:orginalColor];
    NSInteger OR = [(NSNumber*)OrginalRGBA[1] integerValue];
    NSInteger OG = [(NSNumber*)OrginalRGBA[2] integerValue];
    NSInteger OB = [(NSNumber*)OrginalRGBA[3] integerValue];
    
    //获取替换颜色的RGB值
    NSArray *ReplaceRGBA = [UIImage getRGBWithColor:RColor];
    NSInteger RA = [(NSNumber*)ReplaceRGBA[0] integerValue];
    NSInteger RR = [(NSNumber*)ReplaceRGBA[1] integerValue];
    NSInteger RG = [(NSNumber*)ReplaceRGBA[2] integerValue];
    NSInteger RB = [(NSNumber*)ReplaceRGBA[3] integerValue];
    
    // 分配内存
    const int imageWidth = self.size.width;
    const int imageHeight = self.size.height;
    
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), self.CGImage);

    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B
        //分别取出RGB值后。进行判断需不需要设成透明。
        uint8_t* ptr = (uint8_t*)pCurPtr;
        
        //进行颜色对比
        if (ptr[1] == OR && ptr[2] == (int)OG && ptr[3] == (int)OB) {
            //当RGB值都大于240则比较接近白色的都将透明度设为0.-----即接近白色的都设置为透明。某些白色背景具有杂质就会去不干净，用这个方法可以去干净
            //如果需要去除的颜色比较统一则直接用精确对比
    
            //使用颜色进行替换
            ptr[0] = RA;
            ptr[1] = RR;
            ptr[2] = RG;
            ptr[3] = RB;
        }
        
    }
    
    // 将内存转成image
    
    CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,NULL, true,kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
}

//通过color获取对应的RGBA
+ (NSArray *)getRGBWithColor:(UIColor *)color{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(alpha),@(red), @(green), @(blue)];
}


#pragma mark - ---------- 彩色图片转换为黑白图片 ----------
+ (UIImage *)grayImage:(UIImage *)sourceImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}


@end
