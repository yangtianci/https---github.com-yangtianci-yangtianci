//
//  LayerAddAnimationController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/10.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "LayerAddAnimationController.h"

@interface LayerAddAnimationController ()

@property (strong, nonatomic) UIView *exampleView;

@end

@implementation LayerAddAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self TotalConfiguration];

    self.DetialInformation = @"集合图层以及CA代码制作";
    
}

-(void)TotalConfiguration{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObject:[LayerAddAnimationController replicatorLayer_Grid]];
    [tempArray addObject:[LayerAddAnimationController replactorLayer_Circle]];
    [tempArray addObject:[LayerAddAnimationController replicatorLayer_Triangle]];
    [tempArray addObject:[LayerAddAnimationController replicatorLayer_Wave]];
    
    self.exampleView = [[UIView alloc]init];
    self.exampleView.frame = CGRectMake(10, 50, self.view.frame.size.width - 20, self.view.frame.size.height - 150);
    [self.view addSubview:self.exampleView];
    self.exampleView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 4; i ++) {
        
        CGFloat width = self.exampleView.frame.size.width / 2;
        CGFloat height = self.exampleView.frame.size.height / 2;
        
        NSInteger column = i % 2;
        NSInteger row = i / 2;
        
        CGRect frame = CGRectMake(width * column, height * row, width, height);
        
        UIView *view = [[UIView alloc]initWithFrame:frame];
        
        view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor redColor].CGColor;
        
        CALayer *layer = tempArray[i];
        
        layer.position = CGPointMake(width/2, height/2);
        
        if (i == 2) {
            layer.position = CGPointMake(width/2 - 40, height/2 - 10);
        }
        
        [view.layer addSublayer:layer];
        [self.exampleView addSubview:view];
    }
    
}

#pragma mark ||=====================  实例  =====================||

#pragma mark - ---------- 循环动画 ----------
+(CALayer*)replactorLayer_Circle{
    
    //创建基本图形
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, 80, 80);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 80, 80)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.opaque = 0;
    
    //创建shapelayer的组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[[LayerAddAnimationController alphaAnimation],[LayerAddAnimationController  scaleAnimation]];
    group.duration = 4.0;
    group.repeatCount = MAXFLOAT;
    group.autoreverses = NO;
    
    [shape addAnimation:group forKey:nil];
    
    //创建克隆图层
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = CGRectMake(0, 0, 80, 80);
    replicator.instanceDelay = 0.5;
    replicator.instanceCount = 8;
    [replicator addSublayer:shape];
    
    return replicator;
    
}

#pragma mark - ---------- 波浪动画 ----------
+(CALayer*)replicatorLayer_Wave{
    
    CGFloat between = 5.0;
    CGFloat radius = (100 - 2*between)/3;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, (100 - radius)/2, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    [shape addAnimation:[LayerAddAnimationController scaleAnimationTwo] forKey:nil];
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = CGRectMake(0, 0, 100, 100);
    replicator.instanceCount = 3;
    replicator.instanceDelay = 0.2;
    replicator.instanceTransform = CATransform3DMakeTranslation(between*2+radius, 0, 0);
    [replicator addSublayer:shape];
    
    return replicator;
}

#pragma mark - ---------- 三角动画 ----------
+(CALayer*)replicatorLayer_Triangle{
    
    CGFloat radius = 100/4;
    CGFloat transX = 100 - radius;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.strokeColor = [UIColor redColor].CGColor;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.lineWidth = 1;
    [shape addAnimation:[LayerAddAnimationController rotationAnimation:transX] forKey:nil];
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = CGRectMake(0, 0, radius, radius);
    replicator.instanceDelay = 0.0;
    replicator.instanceCount = 3;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, transX, 0, 0);
    transform = CATransform3DRotate(transform, 120.0*M_PI/180.0, 0.0, 0.0, 1.0);
    replicator.instanceTransform = transform;
    [replicator addSublayer:shape];
    return replicator;
}

#pragma mark - ---------- 格子动画 ----------
+(CALayer*)replicatorLayer_Grid{
    
    NSInteger column = 3;
    CGFloat between = 5.0;
    CGFloat radius = (30 - between*(column-1)/column);
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[[LayerAddAnimationController scaleAnimationTwo],[LayerAddAnimationController alphaAnimation]];
    group.duration = 1.0;
    group.autoreverses = YES;
    group.repeatCount = MAXFLOAT;
    [shape addAnimation:group forKey:nil];
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = CGRectMake(0, 0, 100, 100);
    replicator.instanceDelay = 0.3;
    replicator.instanceCount = column;
    replicator.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, radius + between, 0, 0);;
    [replicator addSublayer:shape];
    
    CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
    replicatorLayerY.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerY.instanceDelay = 0.3;
    replicatorLayerY.instanceCount = column;
    replicatorLayerY.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, radius+between, 0);
    [replicatorLayerY addSublayer:replicator];
    
    return replicatorLayerY;
    
}


#pragma mark ||=====================  属性动画  =====================||

#pragma mark - ---------- 透明动画 ----------
+(CABasicAnimation*)alphaAnimation{
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(1.0);
    alpha.toValue = @(0.0);
    return alpha;
}

#pragma mark - ---------- 缩放1 ----------
+(CABasicAnimation*)scaleAnimation{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 1.0)];
    return  scale;
}

#pragma mark - ---------- 缩放2 ----------
+(CABasicAnimation*)scaleAnimationTwo{
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.0)];
    scale.autoreverses = YES;
    scale.repeatCount = MAXFLOAT;
    scale.duration = 0.6;
    return scale;
}

#pragma mark - ---------- 旋转动画 ----------
+(CABasicAnimation*)rotationAnimation:(CGFloat)transX{
    
    CABasicAnimation *rotato = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0.0, 0.0, 0.0, 0.0);
    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, transX, 0.0, 0.0);
    
    toValue = CATransform3DRotate(toValue, 120.0*M_PI/180.0, 0.0, 0.0, 1.0);
    
    rotato.fromValue = [NSValue valueWithCATransform3D:fromValue];
    rotato.toValue = [NSValue valueWithCATransform3D:toValue];
    
    rotato.autoreverses = NO;
    rotato.repeatCount = MAXFLOAT;
    rotato.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotato.duration = 0.8;
    return rotato;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
