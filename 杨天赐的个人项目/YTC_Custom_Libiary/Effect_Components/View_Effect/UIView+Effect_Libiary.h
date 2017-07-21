//
//  UIView+Effect_Libiary.h
//  杨天赐的个人项目
//
//  Created by yang on 16/12/26.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 效果组件库,但不是专门的使用接口,主要用于新项目复制
 针对实现接口需要再编写封装接口,使用递归方式编写
 */

typedef NS_ENUM(NSInteger, ShakeDirection) {
    ShakeDirectionHorizontal,
    ShakeDirectionVertical
};

@interface UIView (Effect_Libiary)

#pragma mark - ---------- 其他效果  ----------

//设置阴影效果 - 内部有更详细设置
-(void)SetShadow;

//设置运动效果
-(void)MotionAnimation;
-(void)MotionAnimationWithMaxScope:(NSInteger)scope;

//渐变消失 效果
-(void)Fade_Effect;

#pragma mark - ---------- 基础动画 - 改变基本属性  ----------
//from -> to 的关系

//位移
-(void)BaseAnimation_PositionAnimation;

//透明度
-(void)BaseAnimation_AlphaAnimation;

//缩放
-(void)BaseAnimation_ScaleAnimation;

//旋转
-(void)BaseAnimation_RotateAnimation;

//背景色
-(void)BaseAnimation_BackGroundColorAnimation;


#pragma mark - ---------- 关键帧动画 - 改变基本属性 - 多次  ----------
//from to1 to2 ... end

//关键帧
-(void)keyFrameAnimation;

//路径
-(void)pathAnimation;

//抖动
-(void)shakeAnimation;

#pragma mark - ---------- 组动画 - 连续/同时执行多个动画(基本/关键帧)  ----------

//同时执行 - 一个个添加 / 全部放组里添加
-(void)groupAnimation_SameTime;

//连续执行 - 控制CFTimeInterval进行时间划分
-(void)groupAnimation_Countinuous;


#pragma mark - ---------- 仿射动画 - 直接改变view矩阵属性  ----------

//位移
-(void)Affine_positionAnimation;

//缩放
-(void)Affine_scaleAnimation;

//旋转
-(void)Affine_rotateAnimation;

//组合
-(void)Affine_combinationAnimation;

//反转 - 从给定的矩阵变成之前的矩阵
-(void)Affine_invertAnimation;

#pragma mark - ---------- 转场动画 - 系统封装型  ----------
/**
 其实等同于执行了一个动画而已,真实的控件并没有被移除
 实际使用的时候-1.生成新的VC放置在底层 2.移除上层VC 3.上层VC执行动画
 */
//逐渐消失
-(void)Transiton_fadeAnimation;

//覆盖
-(void)Transiton_moveInAnimation;

//推出
-(void)Transiton_pushAnimation;

//推出
-(void)Transiton_revealAnimation;
/**
 以下为私有接口
 */
//立体翻滚效果
-(void)Transiton_cubeAnimation;

//神奇效果
-(void)Transiton_suckEffectAnimation;

//立体翻转
-(void)Transiton_oglFlipAnimation;

//内部坍缩
-(void)Transiton_rippleEffectAnimation;

//翻页-翻开
-(void)Transiton_pageCurlAnimation;

//翻页-合住
-(void)Transiton_pageUnCurlAnimation;

//相机-打开
-(void)Transiton_cameraIrisHollowOpenAnimation;

//相机-关闭
-(void)Transiton_cameraIrisHollowCloseAnimation;





@end
