//
//  DataPersistencesController.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/19.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "DataPersistencesController.h"

@interface DataPersistencesController ()



@end

@implementation DataPersistencesController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self totalConfiguration];
}

#pragma mark - ---------- 主要配置 ----------

-(void)totalConfiguration{
    
#pragma mark - ---------- 设置背景图 ----------
    self.BGImageName = @"BG_Wooden.jpeg";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *informationLabel = [[UILabel alloc]init];
    [self.view addSubview:informationLabel];
    informationLabel.numberOfLines = 0;
    informationLabel.textColor = [UIColor whiteColor];
    informationLabel.font = [UIFont systemFontOfSize:15];
    informationLabel.textAlignment = NSTextAlignmentLeft;
    informationLabel.text = @"六种数据持久化存储\n1.\tWriteToFile方法,使用系统自定义API实现,可以多选路径\n2.\tPlist方法,存储内容基本为程序设置,不可存储大量不相关数据,itunes会同步\n3.\t归档解档,主要为了存储自定义对象而存在,所有步骤实现六个方法即可,到此,均为覆盖性存储,不适合大量数据的存储\n4.\tSQlite数据库,适合存储大量需要筛选的重复数据,以FMDB为基础进行二次封装,以适应特定APP\n5.\tCoreData,apple自主开发的基于SQL的数据库,有可视化界面,适用范围与SQL雷同,但是存在表关联以及模糊查询等更加强大的效果,使用及其麻烦,主要是,实体类等\n6.\tKeychain钥匙串,适用于保存隐私数据使用,实现基于keychain的程序卸载后记忆功能";
    [informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(30);
        make.right.offset(-30);
    }];
    informationLabel.backgroundColor = [UIColor clearColor];
    
}






/**
 
 plist文件（属性列表）
 
 preference（偏好设置）
 
 NSKeyedArchiver（归档）
 
 SQLite 3
 
 CoreData

 keychain
 
 */

//WriteFile方式
/**
 元素 :
 1.存储路径
 2.存储数据
 3.atomically表示是否需要先写入一个辅助文件，再把辅助文件拷贝到目标文件地址。这是更安全的写入文件方法，一般都写YES。
 
 不能写成工具类,因为写入方法和读取方法均不相同,相同的只有共同属性 Path
 */

//Plist方式.直接使用NSUserDefault即可完成
/**
 
 //1.获得NSUserDefaults文件
 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
 //2.向文件中写入内容
 [userDefaults setObject:@"AAA" forKey:@"a"];
 [userDefaults setBool:YES forKey:@"sex"];
 [userDefaults setInteger:21 forKey:@"age"];
 //2.1立即同步
 [userDefaults synchronize];
 //3.读取文件
 NSString *name = [userDefaults objectForKey:@"a"];
 BOOL sex = [userDefaults boolForKey:@"sex"];
 NSInteger age = [userDefaults integerForKey:@"age"];
 NSLog(@"%@, %d, %ld", name, sex, age);
 
 */








@end
