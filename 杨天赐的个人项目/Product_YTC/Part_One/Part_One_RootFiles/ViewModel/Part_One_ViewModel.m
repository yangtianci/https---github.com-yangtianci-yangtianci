//
//  Part_One_ViewModel.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/27.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "Part_One_ViewModel.h"

#import "Part_One_Model.h"

@implementation Part_One_ViewModel

-(NSMutableArray*)GetDataSourceArray{
    NSMutableArray *tempArray = [self CreatLocalData];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = (NSDictionary*)obj;
        Part_One_Model *model = [[Part_One_Model alloc]initWithDictionary:dict];
        [self.DataSourceArray addObject:model];
    }];
    return self.DataSourceArray;
}

-(NSMutableArray*)CreatLocalData{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    #pragma mark - ---------- MaskLayer效果 ----------
    NSMutableDictionary *Dict_QuartzCore = [NSMutableDictionary dictionary];
    
    [Dict_QuartzCore setObject:@"暂无" forKey:@"BGImage"];
    [Dict_QuartzCore setObject:@"GradientLayer.png" forKey:@"EffectImage"];
    [Dict_QuartzCore setObject:@"QuartzCore框架相关实现" forKey:@"Title"];
    [Dict_QuartzCore setObject:@"6" forKey:@"StartNumber"];
    [Dict_QuartzCore setObject:@"LayerEffectExampleController" forKey:@"ClassName"];
    [Dict_QuartzCore setObject:@"包含了CA(属性动画,基础动画,关键帧动画,组动画,转场动画)相关实现,Layer以及特种Layer(克隆layer等)的实现,以及两者结合形成的综合动画效果,纯代码手绘,屏幕适应等" forKey:@"DetialInformation"];
    [tempArray addObject:Dict_QuartzCore];
    
    #pragma mark - ---------- 数据持久化 ----------
    NSMutableDictionary *Dict_DPersistences = [NSMutableDictionary dictionary];
    
    [Dict_DPersistences setObject:@"暂无" forKey:@"BGImage"];
    [Dict_DPersistences setObject:@"DataPersistences.png" forKey:@"EffectImage"];
    [Dict_DPersistences setObject:@"数据持久化实现" forKey:@"Title"];
    [Dict_DPersistences setObject:@"6" forKey:@"StartNumber"];
    [Dict_DPersistences setObject:@"DataPersistencesController" forKey:@"ClassName"];
    [Dict_DPersistences setObject:@"六种数据持久化工具实现数据持久化" forKey:@"DetialInformation"];
    [tempArray addObject:Dict_DPersistences];
    
    #pragma mark - ---------- WKWebView ----------
    NSMutableDictionary *Dict_WKWebView = [NSMutableDictionary dictionary];
    [Dict_WKWebView setObject:@"暂无" forKey:@"BGImage"];
    [Dict_WKWebView setObject:@"WKWebView.png" forKey:@"EffectImage"];
    [Dict_WKWebView setObject:@"WKWebView相关" forKey:@"Title"];
    [Dict_WKWebView setObject:@"6" forKey:@"StartNumber"];
    [Dict_WKWebView setObject:@"WKWebViewController" forKey:@"ClassName"];
    [Dict_WKWebView setObject:@"作为代替webView的控件,能够完全替代,能够更多的支持HTML5的特性.Safari相同的JavaScript引擎.占用更少的内存\n浏览器demo中集成了多个浏览器功能\n14类3协议组成" forKey:@"DetialInformation"];
    [tempArray addObject:Dict_WKWebView];
    
    #pragma mark - ---------- QuickLook ----------
    NSMutableDictionary *Dict_QuickLook = [NSMutableDictionary dictionary];
    [Dict_QuickLook setObject:@"暂无" forKey:@"BGImage"];
    [Dict_QuickLook setObject:@"QuickLook.png" forKey:@"EffectImage"];
    [Dict_QuickLook setObject:@"Dict_QuickLook相关" forKey:@"Title"];
    [Dict_QuickLook setObject:@"6" forKey:@"StartNumber"];
    [Dict_QuickLook setObject:@"QuickLookController" forKey:@"ClassName"];
    [Dict_QuickLook setObject:@"预览文件界面-例如:PDF,Excel,Word,等等文件格式均可预览" forKey:@"DetialInformation"];
    [tempArray addObject:Dict_QuickLook];
    
    #pragma mark - ---------- 其他类目 ----------
    NSMutableDictionary *Dict_OhterMix = [NSMutableDictionary dictionary];
    
    [Dict_OhterMix setObject:@"暂无" forKey:@"BGImage"];
    [Dict_OhterMix setObject:@"MotionEffect.png" forKey:@"EffectImage"];
    [Dict_OhterMix setObject:@"其他混合功能实现" forKey:@"Title"];
    [Dict_OhterMix setObject:@"6" forKey:@"StartNumber"];
    [Dict_OhterMix setObject:@"MixPartController" forKey:@"ClassName"];
    [Dict_OhterMix setObject:@"包含了Socke实现的京东接口抓取" forKey:@"DetialInformation"];
    [tempArray addObject:Dict_OhterMix];
    
    
    #pragma mark - ---------- 加载数据完毕-返回数组 ----------
    return tempArray;
}




@end
