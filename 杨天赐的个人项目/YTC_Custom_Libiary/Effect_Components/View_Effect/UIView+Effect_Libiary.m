//
//  UIView+Effect_Libiary.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/26.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "UIView+Effect_Libiary.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@implementation UIView (Effect_Libiary)

#pragma mark - ---------- Function_Group-layer效果 ----------

#pragma mark - ---------- 方法-阴影效果 ----------

//设置阴影效果
-(void)SetShadow{
    
    [self SetShadowWithColor:[UIColor blackColor].CGColor andOffset:CGSizeMake(-2, 4) Opacity:0.5];
}

-(void)SetShadowWithColor:(CGColorRef)shawdowColor andOffset:(CGSize)offset Opacity:(CGFloat)opeaq{
    
    self.layer.shadowOffset = offset;//x/y偏移的像素数量
    self.layer.shadowOpacity = opeaq;//阴影透明度
    self.layer.shadowColor = shawdowColor;//阴影颜色
    
}


#pragma mark - ---------- Function_Group-运动效果 ----------

-(void)MotionAnimation{
    [self MotionAnimationWithMaxScope:30];
}

-(void)MotionAnimationWithMaxScope:(NSInteger)scope{
    [self MotionAnimationWith_Hor:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis HorKeypath:@"center.x" HorMin:-scope HorMax:scope Ver:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis VerKetpath:@"center.y" VerMin:-scope VerMax:scope];
}

-(void)MotionAnimationWith_Hor:(UIInterpolatingMotionEffectType)hor HorKeypath:(NSString*)horKeypath HorMin:(NSInteger)horMin HorMax:(NSInteger)horMax Ver:(UIInterpolatingMotionEffectType)Ver VerKetpath:(NSString*)verKeypath VerMin:(NSInteger)verMin VerMax:(NSInteger)verMax{
    
    NSMutableArray *EffectArray = [NSMutableArray array];
    
    //不能直接判断是否存在,枚举值为零,一定不正确
    if (hor == 0) {
        UIInterpolatingMotionEffect *motionEffectHor = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:horKeypath type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffectHor.minimumRelativeValue = @(horMin);
        motionEffectHor.maximumRelativeValue = @(horMax);
        
        [EffectArray addObject:motionEffectHor];
    }
    
    if (Ver == 1) {
        UIInterpolatingMotionEffect *motionEffectVer = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:verKeypath type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffectVer.minimumRelativeValue = @(verMin);
        motionEffectVer.maximumRelativeValue = @(verMax);
        [EffectArray addObject:motionEffectVer];
    }

    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc]init];
    group.motionEffects = EffectArray;
    
    [self addMotionEffect:group];
}


#pragma mark ||=====================  基本效果  =====================||

//渐变消失 效果
-(void)Fade_Effect{
    //图片
    UIImage *tempImg;
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    tempImg = UIGraphicsGetImageFromCurrentImageContext();//关键语句
    UIGraphicsEndImageContext();
    
    //效果
    UIImageView *imgV = [[UIImageView alloc]initWithImage:tempImg];
    imgV.frame = self.frame;
    [self.superview addSubview:imgV];
    CGRect endRect = imgV.frame;
    endRect.origin.y = endRect.origin.y - 200;
    
    [UIView animateWithDuration:1.0f animations:^{
        imgV.frame = endRect;
        imgV.alpha = 0;
    } completion:^(BOOL finished) {
        [imgV removeFromSuperview];
    }];
}

#pragma mark - ---------- 基础动画 ----------

//位移
-(void)BaseAnimation_PositionAnimation{
    //使用CABasicAnimation创建基础动画
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, [UIScreen mainScreen].bounds.size.height/2-75)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-75)];
    anima.duration = 1.0f;
    //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
    //    anima.fillMode = kCAFillModeForwards;
    //    anima.removedOnCompletion = NO;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:anima forKey:@"positionAnimation"];
}

//透明度
-(void)BaseAnimation_AlphaAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:1.0f];
    anima.toValue = [NSNumber numberWithFloat:0.2f];
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"opacityAniamtion"];
}

//缩放
-(void)BaseAnimation_ScaleAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"bounds"];
    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"scaleAnimation"];

    //    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//同上
    //    anima.toValue = [NSNumber numberWithFloat:2.0f];
    //    anima.duration = 1.0f;
    //    [self.layer addAnimation:anima forKey:@"scaleAnimation"];

    //        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    //        anima.toValue = [NSNumber numberWithFloat:0.2f];
    //        anima.duration = 1.0f;
    //        [self.layer addAnimation:anima forKey:@"scaleAnimation"];
}

//旋转
-(void)BaseAnimation_RotateAnimation{
    //    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    //    anima.toValue = [NSNumber numberWithFloat:M_PI];
    //    anima.duration = 3.0f;
    //    [self.layer addAnimation:anima forKey:@"rotateAnimation"];

    //valueWithCATransform3D作用与layer
    //        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform"];
    //        anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];//绕着矢量（x,y,z）旋转
    //        anima.duration = 1.0f;
    //        //anima.repeatCount = MAXFLOAT;
    //        [self.layer addAnimation:anima forKey:@"rotateAnimation"];

    //    //CGAffineTransform作用与View
    self.transform = CGAffineTransformMakeRotation(0);
    [UIView animateWithDuration:3.0f animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {

    }];
}

//背景色
-(void)BaseAnimation_BackGroundColorAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima.toValue =(id) [UIColor greenColor].CGColor;
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"backgroundAnimation"];
}


#pragma mark - ---------- 关键帧动画  ----------

/**
 *  关键帧动画
 */
