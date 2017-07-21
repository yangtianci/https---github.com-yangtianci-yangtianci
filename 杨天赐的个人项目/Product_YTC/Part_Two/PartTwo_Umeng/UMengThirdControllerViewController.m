//
//  UMengThirdControllerViewController.m
//  杨天赐的个人项目
//
//  Created by yang on 2017/2/14.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "UMengThirdControllerViewController.h"

@interface UMengThirdControllerViewController ()

@property (strong, nonatomic) UIButton *ShareButton;

@end

@implementation UMengThirdControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.DetialInformation = @"很多功能已经集成,但是不适合demo实现";
    self.view.backgroundColor = [UIColor whiteColor];
    [self ConfigurationUI];
    
}

-(void)ConfigurationUI{
    
    self.ShareButton = [[UIButton alloc]init];
    [self.view addSubview:self.ShareButton];
    
    [self.ShareButton setTitle:@"点击分享" forState:UIControlStateNormal];
    [self.ShareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.ShareButton.backgroundColor = [UIColor purpleColor];
    [self.ShareButton addTarget:self action:@selector(QQShare) forControlEvents:UIControlEventTouchUpInside];
    [self.ShareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
}

-(void)QQShare{
    UMeng *share = [[UMeng alloc]init];
    [share UShareWithPlatform:UMSocialPlatformType_QQ Success:^(NSError *error) {
        [self ShowMessage:@"分享成功"];
    } Fail:^(id data) {
        [self ShowMessage:@"分享失败"];
    }];
}







@end
