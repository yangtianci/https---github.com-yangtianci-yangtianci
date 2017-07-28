//
//  QBXPhotoManager.m
//  测试专用项目
//
//  Created by YangTianCi on 2017/7/28.
//  Copyright © 2017年 QianBuXian. All rights reserved.
//

#import "QBXPhotoManager.h"

@interface QBXPhotoManager ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImagePickerController *picker;

@property (nonatomic,strong) UIImage *selectImg;

@property (nonatomic,strong) NSMutableArray *selectImgArr;

@property (nonatomic,assign) ToolType type;

@end

@implementation QBXPhotoManager

+(instancetype)manager{
    
    static id manager = nil;
    static dispatch_once_t PhotoToken;
    dispatch_once(&PhotoToken, ^{
        manager = [[QBXPhotoManager alloc]init];
    });
    return manager;
}

//相册 / 拍照 接口
-(void)GetImageWithController:(UIViewController*)controller WithType:(ToolType)type{
    
    _picker = [[UIImagePickerController alloc]init];
    _picker.delegate = self;
    
    _type = type;
    
    if (type == ToolType_Photo) {
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }

    [controller presentViewController:_picker animated:YES completion:^{
        
    }];
    
}


//压缩图片
-(UIImage*)CpmpressImgWithImg:(UIImage *)orginalImg CompressSize:(CGSize)size CompressScale:(CGFloat)scale{

    UIImage *OnceImg = [self CompressVolumeWithImg:orginalImg Scale:scale];
    
    UIImage *TwoImg = [self CompressSizeWithImg:OnceImg Size:size];
    
    return TwoImg;
}


//尺寸压缩
-(UIImage*)CompressSizeWithImg:(UIImage*)orginalImg Size:(CGSize)size{
    if (size.width > 0 && size.height > 0) {
        UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
        [orginalImg drawInRect:CGRectMake(0,0,size.width,  size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }else{
        return orginalImg;
    }
}

//质量压缩
-(UIImage*)CompressVolumeWithImg:(UIImage*)orginalImg Scale:(CGFloat)scale{
    
    if (scale > 0) {
        NSData *data = UIImageJPEGRepresentation(orginalImg, scale);
        UIImage *newImg = [UIImage imageWithData:data];
        return newImg;
    }else{
        return orginalImg;
    }
}

//转Base64
-(NSString*)TransformImgToBase64StrWithImg:(UIImage*)orginal{
    NSData *data = UIImagePNGRepresentation(orginal);
    NSString *str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return str;
}

//保存本地文件
-(void)SaveImgToLocalPhotoLibiaryWithImg:(UIImage*)img{
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
    
    
    
    
    

#pragma mark === 代理方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *orgianlImg = info[@"UIImagePickerControllerOriginalImage"];
    
    if (_type == ToolType_Camera) {
        [self SaveImgToLocalPhotoLibiaryWithImg:orgianlImg];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (self.CallBack) {
        self.CallBack(orgianlImg);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



@end
