//
//  SecondModuleCell.m
//  杨天赐的个人项目
//
//  Created by yang on 17/2/6.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "SecondModuleCell.h"

@interface SecondModuleCell ()

@property (strong, nonatomic) UIImageView *iconImageView;

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation SecondModuleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self ConfigurationUI];
    }
    return self;
}

#pragma mark - ---------- UI配置 ----------
-(void)ConfigurationUI{
    
    self.iconImageView = [[UIImageView alloc]init];
    [self addSubview:self.iconImageView];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(5);
        make.bottom.offset(-5);
        make.width.mas_equalTo(90);
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    [self addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.offset(5);
        make.bottom.offset(-5);
        make.left.equalTo(self.iconImageView.mas_right).with.offset(5);
    }];
    
}

#pragma mark - ---------- 赋值 ----------

-(void)setIcon:(NSString *)icon{
    _icon = icon;
    self.iconImageView.image = [UIImage imageNamed:icon];
}

-(void)setTitle:(NSString *)Title{
    _Title = Title;
    self.titleLabel.text = Title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