-(void)keyFrameAnimation{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    anima.duration = 3.0f;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏
    anima.delegate = self;//设置代理，可以检测动画的开始和结束
    [self.layer addAnimation:anima forKey:@"keyFrameAnimation"];

}

/**
 *  path动画
 */
-(void)pathAnimation{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    anima.path = path.CGPath;
    anima.duration = 3.0f;
    [self.layer addAnimation:anima forKey:@"pathAnimation"];
}

/**
 *  抖动效果
 */
-(void)shakeAnimation{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    anima.values = @[value1,value2,value3];
    anima.repeatCount = MAXFLOAT;

    [self.layer addAnimation:anima forKey:@"shakeAnimation"];
}


#pragma mark - ---------- 组动画  ----------

//同时执行
-(void)groupAnimation_SameTime{

    /** part 1 */

    //    //位移动画
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];

    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];

    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];

    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:anima1,anima2,anima3, nil];
    groupAnimation.duration = 5.0f;

    [self.layer addAnimation:groupAnimation forKey:@"groupAnimation"];

    /** part 2 */

    //-------------如下，使用三个animation不分装成group，只是把他们添加到layer，也有组动画的效果。-------------
    //    //位移动画
    //    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    //    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    //    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    //    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    //    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    //    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    //    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    //    anima1.duration = 4.0f;
    //    [_demoView.layer addAnimation:anima1 forKey:@"aa"];
    //
    //    //缩放动画
    //    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    //    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    //    anima2.duration = 4.0f;
    //    [_demoView.layer addAnimation:anima2 forKey:@"bb"];
    //
    //    //旋转动画
    //    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    //    anima3.duration = 4.0f;
    //    [_demoView.layer addAnimation:anima3 forKey:@"cc"];

    /** part 3 */

    //    [self keyFrameAnimation];
    //    [self shakeAnimation];
    //    [self BaseAnimation_ScaleAnimation];

}

/**
 *  顺序执行的组动画
 */
-(void)groupAnimation_Countinuous{

    CFTimeInterval currentTime = CACurrentMediaTime();

    //位移动画
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-75)];
    anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-75)];
    anima1.beginTime = currentTime;
    anima1.duration = 1.0f;
    anima1.fillMode = kCAFillModeForwards;
    anima1.removedOnCompletion = NO;
    [self.layer addAnimation:anima1 forKey:@"aa"];

    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.beginTime = currentTime+1.0f;
    anima2.duration = 1.0f;
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = NO;
    [self.layer addAnimation:anima2 forKey:@"bb"];

    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = currentTime+2.0f;
    anima3.duration = 1.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [self.layer addAnimation:anima3 forKey:@"cc"];
}


#pragma mark - ---------- 仿射动画  ----------

//位移
-(void)Affine_positionAnimation{
    self.transform = CGAffineTransformIdentity;
    CGAffineTransform replaceTransform = CGAffineTransformMakeTranslation(100, 100);
    [UIView animateWithDuration:1.0f animations:^{
        self.transform = replaceTransform;
    }];
}

//缩放
-(void)Affine_scaleAnimation{
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        self.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

//旋转
-(void)Affine_rotateAnimation{
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

//多个矩阵操作组合
-(void)Affine_combinationAnimation{
    //仿射变换的组合使用
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        //可能是创建了一个空的矩阵,一层层的增加,最后与原始的进行运算
        CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
        self.transform = CGAffineTransformTranslate(transform2, 100, 100);
    }];
}

//反转 - 从给定的矩阵变成之前的矩阵
-(void)Affine_invertAnimation{
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        //矩阵反转
        self.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(2, 2));
    }];
}

#pragma mark - ---------- 转场动画  ----------
/*
 type:
 kCATransitionFade;
 kCATransitionMoveIn;
 kCATransitionPush;
 kCATransitionReveal;
 */
/*
 subType:
 kCATransitionFromRight;
 kCATransitionFromLeft;
 kCATransitionFromTop;
 kCATransitionFromBottom;
 */

/**
 *  逐渐消失
 */
-(void)Transiton_fadeAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionFade;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    //anima.startProgress = 0.3;//设置动画起点
    //anima.endProgress = 0.8;//设置动画终点
    anima.duration = 1.0f;

    [self.layer addAnimation:anima forKey:@"fadeAnimation"];
}

//覆盖
-(void)Transiton_moveInAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionMoveIn;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"moveInAnimation"];
}

//推出
-(void)Transiton_pushAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"pushAnimation"];
}

//推出
-(void)Transiton_revealAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionReveal;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"revealAnimation"];
}

/**
 以下为私有接口
 */
/**
 *  立体翻滚效果
 */
-(void)Transiton_cubeAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"revealAnimation"];
}

//神奇效果
-(void)Transiton_suckEffectAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = @"suckEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"suckEffectAnimation"];
}

//立体翻转
-(void)Transiton_oglFlipAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = @"oglFlip";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"oglFlipAnimation"];
}

//内部坍缩
-(void)Transiton_rippleEffectAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = @"rippleEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"rippleEffectAnimation"];
}

//翻页-翻开
-(void)Transiton_pageCurlAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = @"pageCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"pageCurlAnimation"];
}

//翻页-合住
-(void)Transiton_pageUnCurlAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = @"pageUnCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"pageUnCurlAnimation"];
}

//相机-打开
-(void)Transiton_cameraIrisHollowOpenAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowOpen";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"cameraIrisHollowOpenAnimation"];
}

//相机-关闭
-(void)Transiton_cameraIrisHollowCloseAnimation{
    self.layer.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1].CGColor;
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowClose";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"cameraIrisHollowCloseAnimation"];
}








@end
