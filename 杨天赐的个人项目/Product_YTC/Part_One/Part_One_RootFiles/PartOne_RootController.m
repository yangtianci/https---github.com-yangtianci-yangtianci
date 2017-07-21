//
//  PartOne_RootController.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/20.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "PartOne_RootController.h"

#import "CardItem.h"

#import "Part_One_ViewModel.h"
#import "Part_One_Model.h"

#import <Security/Security.h>

@interface PartOne_RootController ()

@property (strong, nonatomic) Part_One_ViewModel *V_M;

@end

@implementation PartOne_RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.V_M = [[Part_One_ViewModel alloc]init];
    
    [self TotalConfiguration];
    
    self.tabBarController.tabBar.hidden = NO;

    self.DataSourceArray = [self.V_M GetDataSourceArray];
    
}

#pragma mark ||=====================  整体设置  =====================||

static NSString *itemIdentifier = @"itemIdentifier_MainPage";
-(void)TotalConfiguration{
    
    self.navigationItem.title = @"Ready,GO!";
    [self SetNavBarImageWithName:@"BlueSky.png"];
    
    [self.CustomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.right.left.offset(0);
        make.bottom.offset(0);
    }];
    
    self.CustomCollectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    CGFloat itemWidth = ScreenWidth - 10;
    CGFloat itemHeight = itemWidth * 0.6;
    self.flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.flowLayout.minimumLineSpacing = 8;
    
    [self.CustomCollectionView registerNib:[UINib nibWithNibName:@"CardItem" bundle:nil] forCellWithReuseIdentifier:ItemIdentifier_Default];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.DataSourceArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CardItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier_Default forIndexPath:indexPath];
    
    [cell SetShadow];
    
    cell.Model = self.DataSourceArray[indexPath.row];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Part_One_Model *model = self.DataSourceArray[indexPath.row];
    
    Class VCClass = NSClassFromString(model.ClassName);
    
    id VC = [[VCClass alloc]init];
    
    [self.navigationController pushViewController:(UIViewController*)VC animated:YES];
    
}









@end
