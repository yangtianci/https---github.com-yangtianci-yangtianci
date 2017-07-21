//
//  WaterFallFlowController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/19.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "WaterFallFlowController.h"

#import "CustomLayout_YTC.h"

#import "CustomLayout_Model_YTC.h"

/**
 
 瀑布流核心原理 : 针对布局内部每个控件返回对应的属性即可,不考虑辅助视图以及装饰视图的情况下,cell只需要设置好index以及对应的属性,然后,返回数组即可,只要获取了数组,那么系统自动根据所定制的idnex获取对应的属性对象即可,没有想象中的需要二维数组那么麻烦
 整体就是一维数组,属性对象的数量和item的数量不一致,是因为,一个collectionView想要成为可用的视图
 1.内部存在需要的item控件对象 (数据源方法获取生成)
 2.item对象的属性对象存在 (布局对象生成赋值,需要根据collectionview的数量,否则就不一致)
 3.针对预定显示的一组数据,collectionview负责形成其视图对象,layout负责形成视图对象的布局
 
 单层瀑布流 : 针对 index.section == 0 的item进行属性设置即可
 
 多层瀑布流 : 需要针对不同的 section 进行不同的改变
 
 */

@interface WaterFallFlowController ()

@property (strong, nonatomic) UICollectionView *MainView;

@property (strong, nonatomic) CustomLayout_YTC *WaterFallFlow;

@end

@implementation WaterFallFlowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.DetialInformation = @"区别于多层单层瀑布流,即使是多组数据也能进行瀑布流修饰";
    
    [self totalConfiguration];
    
}

#pragma mark - ---------- 主要配置 ----------

-(void)totalConfiguration{
    
    self.WaterFallFlow = [[CustomLayout_YTC alloc]init];
    
    [self.CustomCollectionView setCollectionViewLayout:self.WaterFallFlow];
    
    [self CreatFakeData];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.DataSourceArray.count;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSMutableArray *tempArray = self.DataSourceArray[section];
    
    return tempArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier_Default forIndexPath:indexPath];
    
    //    cell.layer.cornerRadius = cell.bounds.size.width / 2;
    //    cell.layer.masksToBounds = YES;
    
    NSMutableArray *tempArray = self.DataSourceArray[indexPath.section];
    
    CustomLayout_Model_YTC *model = tempArray[indexPath.row];
    
    cell.backgroundColor = model.RadomBG_Color;
    
    return cell;
    
}

#pragma mark - ---------- CreatFakeData ----------

-(void)CreatFakeData{
    
    self.DataSourceArray = [NSMutableArray array];
    
    for (int i = 0; i < 3; i ++) {
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            
            NSMutableDictionary *data = [NSMutableDictionary dictionary];
            
            [data setObject:CRandomColor forKey:@"RadomBG_Color"];
            
            CGFloat height = random()%1000 + 200;
            CGFloat width = random()%1000 + 200;
            
            if (i > 30) {
                height = random()%300 + 20;
                width = random()%300 + 20;
            }
            
            [data setObject:@(height) forKey:@"itemHeight"];
            [data setObject:@(width) forKey:@"itemWidth"];
            
            CustomLayout_Model_YTC *itemModel = [[CustomLayout_Model_YTC alloc]initWithDict:data];
            
            [tempArray addObject:itemModel];
            
        }
        
        [self.DataSourceArray addObject:tempArray.copy];
    }
 
    //获取到真是信息之后,需要现将数据传送给布局进行计算
    self.WaterFallFlow.item_DataArray = self.DataSourceArray;
    
    [self.CustomCollectionView reloadData];
    
}



@end
