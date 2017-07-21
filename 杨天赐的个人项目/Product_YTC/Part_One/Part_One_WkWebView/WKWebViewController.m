//
//  WKWebViewController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/20.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "WKWebViewController.h"

#import <WebKit/WebKit.h>

#import "BrowseHistoryController.h"

#define List self.WKWebView.backForwardList

@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *WKWebView;

@property (strong, nonatomic) UISegmentedControl *SegementC;

@property (strong, nonatomic) UIProgressView *progress;

@property (strong, nonatomic) NSMutableArray *HistoryArray;

@property (strong, nonatomic) BrowseHistoryController *history;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self totalConfiguration];

    [self SegementUI];
    
    [self SliderUI];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.HistoryArray = [NSMutableArray array];
    
    __weak typeof(self)weakS = self;
    self.history = [[BrowseHistoryController alloc]init];
    self.history.HistoryBlock = ^(WKBackForwardListItem *item){
        [weakS.WKWebView loadRequest:[NSURLRequest requestWithURL:item.URL]];
    };
}

#pragma mark - ---------- 主要配置 ----------

-(void)totalConfiguration{
    self.WKWebView = [[WKWebView alloc]init];
    [self.view addSubview:self.WKWebView];
    [self.WKWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.offset(0);
        make.bottom.offset(-50);
    }];
    self.WKWebView.backgroundColor = [UIColor brownColor];
    NSURLRequest *quest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.WKWebView loadRequest:quest];
    [self.WKWebView setAllowsBackForwardNavigationGestures:YES];
    
    //控制弹窗等相关代理
    self.WKWebView.UIDelegate = self;
    //控制跳转/加载等相关代理
    self.WKWebView.navigationDelegate = self;
    
}


#pragma mark - ---------- WKNavigationDelegate ----------

/**
 
 1.发送请求前 - 是否发送
 2.接收响应头数据 - 决定是否加载
 3.开始加载 / 加载失败
 4.开始返回数据 / 返回数据过程中失败
 5.加载完成
 6.web进程终止
 
 另 : 服务器重定向请求 - 身份验证请求
 
 */

#pragma mark - --- 流程方法 ---

//在发送请求之前,决定是否进行跳转,通过block返回枚举值,
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    [self ShowMessage:@"准备发送请求"];
    decisionHandler(WKNavigationActionPolicyAllow);
}

//接收到服务器响应调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
    [self ShowMessage:@"接收到服务器响应"];
}

//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [self.progress setHidden:NO];
    [self ShowMessage:@"页面开始加载"];
}

//页面-开始-加载数据失败调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self ShowMessage:@"页面-开始加载-失败"];
}

//数据内容开始返回调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    [self ShowMessage:@"数据内容开始返回"];
}

//页面-加载中-失败调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self ShowMessage:@"页面-加载中-失败"];
}

//页面加载完成调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [self ShowMessage:@"页面加载完成"];
}

//web进程终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    [self ShowMessage:@"web进程终止"];
}

#pragma mark - --- 其他方法 ---

//接收到服务器跳转时调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [self ShowMessage:@"接收到服务器重定向请求"];
}

//当web需要 响应 身份验证时调用 - 如果打开会导致崩溃
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
//    [self ShowMessage:@"web需要响应身份验证"];
//}


#pragma mark - ---------- WKUIDelegate ----------

/*

//创建一个WKWebView
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    [self ShowMessage:@"创建一个WKWebView"];
    return nil;
}

//通知你的应用,DOM窗口对象的close()方法成功完成
- (void)webViewDidClose:(WKWebView *)webView{
    [self ShowMessage:@"通知你的应用,DOM窗口对象的close()方法成功完成。"];
}

//显示一个JS提示框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    [self ShowMessage:@"显示一个JS提示框"];
}

//显示一个JS确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    [self ShowMessage:@"显示一个JS确认框"];
}

//显示一个JS输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler{
    [self ShowMessage:@"显示一个JS输入框"];
}

//是否允许应用程序 决定 是否展示一个给定元素的预览视图
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo{
    [self ShowMessage:@"是否允许应用程序 决定 是否展示一个给定元素的预览视图"];
    return YES;
}

//当给定元素进行观察时,允许程序提供一个自定义的控制器
- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions{
    [self ShowMessage:@"当给定元素进行观察时,允许程序提供一个自定义的控制器"];
    return nil;
}

//允许应用跳转到原生控制器
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController{
    [self ShowMessage:@"允许应用跳转到原生控制器"];
}

*/

#pragma mark ||=====================  创建展示用segement以及功能实现  =====================||

-(void)SegementUI{
    
    self.SegementC = [[UISegmentedControl alloc]init];
    [self.view addSubview:self.SegementC];
    [self.SegementC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.left.offset(0);
        make.bottom.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    self.SegementC.tintColor = CRandomColor;
    
    //添加标签
    [self.SegementC insertSegmentWithTitle:@"前进" atIndex:0 animated:YES];
    [self.SegementC insertSegmentWithTitle:@"回退" atIndex:1 animated:YES];
    [self.SegementC insertSegmentWithTitle:@"主页" atIndex:2 animated:YES];
    [self.SegementC insertSegmentWithTitle:@"记录" atIndex:3 animated:YES];
    [self.SegementC insertSegmentWithTitle:@"刷新" atIndex:4 animated:YES];
    [self.SegementC insertSegmentWithTitle:@"停止" atIndex:5 animated:YES];
    [self.SegementC addTarget:self action:@selector(SegementMethod:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)SegementMethod:(UISegmentedControl*)segement{
    
    switch (segement.selectedSegmentIndex) {
        case 0:
            [self.WKWebView goForward];
            break;
        case 1:
            [self.WKWebView goBack];
            break;
        case 2:
        {
            NSURLRequest *quest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
            [self.WKWebView loadRequest:quest];
        }
            break;
        case 3:
        {
            [self.HistoryArray addObjectsFromArray:self.WKWebView.backForwardList.backList];
            self.history.ItemList = self.HistoryArray;
            [self.navigationController pushViewController:self.history animated:YES];
            break;
        }
        case 4:
             [self.WKWebView reload];
            break;
        case 5:
            if (self.WKWebView.loading) {
                [self.WKWebView stopLoading];
            }else{
                [self ShowMessage:@"已经加载完毕"];
            }
            break;
        default:
            break;
    }
    self.SegementC.momentary = YES;
    /**
     前进
     后退
     主页
     历史记录
     重新加载
     停止加载
     */
}

#pragma mark - ---------- SliderUI ----------

-(void)SliderUI{
    
    self.progress = [[UIProgressView alloc]init];
    [self.view addSubview:self.progress];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(3);
    }];
    self.progress.backgroundColor = [UIColor whiteColor];
    self.progress.tintColor = CRandomColor;
    [self.progress setHidden:YES];
    
    [self.WKWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"estimatedProgress"])
    {
        CGFloat PG = self.WKWebView.estimatedProgress;
        
        if (PG < 1) {
            [self.progress setProgress:PG animated:YES];
        }
        if (PG == 1) {
            [self.progress setHidden:YES];
            [self.progress setProgress:0.0 animated:YES];
        }
        
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.WKWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
