//
//  BaseTableViewController.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/20.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.DataSourceArray = [NSMutableArray array];
    [self creatCustomTableView];
}

#pragma mark - ---------- 主要UI ----------

static NSString * const identifierForCustomIdentifier = @"identifierForCustomTableView";

-(void)creatCustomTableView{
    
    self.CustomTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.CustomTableView];
    
    self.CustomTableView.delegate = self;
    self.CustomTableView.dataSource = self;
    
    self.CustomTableView.showsVerticalScrollIndicator = NO;
    self.CustomTableView.showsHorizontalScrollIndicator = NO;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
