//
//  QBXPhotoManager.h
//  测试专用项目
//
//  Created by YangTianCi on 2017/7/28.
//  Copyright © 2017年 QianBuXian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ToolType) {
    ToolType_Photo,
    ToolType_Camera
};


@interface QBXPhotoManager : NSObject

//创建对象
+(instancetype)manager;

//相册 / 拍照 接口
-(void)GetImageWithController:(UIViewController*)controller WithType:(ToolType)type;

//获取返回图片
@property (nonatomic,copy) void(^CallBack)(UIImage *img);





//压缩图片
-(UIImage*)CpmpressImgWithImg:(UIImage *)orginalImg CompressSize:(CGSize)size CompressScale:(CGFloat)scale;

//转Base64
-(NSString*)TransformImgToBase64StrWithImg:(UIImage*)orginal;


@end
