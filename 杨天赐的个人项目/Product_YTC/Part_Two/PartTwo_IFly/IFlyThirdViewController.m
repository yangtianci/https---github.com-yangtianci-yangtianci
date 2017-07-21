//
//  IFlyThirdViewController.m
//  杨天赐的个人项目
//
//  Created by Risenb on 2017/3/1.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "IFlyThirdViewController.h"

//讯飞头文件
#import "iflyMSC/iflyMSC.h"
//---带界面
#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "iflyMSC/IFlyRecognizerView.h"
//---不带界面
#import "iflyMSC/IFlySpeechRecognizerDelegate.h"
#import "iflyMSC/IFlySpeechRecognizer.h"

@interface IFlyThirdViewController ()<IFlyRecognizerViewDelegate,IFlySpeechSynthesizerDelegate>

{
    IFlyRecognizerView      *_iflyRecognizerView;//听写
    IFlySpeechSynthesizer       * _iFlySpeechSynthesizer;//合成
}

@property (strong, nonatomic) UIButton *StartButton;
@property (strong, nonatomic) UILabel *WordLabel;

@property (strong, nonatomic) UIButton *TransformButton;
@property (strong, nonatomic) UITextField *TransformField;

@property (strong, nonatomic) NSMutableArray *Array;

@property (strong, nonatomic) NSMutableString *CurrentWord;

@end

@implementation IFlyThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self ConfigurationUI];
    self.Array = [NSMutableArray array];
    self.CurrentWord = [NSMutableString string];
    //初始化讯飞
    [self initIFly];

}

-(void)UseTesx{

    if (self.Array.count > 0) {
        for (NSArray *Sarray in self.Array) {
            NSDictionary *dict = Sarray.lastObject;
            for (NSString *key in dict) {
                [self.CurrentWord appendString:key];
            }
        }
    }
    self.WordLabel.text = self.CurrentWord;
}


#pragma mark - ---------- 核心代理方法 - 合成 ----------

//按钮点击方法
-(void)TransformWordToVoice{
    //启动合成会话
    NSString *Str = self.TransformField.text;
    if (Str.length > 0) {
        [_iFlySpeechSynthesizer startSpeaking:Str];
    }else{
        [_iFlySpeechSynthesizer startSpeaking:@"没有输入文字"];
    }
}


//合成结束，此代理必须要实现
- (void) onCompleted:(IFlySpeechError *) error{

}
//合成开始
- (void) onSpeakBegin{
    [self ShowMessage:@"开始合成"];
}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg{
    [self ShowMessage:[NSString stringWithFormat:@"合成进度%zd",progress]];
}
//合成播放进度
- (void) onSpeakProgress:(int) progress{
    [self ShowMessage:[NSString stringWithFormat:@"合成进度%zd",progress]];
}


#pragma mark - ---------- 核心代理方法 - 听写 ----------

/*识别结果返回代理
 @param resultArray 识别结果
 @ param isLast 表示是否最后一次结果
 */
- (void)onResult: (NSArray *)resultArray isLast:(BOOL) isLast
{
    if (resultArray) {
        [self.Array addObject:resultArray];
        if (isLast) {
            [self UseTesx];
        }
    }else{
        [self ShowMessage:@"没有说话"];
    }
}
/*识别会话错误返回代理
 @ param  error 错误码
 */
- (void)onError: (IFlySpeechError *) error
{
    CLog(error);
}


//按钮方法
-(void)StartRecord:(UIButton*)sender{
    [self.Array removeAllObjects];
    self.CurrentWord = [NSMutableString string];
    [self StartMethod];
}

//开始录音方法
-(void)StartMethod{
    //启动识别服务
    [_iflyRecognizerView start];
}


//结束录音方法
/**
 因为采用了有界面的语音识别,因此,点击界面即可结束识别,不需要手动进行识别
 */
//-(void)EndMethod{
//    //结束识别服务
//    [_iflyRecognizerView cancel];
//}


#pragma mark - ---------- 合成相关  ----------

-(void)initTransform{

    // 创建合成对象，为单例模式
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    //设置语音合成的参数
    //语速,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];
    //音量;取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]];
    //发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表
    [_iFlySpeechSynthesizer setParameter:@" xiaoyan " forKey: [IFlySpeechConstant VOICE_NAME]];
    //音频采样率,目前支持的采样率有 16000 和 8000
    [_iFlySpeechSynthesizer setParameter:@"8000" forKey: [IFlySpeechConstant SAMPLE_RATE]];
    //asr_audio_path保存录音文件路径，如不再需要，设置value为nil表示取消，默认目录是documents
    [_iFlySpeechSynthesizer setParameter:nil forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];

}

#pragma mark - ---------- 听写相关  ----------

//语音识别初始化
-(void)initIFly{

    //单例模式，无UI的实例
    if (_iflyRecognizerView == nil) {
        _iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        _iflyRecognizerView.delegate = self;
    }
    // 设置参数
    if (_iflyRecognizerView != nil) {
        //扩展参数
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        //设置听写模式
        [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        //设置最长录音时间
        [_iflyRecognizerView setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iflyRecognizerView setParameter:@"1800" forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iflyRecognizerView setParameter:@"1800" forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        //设置采样率，推荐使用16K
        [_iflyRecognizerView setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        //设置语言
        [_iflyRecognizerView setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        //设置方言
        [_iflyRecognizerView setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
        //设置是否返回标点符号
        [_iflyRecognizerView setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
        //设置数据返回格式
        [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    }
}

#pragma mark - ---------- 配置UI  ----------

-(void)ConfigurationUI{

    self.view.backgroundColor = LightBule;
    self.BGImageName = @"BG_LightLine.jpeg";

    //听写按钮
    self.StartButton = [[UIButton alloc]init];
    [self.view addSubview:self.StartButton];
    self.StartButton.backgroundColor = [UIColor brownColor];
    [self.StartButton setTitle:@"点击开始录音" forState:UIControlStateNormal];
    [self.StartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).with.offset(50);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
    }];
    self.StartButton.selected = NO;
    [self.StartButton addTarget:self action:@selector(StartRecord:) forControlEvents:UIControlEventTouchUpInside];

    //听写label
    self.WordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, ViewWidth - 20, 50)];
    self.WordLabel.numberOfLines = 0;
    self.WordLabel.textColor = [UIColor whiteColor];
    self.WordLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.WordLabel];
    self.WordLabel.backgroundColor = [UIColor blackColor];
    self.WordLabel.text = @"随便说点什么吧";


    //合成按钮
    self.TransformButton = [[UIButton alloc]init];
    [self.view addSubview:self.TransformButton];
    self.TransformButton.backgroundColor = [UIColor brownColor];
    [self.TransformButton setTitle:@"点击开始合成" forState:UIControlStateNormal];
    [self.TransformButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).with.offset(110);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
    }];
    [self.TransformButton addTarget:self action:@selector(TransformWordToVoice) forControlEvents:UIControlEventTouchUpInside];

    //听写label
    self.TransformField = [[UITextField alloc]initWithFrame:CGRectMake(10, 120, ViewWidth - 20, 50)];
    self.TransformField.textColor = [UIColor whiteColor];
    self.TransformField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.TransformField];
    self.TransformField.backgroundColor = [UIColor blackColor];
    self.TransformField.placeholder = @"随便写点什么吧";

}







@end
