//
//  ReplicatorLayerController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/4.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "ReplicatorLayerController.h"

/**
 
 利用Replicator生成动画原则
 
 这个动画一定能被拆分为多个部分,多个部分实际上完全相同的部分
 
 唯一的不同 1.出现时间(形成渐进等错觉) 2.变换位置(形成生动的错觉)
 
 */

@interface ReplicatorLayerController ()

@property (strong, nonatomic) CALayer *currentLayer;

@property (strong, nonatomic) UIView *TapView;

@end

@implementation ReplicatorLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.DetialInformation = @"ReplicatorLayer创建动画";
    
    [self TotalConfiguration];
    
}

-(void)TotalConfiguration{
    
    UISegmentedControl *segement = [[UISegmentedControl alloc]initWithFrame:CGRectMake(10, 50, ScreenWidth - 20, 25)];
    [self.view addSubview:segement];
    
    segement.tintColor = CRandomColor;
    
    //添加标签
    [segement insertSegmentWithTitle:@"仿小圆点" atIndex:0 animated:YES];
    [segement insertSegmentWithTitle:@"音量" atIndex:1 animated:YES];
    [segement insertSegmentWithTitle:@"菊花" atIndex:2 animated:YES];
    [segement insertSegmentWithTitle:@"贪吃蛇" atIndex:3 animated:YES];
    [segement addTarget:self action:@selector(SwitchAnimationWith:) forControlEvents:UIControlEventValueChanged];
    
    segement.selectedSegmentIndex = 0;
    
    [self SmallDot];
    
}

-(void)SwitchAnimationWith:(UISegmentedControl*)segement{
    
    if (self.currentLayer) {
        [self.currentLayer removeFromSuperlayer];
    }
    
    if (self.TapView) {
        [self.TapView removeFromSuperview];
    }
    
    NSInteger index = segement.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            [self SmallDot];
            break;
        case 1:
            [self RectAnimation];
            break;
        case 2:
            [self FlowerAnimation];
            break;
        case 3:
            [self RunAnimation];
            break;
        default:
            break;
    }
}



//创建小圆点
-(void)SmallDot{
    
    //创建基本克隆图层
    CAReplicatorLayer *layer = [[CAReplicatorLayer alloc]init];
    
    layer.frame = CGRectMake(0, 0, 80, 80);
    
    layer.instanceCount = 3;
    
    layer.instanceDelay = 0.1;
    
    layer.cornerRadius = 10;
    
    layer.masksToBounds = YES;
    
    layer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75].CGColor;
    
    layer.instanceAlphaOffset = -0.3;
    
    layer.instanceRedOffset = 30;
    layer.instanceBlueOffset = 30;
    layer.instanceGreenOffset = 30;
    
    layer.instanceDelay = 0.5;
    
    layer.instanceTransform = CATransform3DMakeScale(1.3, 1.3, 1.3);
    
    [self.view.layer addSublayer:layer];
    
    //创建dot
    
    CALayer *dot = [CALayer layer];
    
    dot.backgroundColor = [UIColor redColor].CGColor;
    
    dot.bounds = CGRectMake(0, 0, 40, 40);
    dot.position = CGPointMake(40, 40);
    
    dot.cornerRadius = 20;
    dot.masksToBounds = YES;
    
    [layer addSublayer:dot];
    
    //self.currentLayer = layer;
    
    self.TapView = [[UIView alloc]init];
    self.TapView.frame = CGRectMake(ScreenWidth/2, ScreenHeight/2, 80, 80);
    [self.view addSubview:self.TapView];
    self.TapView.backgroundColor = [UIColor whiteColor];
    [self.TapView.layer addSublayer:layer];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanGestureMethod:)];
    pan.maximumNumberOfTouches = 1;
    pan.minimumNumberOfTouches = 1;
    
    [self.TapView addGestureRecognizer:pan];
    
}

//拖动手势
-(void)PanGestureMethod:(UIPanGestureRecognizer*)pan{
    
    CGPoint location = [pan locationInView:pan.view.superview];
    
    self.TapView.center = location;
    
}


//柱状图
-(void)RectAnimation{
    
    // 只对范围内的图层生效
    
    //创建基本克隆图层
    
    CAReplicatorLayer *layer = [[CAReplicatorLayer alloc]init];
    
    layer.bounds = CGRectMake(0, 0, 200, 200);
    
    layer.position = self.view.center;
    
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    layer.instanceCount = 10;
    
    layer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0);
    
    layer.instanceDelay = 0.33;
    
    layer.masksToBounds = YES;
    
    layer.cornerRadius = 3;
    
    [self.view.layer addSublayer:layer];
    
    //红色layer
    
    CALayer *bar = [[CALayer alloc]init];
    
    bar.bounds = CGRectMake(0, 0, 8, 195);
    
    bar.position = CGPointMake(10, 200);
    
    bar.cornerRadius = 2;
    
    bar.backgroundColor = [UIColor purpleColor].CGColor;
    
    [layer addSublayer:bar];
    
    //动画
    
    CABasicAnimation *baseA = [CABasicAnimation animationWithKeyPath:@"position.y"];
    
    baseA.toValue = @(bar.position.y - arc4random()%100);
    
    baseA.duration = 0.5;
    
    baseA.autoreverses = YES;
    
    baseA.repeatCount = MAXFLOAT;
    
    [bar addAnimation:baseA forKey:nil];
    
    self.currentLayer = layer;
    
}

