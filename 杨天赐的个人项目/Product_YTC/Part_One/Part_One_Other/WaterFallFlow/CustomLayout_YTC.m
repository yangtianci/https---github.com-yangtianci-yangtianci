//
//  CustomLayout_YTC.m
//  SmallTest
//
//  Created by yang on 16/12/14.
//  Copyright © 2016年 apple . All rights reserved.
//

#import "CustomLayout_YTC.h"

#import "CustomLayout_Model_YTC.h"

#define CommendMargin 5

#define TWidth self.collectionView.frame.size.width

#define THeight self.collectionView.frame.size.height

@interface CustomLayout_YTC ()

@property (strong, nonatomic) NSMutableArray *columArray;

@end

@implementation CustomLayout_YTC

/**
 
 规则 : 
 
 布局之前 先 获取需要展示的数据资源,数据资源中一定要包含有尺寸信息,其他的无所谓
 
 */

-(void)prepareLayout{
    
    //此处进行布局的时候,需要获取到collectionview的所有数据源
    /**
     1.根据数据源获取需要生成的布局对象的_数量
     2.根据数据源获取到每个布局对象的_尺寸,以便进行布局
     3.此处可以进行多种由布局管理的属性设置,例如contentOffset等等属性
     
     * 如果需要进行辅助视图或装饰视图的布局,也在这里进行布局,并需要提前指定好布局的规则
     
     */
    
    //三排排序
    
    CGFloat itemWidth = (self.collectionView.frame.size.width - 4 * 5) / 3;
    
    self.AttributeArray = [NSMutableArray array];
    
    self.columArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        [self.columArray addObject:@(0)];
    }
    
    for (int o = 0; o < self.item_DataArray.count; o ++) {
        
        NSMutableArray *MiddleArray = self.item_DataArray[o];
        
        for (int j = 0; j < MiddleArray.count; j++) {
            
            CustomLayout_Model_YTC *model = MiddleArray[j];
            
            //分别找出最短行的idnex,y即可
            
            //index
            NSInteger shortIndex = 0;
            CGFloat shortY = MAXFLOAT;
            
            for (int i = 0; i < self.columArray.count; i++) {
                NSNumber *heightNumber = self.columArray[i];
                CGFloat heightNum = [heightNumber floatValue];
                if (heightNum < shortY) {
                    shortY = heightNum;
                    shortIndex = i;
                }
            }
            
            //x
            CGFloat xForItem = shortIndex * ( itemWidth + 5 ) + 5;
            
            //y
            CGFloat yForItem = shortY + 5;
            
            //width
            //固定
            
            //height
            CGFloat scale = model.itemWidth / model.itemHeight;
            CGFloat height = itemWidth / scale;
            
            CGFloat shorYNew = [self.columArray[shortIndex] floatValue] + 5 + height;
            [self.columArray replaceObjectAtIndex:shortIndex withObject:@(shorYNew)];
            
            NSIndexPath *itemI = [NSIndexPath indexPathForRow:j inSection:o];
            
            UICollectionViewLayoutAttributes *itemAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemI];
            
            itemAttribute.frame = CGRectMake(xForItem, yForItem, itemWidth, height);
            
            [self.AttributeArray addObject:itemAttribute];
            
        }
        
        
        #pragma mark - ---------- 此处可以添加辅助视图,就是将下一组的基线在下移即可 ----------
        
        NSInteger index = [self LongestColum];
        CGFloat longest = [self.columArray[index] floatValue] + 50;
        
        [self.columArray removeAllObjects];
        
        for (int u = 0; u < 3; u ++) {
            [self.columArray addObject:@(longest)];
        }
        
    }

    #pragma mark - ---------- 处理supplementView ----------
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //此处根据数据就能获得collectionview内部的所有元素的具体信息
    return self.AttributeArray;
}

#pragma mark - ---------- 区分使用的方法 ----------

//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    //调用此方法时,创建item对象返回
//    return nil;
//}
//
//-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
//    //调用此方法时,创建Decoration对象返回
//    return nil;
//}
//
//-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
//    //调用此方法时,创建SupplementaryView对象返回
//    return nil;
//}


#pragma mark - ---------- 最长列 ----------

-(NSInteger)LongestColum{
    
    NSUInteger longestIndex = 0;
    CGFloat longestValue = 0;
    
    NSUInteger index = 0;
    for (NSNumber *columnHeight in self.columArray) {
        if ([columnHeight floatValue] > longestValue) {
            longestValue = [columnHeight floatValue];
            longestIndex = index;
        }
        index++;
    }

    return longestIndex;
}


-(CGSize)collectionViewContentSize{
    
    CGSize size = self.collectionView.bounds.size;
    NSUInteger longstIndex = [self LongestColum];
    float columnMax = [self.columArray[longstIndex] floatValue];
    size.height = columnMax + 5;
    return size;

}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


@end
