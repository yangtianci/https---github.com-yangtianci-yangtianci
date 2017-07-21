//
//  BaseTableViewController.h
//  杨天赐的个人项目
//
//  Created by yang on 16/12/20.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *CustomTableView;

@property (strong, nonatomic) NSMutableArray *DataSourceArray;

@end
