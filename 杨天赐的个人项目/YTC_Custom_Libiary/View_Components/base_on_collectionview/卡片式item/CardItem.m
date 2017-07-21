//
//  CardItem.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/26.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "CardItem.h"

#import "Part_One_Model.h"

@interface CardItem ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *InformationLabel;

@property (weak, nonatomic) IBOutlet UIImageView *ExampleImage;

@property (weak, nonatomic) IBOutlet UIStackView *StartStackView;

@end

@implementation CardItem

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(Part_One_Model *)Model{
    
    _Model = Model;
    
    self.layer.borderColor = [UIColor brownColor].CGColor;
    self.layer.borderWidth = 2;
    
    self.title.text = Model.Title;
    self.InformationLabel.text = Model.DetialInformation;
    self.ExampleImage.image = [UIImage imageNamed:Model.EffectImage];
    
    
}



@end

