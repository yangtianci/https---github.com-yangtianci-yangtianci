//
//  BrowseHistoryController.h
//  杨天赐的个人项目
//
//  Created by yang on 17/1/20.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "BaseTableViewController.h"

#import <WebKit/WebKit.h>

@interface BrowseHistoryController : BaseTableViewController

@property (strong, nonatomic) NSArray<WKBackForwardListItem *> *ItemList;

@property (copy, nonatomic) void(^HistoryBlock)(WKBackForwardListItem*item);

@end
