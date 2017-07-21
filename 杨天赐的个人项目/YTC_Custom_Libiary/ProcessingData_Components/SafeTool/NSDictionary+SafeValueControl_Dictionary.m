//
//  NSDictionary+SafeValueControl_Dictionary.m
//  杨天赐的个人项目
//
//  Created by yang on 16/12/20.
//  Copyright © 2016年 yangtianci. All rights reserved.
//

#import "NSDictionary+SafeValueControl_Dictionary.h"

@implementation NSDictionary (SafeValueControl_Dictionary)

-(void)setValue:(id)value forKey:(NSString *)key{
    if (value == nil || [value isKindOfClass:[NSNull class]] || value == NULL) {
        NSLog(@"\n\n\n\n\n\n此处有空值\n\n\n\n\n\n");
    }else{
        [self setValue:value forKey:key];
    }
}


@end

@implementation NSMutableDictionary (SafeValueControl_MutableDictionary)

//-(void)setObject:(id)anObject forKey:(id<NSCopying>)aKey{
//    
//    if (anObject == nil || [anObject isKindOfClass:[NSNull class]] || anObject == NULL) {
//        NSLog(@"\n\n\n\n\n\n此处有空值\n\n\n\n\n\n");
//    }else{
//        [self setObject:anObject forKey:aKey];
//    }
//    
//}


@end
