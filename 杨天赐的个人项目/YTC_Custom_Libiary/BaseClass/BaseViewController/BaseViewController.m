//
//  BaseViewController.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/19.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_showTabbar == YES) {
    }else{
        self.tabBarController.tabBar.hidden = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_showTabbar == YES) {
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
}

-(void)setDetialInformation:(NSString *)DetialInformation{
    
    _DetialInformation = DetialInformation;
    
    UILabel *detialLabel = [[UILabel alloc]init];
    detialLabel.frame = CGRectMake(0, 10, ScreenWidth, 50);
    [self.view addSubview:detialLabel];
    detialLabel.numberOfLines = 0;
    
    detialLabel.text = DetialInformation;
    detialLabel.font = [UIFont systemFontOfSize:12];
    detialLabel.textAlignment = NSTextAlignmentCenter;
    
}



//设置navbar背景图片
-(void)SetNavBarImageWithName:(NSString *)name{
    /*
     如果失效,可能是因为状态栏状态选择错误
     */
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:name] forBarMetrics:UIBarMetricsDefault];
    
}

//设置整体背景图
-(void)setBGImageName:(NSString *)BGImageName{
    
    //BG_Wooden.jpeg
    UIImageView *BGImageView = [[UIImageView alloc]init];
    BGImageView.frame = self.view.bounds;
    [self.view addSubview:BGImageView];
    BGImageView.image = [UIImage imageNamed:BGImageName];
    BGImageView.backgroundColor = [UIColor brownColor];
}

-(void)ShowMessage:(NSString *)message{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].keyWindow];
    [hud showAnimated:YES];
    [self.view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:2];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
