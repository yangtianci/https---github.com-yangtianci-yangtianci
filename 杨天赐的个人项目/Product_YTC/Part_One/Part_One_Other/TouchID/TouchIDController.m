//
//  TouchIDController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/17.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "TouchIDController.h"

#import "TouchIDTool.h"

@interface TouchIDController ()

@property (strong, nonatomic) UITextField *SoundId;

@end

@implementation TouchIDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self totalConfiguration];
    
    self.DetialInformation = @"包含了touchID--系统声音播放--自定义音频播放的功能实现/输入不合法值时统一使用1006号系统声音";
    
}

#pragma mark - ---------- 主要配置 ----------

-(void)totalConfiguration{
    
    #pragma mark - ---------- 设置背景 ----------
    
    UIImageView *BGIM = [[UIImageView alloc]init];
    CGRect tempR = self.view.bounds;
    tempR.size.height = ViewHeight / 2;
    tempR.origin.y = ViewHeight/2;
    BGIM.frame = tempR;
    [self.view addSubview:BGIM];
    BGIM.image = [UIImage imageNamed:@"SystemSounds.png"];
    BGIM.backgroundColor = CRandomColor;
    
    #pragma mark - ---------- TouchID部分 ----------
    
    TouchIDTool *tool = [[TouchIDTool alloc]init];;
    
    tool.Reson = @"touchID测试";
    tool.ButtonTitle = @"选择其他验证方式";
    
    if ([tool isCanUse]) {
        
        [tool CheckTouchIDWithSuccess:^{
            
            
        } Fail:^(NSError *CheckError) {

        }];
        
    }else{
        
    }
    
    #pragma mark - ---------- 系统声音部分 ----------
    
    UITextField *textF = [[UITextField alloc]init];
    textF.frame = CGRectMake(0, 0, 200, 30);
    [self.view addSubview:textF];
    textF.center = CGPointMake(self.view.center.x, 100);
    
    textF.placeholder = @"输入播放的声音,1000 - 2000之内";
    textF.textAlignment = NSTextAlignmentRight;
    self.SoundId = textF;
    textF.keyboardType = UIKeyboardTypeDecimalPad;
    
    UIButton *PlayBtn = [[UIButton alloc]init];
    PlayBtn.frame = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:PlayBtn];
    PlayBtn.center = CGPointMake(self.view.center.x, textF.center.y + 50);
    
    [PlayBtn setTitle:@"播放" forState:UIControlStateNormal];
    [PlayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    PlayBtn.backgroundColor = [UIColor clearColor];
    
    [PlayBtn addTarget:self action:@selector(PlayMethod) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)PlayMethod{
    NSInteger number = [self.SoundId.text integerValue];
    [SystemSoundTool PlayAlertSoundWithSoundsID:number];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.SoundId resignFirstResponder];
    
}

@end
