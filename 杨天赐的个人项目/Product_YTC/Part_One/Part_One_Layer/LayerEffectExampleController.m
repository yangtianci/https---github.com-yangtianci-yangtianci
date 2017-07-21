//
//  LayerEffectExampleController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/4.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "LayerEffectExampleController.h"

@interface LayerEffectExampleController ()



@end

@implementation LayerEffectExampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TotalConfiguration];
}


#pragma mark - ---------- totalConfiguration ----------

-(void)TotalConfiguration{
    self.navigationItem.title = @"About_Layer";
    [self CreatData];
    [self.CustomTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataSourceArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MostSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_Default];
    
    if (!cell) {
        cell = [[MostSimpleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_Default];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.title = self.DataSourceArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Class controllerClass = NSClassFromString(self.DataSourceArray[indexPath.row]);
    if (controllerClass == nil) {
        [self ShowMessage:@"此项目没有控制器"];
        return;
    }
    UIViewController *VC = [[controllerClass alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - ---------- 创建数据 ----------

-(void)CreatData{
    
    //渐变色Controller
    [self.DataSourceArray addObject:@"GradientLayerController"];
    //克隆图层
    [self.DataSourceArray addObject:@"ReplicatorLayerController"];
    //滚动图层
    [self.DataSourceArray addObject:@"ScrollLayerController"];
    //图层加动画综合案例
    [self.DataSourceArray addObject:@"LayerAddAnimationController"];
    
}


@end
