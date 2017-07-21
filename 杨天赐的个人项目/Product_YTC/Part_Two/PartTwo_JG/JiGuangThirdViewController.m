//
//  JiGuangThirdViewController.m
//  杨天赐的个人项目
//
//  Created by yang on 2017/2/14.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "JiGuangThirdViewController.h"

#import "JiGuang.h"

@interface JiGuangThirdViewController ()

@property (strong, nonatomic) UIButton *VertifyButton;

@property (strong, nonatomic) UIButton *SMSButton;

@property (strong, nonatomic) UIButton *VoiceButton;

@property (strong, nonatomic) UITextField *PhoneNumberField;

@property (strong, nonatomic) UITextField *CodeField;

@property (strong, nonatomic) JiGuang *jg;

@end

@implementation JiGuangThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.DetialInformation = @"极光文字/语言短信测试已完成,断点处可查询返回码,极光后台可查询下发验证码";
    [self ConfigurationUI];
    self.jg = [[JiGuang alloc]init];
}


-(void)ConfigurationUI{
    
    self.VertifyButton = [[UIButton alloc]init];
    [self.view addSubview:self.VertifyButton];
    
    [self.VertifyButton setTitle:@"提交验证码" forState:UIControlStateNormal];
    [self.VertifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.VertifyButton.backgroundColor = [UIColor brownColor];
    [self.VertifyButton addTarget:self action:@selector(CommitCode) forControlEvents:UIControlEventTouchUpInside];
    [self.VertifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
        make.bottom.offset(-120);
    }];
    
    self.SMSButton = [[UIButton alloc]init];
    [self.view addSubview:self.SMSButton];
    
    [self.SMSButton setTitle:@"文字验证" forState:UIControlStateNormal];
    [self.SMSButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.SMSButton.backgroundColor = [UIColor brownColor];
    [self.SMSButton addTarget:self action:@selector(SMSVertify) forControlEvents:UIControlEventTouchUpInside];
    [self.SMSButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
        make.bottom.offset(-180);
    }];
    
    
    self.VoiceButton = [[UIButton alloc]init];
    [self.view addSubview:self.VoiceButton];
    
    [self.VoiceButton setTitle:@"语音验证" forState:UIControlStateNormal];
    [self.VoiceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.VoiceButton.backgroundColor = [UIColor brownColor];
    [self.VoiceButton addTarget:self action:@selector(VoiceVertify) forControlEvents:UIControlEventTouchUpInside];
    [self.VoiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
        make.bottom.offset(-240);
    }];
    
    
    self.PhoneNumberField = [[UITextField alloc]init];
    [self.view addSubview:self.PhoneNumberField];
    self.PhoneNumberField.placeholder = @"PhoneNumber";
    self.PhoneNumberField.textAlignment = NSTextAlignmentCenter;
    self.PhoneNumberField.borderStyle = UITextBorderStyleLine;
    [self.PhoneNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
        make.bottom.offset(-330);
    }];
    
    
    self.CodeField = [[UITextField alloc]init];
    [self.view addSubview:self.CodeField];
    self.CodeField.placeholder = @"Code";
    self.CodeField.textAlignment = NSTextAlignmentCenter;
    self.CodeField.borderStyle = UITextBorderStyleLine;
    [self.CodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
        make.bottom.offset(-390);
    }];
    
}

-(void)SMSVertify{
    
    [self.jg JiGuang_SendTextMessageWithPhoneNumber:self.PhoneNumberField.text Success:^(id result) {
        NSLog(@"获取验证码成功！");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"获取验证码成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } Fail:^(NSError *error) {
        NSLog(@"获取验证码失败！");
        NSLog(@"%@", error);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"错误码%ld",(long)error.code] message:[NSString stringWithFormat:@"%@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }];
    
}


-(void)VoiceVertify{
    
    [self.jg JiGuang_SendVoiceMessageWithPhoneNumber:self.PhoneNumberField.text Success:^(id result) {
        NSLog(@"获取验证码成功！");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"等待语音电话" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } Fail:^(NSError *error) {
        NSLog(@"获取验证码失败！");
        NSLog(@"%@", error);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"错误码%ld",(long)error.code] message:[NSString stringWithFormat:@"%@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }];
    
}

-(void)CommitCode{
    
    [self.jg JiGuang_GetBoolWithPhoneNumber:self.PhoneNumberField.text Code:self.CodeField.text Success:^(id result) {
        NSLog(@"验证验证码成功！");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"验证验证码成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } Fail:^(NSError *error) {
        NSLog(@"验证验证码失败！");
        NSLog(@"%@", error);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"错误码%ld",(long)error.code] message:[NSString stringWithFormat:@"%@",error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}


/**
 
 错误码描述
 错误码 	错误码描述 	备注
 2993 	uuid错误，验证码验证失败
 2994 	参数错误
 2996 	两次请求在最小时间间隔内
 2997 	号码改变，请首先获取验证码
 2998 	网络错误
 2999 	其他错误
 3001 	请求超时
 4204 	无效的手机号码
 4001 	body为空
 4002 	无效的appkey
 4003 	无效的来源
 4004 	body解密失败
 4005 	aes key解密失败
 4006 	时间戳转化失败
 4007 	body格式不正确
 4008 	无效时间戳
 4009 	没有短信验证权限
 4011 	发送超频 	单个设备或同一手机号每天获取验证码默认10次
 4012 	api不存在
 4013 	模板不存在
 4014 	extra为空
 4015 	验证码不正确
 4016 	没有余额
 4017 	验证码超时
 4018 	验证码已经验证过
 5000 	服务端错误
 
 */




@end
