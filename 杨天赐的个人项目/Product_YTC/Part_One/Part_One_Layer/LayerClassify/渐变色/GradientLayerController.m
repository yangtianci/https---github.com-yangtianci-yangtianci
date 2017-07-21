//
//  GradientLayerController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/4.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "GradientLayerController.h"

@interface GradientLayerController ()


@property (strong, nonatomic) CAGradientLayer *mainLayer;

@end

@implementation GradientLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self TotalConfiguration];

    self.DetialInformation = @"代码绘制-渐变Logo";
}

#pragma mark - ---------- Configuration ----------

-(void)TotalConfiguration{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mainLayer = [[CAGradientLayer alloc]init];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)CRandomColor.CGColor,(id)CRandomColor.CGColor,(id)CRandomColor.CGColor, nil];
    
    self.mainLayer.colors = colors;
    [self.mainLayer setLocations:@[@0.2,@0.6,@0.8]];
    
    self.mainLayer.frame = self.view.bounds;
    
    self.mainLayer.startPoint = CGPointMake(0, 0);
    self.mainLayer.endPoint = CGPointMake(1, 1);
    
    [self.view.layer addSublayer:self.mainLayer];
    
    //创建mask
    UILabel *maskLabel = [[UILabel alloc]init];
    maskLabel.frame = self.view.bounds;
    [self.view addSubview:maskLabel];
    
    maskLabel.text = @"10";
    maskLabel.font = [UIFont systemFontOfSize:260];
    maskLabel.textAlignment = NSTextAlignmentCenter;
    maskLabel.textColor = [UIColor redColor];
    
    self.mainLayer.mask = maskLabel.layer;
    
}






@end
