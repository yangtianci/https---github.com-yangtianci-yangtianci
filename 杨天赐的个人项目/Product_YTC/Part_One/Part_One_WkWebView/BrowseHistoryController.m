//
//  BrowseHistoryController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/20.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "BrowseHistoryController.h"

@interface BrowseHistoryController ()

@end

@implementation BrowseHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ItemList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_Default];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_Default];
    }
    
    WKBackForwardListItem *item = self.ItemList[indexPath.row];
    
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",item.URL];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.HistoryBlock) {
        self.HistoryBlock(self.ItemList[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - ---------- Data ----------
-(void)setItemList:(NSArray<WKBackForwardListItem *> *)ItemList{
    
    _ItemList = ItemList;
    
    [self.CustomTableView reloadData];
    
}



@end