//菊花
-(void)FlowerAnimation{
    
    //创建基本克隆图层
    CAReplicatorLayer *layer = [[CAReplicatorLayer alloc]init];
    
    layer.bounds = CGRectMake(0, 0, 200, 200);
    
    layer.cornerRadius = 10;
    
    layer.position = self.view.center;
    
    layer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75].CGColor;
    
    layer.instanceDelay = 1.5 / 15; // 很关键
    
    layer.instanceCount = 15;
    
    layer.instanceTransform = CATransform3DMakeRotation((2 * M_PI) / 15, 0, 0, 1);
    
    [self.view.layer addSublayer:layer];
    
    //动画层
    CALayer *dot = [[CALayer alloc]init];
    
    dot.bounds = CGRectMake(0, 0, 14, 14);
    
    dot.position = CGPointMake(100, 40);
    
    dot.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    
    dot.borderColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    
    dot.borderWidth = 1;
    
    dot.cornerRadius = 7;
    
    dot.transform = CATransform3DMakeScale(0.01 ,0.01,0.01);
    
    [layer addSublayer:dot];
    
    
    //动画
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    base.fromValue = @1.0;
    base.toValue = @0.1;
    
    base.duration = 1.5;
    
    base.repeatCount = MAXFLOAT;
    
    [dot addAnimation:base forKey:nil];
    
    self.currentLayer = layer;
    
}

//运动点
-(void)RunAnimation{
    
    UIBezierPath *bezier = [[UIBezierPath alloc]init];
    
    [bezier moveToPoint:CGPointMake(31.5, 71.5)];
    
    [bezier addLineToPoint:CGPointMake(31.5, 23.5)];
    
    [bezier addCurveToPoint:CGPointMake(58.5, 38.5) controlPoint1:CGPointMake(31.5, 23.5) controlPoint2:CGPointMake(62.46, 18.69)];
    
    [bezier addCurveToPoint:CGPointMake(53.5, 45.5) controlPoint1:CGPointMake(57.5, 43.5) controlPoint2:CGPointMake(53.5, 45.5)];
    
    [bezier addLineToPoint:CGPointMake(43.5, 48.5)];
    
    [bezier addLineToPoint:CGPointMake(53.5, 66.5)];
    
    [bezier addLineToPoint:CGPointMake(62.5,51.5)];
    
    [bezier addLineToPoint:CGPointMake(70.5,66.5)];
    
    [bezier addLineToPoint:CGPointMake(86.5,23.5)];
    
    [bezier addLineToPoint:CGPointMake(86.5,78.5)];
    
    [bezier addLineToPoint:CGPointMake(31.5,78.5)];
    
    [bezier addLineToPoint:CGPointMake(31.5,71.5)];
    
    [bezier closePath];
    
    CGAffineTransform transform = CGAffineTransformMakeScale(3.0, 3.0);
    
    CGPathRef path = CGPathCreateCopyByTransformingPath(bezier.CGPath, &transform);
    
    //创建基本克隆图层
    CAReplicatorLayer *layer = [[CAReplicatorLayer alloc]init];
    
    layer.bounds = CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height - 200);
    
    layer.position = self.view.center;
    
    layer.instanceCount = 70;
    
    layer.instanceDelay = 0.1;
    
    layer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75].CGColor;
    
    [self.view.layer addSublayer:layer];
    
    //创建dot
    CALayer *dot = [[CALayer alloc]init];
    
    dot.bounds = CGRectMake(0, 0, 10, 10);
    
    dot.position = CGPointMake(31.5, 71.5);
    
    dot.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    
    dot.borderColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    
    dot.borderWidth = 1;
    
    dot.cornerRadius = 5;
    
    dot.shouldRasterize = YES;
    
    dot.rasterizationScale = [UIScreen mainScreen].scale;
    
    [layer addSublayer:dot];
    
    CAKeyframeAnimation *key = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    key.path = path;
    
    key.repeatCount = MAXFLOAT;
    
    key.duration = 5;
    
    [dot addAnimation:key forKey:nil];

    self.currentLayer = layer;
    
}





@end
