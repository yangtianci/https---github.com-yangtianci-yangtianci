//
//  PartTwo_RootController.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/20.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "PartTwo_RootController.h"

#import "SecondModuleCell.h"

@interface PartTwo_RootController ()

@end

@implementation PartTwo_RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"实例功能";
    [self SetNavBarImageWithName:@"BlueSky.png"];
    [self CreatData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataSourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    SecondModuleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_Default];
    if (!cell) {
        cell = [[SecondModuleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_Default];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dataD = self.DataSourceArray[indexPath.row];
    cell.Title = dataD[@"title"];
    cell.icon = dataD[@"icon"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *DataDict = self.DataSourceArray[indexPath.row];
    
    Class controllerClass = NSClassFromString(DataDict[@"controllerName"]);
    
    [self.navigationController pushViewController:[[controllerClass alloc]init] animated:YES];
}

#pragma mark - ---------- 设计页面数据 ----------

-(void)CreatData{
    
    #pragma mark - ---------- 友盟 ----------
    NSMutableDictionary *UMDict = [NSMutableDictionary dictionary];
    [UMDict setObject:@"友盟集成(统计,分享,错误收集等)" forKey:@"title"];
    [UMDict setObject:@"UMeng.jpeg" forKey:@"icon"];
    [UMDict setObject:@"UMengThirdControllerViewController" forKey:@"controllerName"];
    
    [self.DataSourceArray addObject:UMDict];
    
    #pragma mark - ---------- 极光 ----------
    NSMutableDictionary *JGDict = [NSMutableDictionary dictionary];
    [JGDict setObject:@"极光集成(语音短信验证等)" forKey:@"title"];
    [JGDict setObject:@"JG.png" forKey:@"icon"];
    [JGDict setObject:@"JiGuangThirdViewController" forKey:@"controllerName"];
    
    [self.DataSourceArray addObject:JGDict];

    #pragma mark - ---------- 讯飞 ----------
    NSMutableDictionary *IFDict = [NSMutableDictionary dictionary];
    [IFDict setObject:@"讯飞语音听写.合成.验证等等" forKey:@"title"];
    [IFDict setObject:@"Ifly.png" forKey:@"icon"];
    [IFDict setObject:@"IFlyThirdViewController" forKey:@"controllerName"];

    [self.DataSourceArray addObject:IFDict];

    [self.CustomTableView reloadData];
}




@end
