//
//  YTC_TabbarController.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/20.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "YTC_TabbarController.h"

#import "PartOne_NavController.h"
#import "PartTwo_NavController.h"

#import "PartOne_RootController.h"
#import "PartTwo_RootController.h"

@interface YTC_TabbarController ()

@end

@implementation YTC_TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CRandomColor;
    
    PartOne_RootController *One_root = [[PartOne_RootController alloc]init];
    One_root.showTabbar = YES;
    PartOne_NavController *partOneNav = [[PartOne_NavController alloc]initWithRootViewController:One_root];
    partOneNav.tabBarItem.title = @"StartPlace";
    
    PartTwo_RootController *Two_root = [[PartTwo_RootController alloc]init];
    Two_root.showTabbar = YES;
    PartTwo_NavController *partTwoNav = [[PartTwo_NavController alloc]initWithRootViewController:Two_root];
    partTwoNav.tabBarItem.title = @"实例页面";
    partTwoNav.tabBarItem.badgeColor = CRandomColor;
    partTwoNav.tabBarItem.badgeValue = @"Import";
    
    
    
    [self addChildViewController:partOneNav];
    [self addChildViewController:partTwoNav];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
