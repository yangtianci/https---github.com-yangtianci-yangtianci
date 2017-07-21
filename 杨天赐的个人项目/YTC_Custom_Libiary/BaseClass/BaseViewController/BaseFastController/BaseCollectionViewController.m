//
//  BaseCollectionViewController.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/20.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ConfigurationTotal];
}

-(void)ConfigurationTotal{
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat width = (ScreenWidth - 3 * DefaultMargin) / 2;
    self.flowLayout.itemSize = CGSizeMake(width, width * 0.8);
    
    self.CustomCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    self.CustomCollectionView.backgroundColor = [UIColor whiteColor];
    self.CustomCollectionView.delegate = self;
    self.CustomCollectionView.dataSource = self;
    [self.view addSubview:self.CustomCollectionView];
    [self.CustomCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ItemIdentifier_Default];
    
    self.CustomCollectionView.showsVerticalScrollIndicator = NO;
    self.CustomCollectionView.showsHorizontalScrollIndicator = NO;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
