//
//  CircleLayout.m
//  Demo-collectionviewExample
//
//  Created by Suning on 16/3/18.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "CircleLayout.h"
#import "UIView+Frame.h"

@interface CircleLayout()

@property(nonatomic,strong) NSMutableArray *attrsArr;//属性集合

@end


@implementation CircleLayout

/** 布局的初始化操作 */
-(void)prepareLayout{
    [super prepareLayout];
    
    //每次执行该方法须清除所有attrabutes，重新加载新的
    [self.attrsArr removeAllObjects];
    //获取collectionview的item数
    NSInteger itemNum = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i=0; i<itemNum; i++) {
        //自定义布局属性
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArr addObject:attribute];
    }
}

/** 返回所有布局属性 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArr;
}

/** 返回indexPath位置对应的cell的布局属性 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    //半径
    CGFloat radius = 120;
    
    //圆心
    CGFloat circleX = self.collectionView.width/2;
    CGFloat circleY = self.collectionView.height/2;
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(60, 60);
    
    //若只剩一个item
    if (itemCount == 1) {
        attrs.center = CGPointMake(circleX, circleY);
        attrs.size = CGSizeMake(200, 200);
    } else{
        //每个cell的角度
        CGFloat angle = (2*M_PI)/itemCount*indexPath.item;
        CGFloat centerX = circleX + radius*sin(angle);
        CGFloat centerY = circleY + radius*cos(angle);
        attrs.center = CGPointMake(centerX, centerY);
    }
    return attrs;
}

-(NSMutableArray *)attrsArr{
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}

@end
