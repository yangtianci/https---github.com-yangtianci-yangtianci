//
//  BaseCollectionViewController.h
//  杨天赐的个人项目
//
//  Created by yang on 16/12/20.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *CustomCollectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSMutableArray *DataSourceArray;

@end
