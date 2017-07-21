//
//  Part_One_Model.h
//  杨天赐的个人项目
//
//  Created by yang on 16/12/26.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "BaseModel.h"

@interface Part_One_Model : BaseModel

@property (strong, nonatomic) UIImage *BGImage;

@property (copy, nonatomic) NSString *EffectImage;

@property (copy, nonatomic) NSString *Title;

@property (copy, nonatomic) NSString *DetialInformation;

@property (copy, nonatomic) NSString *ClassName;

@property (assign, nonatomic) NSInteger StartNumber;

@end
