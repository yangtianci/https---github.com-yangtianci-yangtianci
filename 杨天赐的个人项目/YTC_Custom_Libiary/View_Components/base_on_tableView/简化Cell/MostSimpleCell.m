//
//  MostSimpleCell.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/4.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "MostSimpleCell.h"

@interface MostSimpleCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation MostSimpleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.frame = self.bounds;
        [self addSubview:self.titleLabel];
        self.titleLabel .text = @"Null";
        self.titleLabel .font = [UIFont systemFontOfSize:12];
        self.titleLabel .textAlignment = NSTextAlignmentCenter;

    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];

}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
