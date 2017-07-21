//
//  MixPartController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/13.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "MixPartController.h"
#import <WebKit/WebKit.h>
@interface MixPartController ()

@end

@implementation MixPartController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self TotalConfiguration];

}

#pragma mark - ---------- totalConfiguration ----------

-(void)TotalConfiguration{
    self.navigationItem.title = @"Mix";
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
        CLog(@"\n\n\n\n\n\n这个没有控制器");
        return;
    }
    UIViewController *VC = [[controllerClass alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - ---------- 创建数据 ----------

-(void)CreatData{
    
    //socket短连接
    [self.DataSourceArray addObject:@"Socket_ShortLink_Controller"];
    //运动效果
    [self.DataSourceArray addObject:@"MotionEffectController"];
    //touchID
    [self.DataSourceArray addObject:@"TouchIDController"];
    //多重瀑布流
    [self.DataSourceArray addObject:@"WaterFallFlowController"];
    
}







@end
