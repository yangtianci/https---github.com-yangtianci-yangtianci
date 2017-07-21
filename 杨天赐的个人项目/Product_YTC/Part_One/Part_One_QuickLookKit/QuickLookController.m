//
//  QuickLookController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/22.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "QuickLookController.h"

#import <QuickLook/QuickLook.h>

@interface QuickLookController ()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>

@property (strong, nonatomic) NSURL *FileUrl;

@end

@implementation QuickLookController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CreatFakeData];
    
    [self totalConfiguration];
   
}

#pragma mark - ---------- 主要配置 ----------

-(void)totalConfiguration{
    //控制当前控制器对应的导航条显示的内容
    self.navigationItem.title=@"预览";
    
    self.FileUrl = [[NSURL alloc]init];
    
    self.CustomTableView.delegate = self;
    self.CustomTableView.dataSource = self;
    
}

#pragma mark - ---------- tableView代理方法 ----------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataSourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_Default];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier_Default];
    }
    cell.textLabel.text = self.DataSourceArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:self.DataSourceArray[indexPath.row] ofType:nil];
    self.FileUrl = [NSURL fileURLWithPath:path];
    
    if ([QLPreviewController canPreviewItem:(id<QLPreviewItem>)self.FileUrl]) {
        QLPreviewController *qlVc = [[QLPreviewController alloc] init];
        qlVc.view.frame = self.view.bounds;
        qlVc.delegate = self;
        qlVc.dataSource = self;
        qlVc.navigationController.navigationBar.userInteractionEnabled = YES;
        qlVc.view.userInteractionEnabled = YES;
        [self presentViewController:qlVc animated:YES completion:nil];
    }
}

#pragma mark - QLPreviewController 代理方法
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return self.FileUrl;
}


#pragma mark - ---------- 创建假数据 ----------
-(void)CreatFakeData{
    [self.DataSourceArray addObject:@"Excel.xlsx"];
    [self.DataSourceArray addObject:@"Word.docx"];
    [self.DataSourceArray addObject:@"PPT.pptx"];
}








@end
