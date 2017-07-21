//
//  MotionEffectController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/16.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "MotionEffectController.h"

@interface MotionEffectController ()



@end

@implementation MotionEffectController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self totalConfiguration];
    
    self.DetialInformation = @"使用MotionEffectAPI以及GitHub图片完成移动效果";
}

#pragma mark - ---------- 主要配置 ----------

-(void)totalConfiguration{
    
    //配置最基本的UI - 筛选像素点
   
    UIImageView *BGV = [[UIImageView alloc]init];
    BGV.frame = CGRectMake(-100, -100, ViewHeight * 1.1 / 530 * 370 , ViewHeight * 1.1);
    [self.view addSubview:BGV];
    UIImage *BGImage = [UIImage imageNamed:@"MotionEffect_BG.png"];
    BGV.image = BGImage;//(width = 530, height = 370)
    BGV.backgroundColor = [UIColor brownColor];
    BGV.center = self.view.center;
    
    UIImageView *FGV = [[UIImageView alloc]init];
    FGV.frame = CGRectMake(100, 100, 250 , 250.0 / 834.0 * 371.0);
    FGV.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    [self.view addSubview:FGV];
    
    UIImage *orgImg = [UIImage imageNamed:@"MotionEffect_FG.png"];
    UIColor *CC = [UIColor colorWithRed:241 green:241 blue:241 alpha:1];
    UIColor *alPC = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    orgImg = [orgImg ReplaceOrginalColor:CC WithColor:alPC];//(width = 834, height = 371)
    FGV.image = orgImg;
 
    #pragma mark - ---------- 核心-添加运动效果 ----------
    
    [BGV MotionAnimationWithMaxScope:50];
    [FGV MotionAnimationWithMaxScope:100];
    
}









@end
