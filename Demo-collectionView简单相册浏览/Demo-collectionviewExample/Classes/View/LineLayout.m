//
//  LineLayout.m
//  Demo-collectionviewExample
//
//  Created by Suning on 16/3/18.
//  Copyright © 2016年 jf. All rights reserved.
//


#import "LineLayout.h"
#import "UIView+Frame.h"

@implementation LineLayout

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

/** 布局的初始化操作,就是制定frame */
-(void)prepareLayout{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    //设置内边距
    CGFloat insert = (self.collectionView.width - self.itemSize.width)/2;
    //就是一个section中所有cell在collectionview的内边距
    self.sectionInset = UIEdgeInsetsMake(0, insert, 0, insert);
}

/** 当collectionview的显示范围发生变化时，是否需要重新刷新布局
 *  刷新布局时，会重新调用 
 *   prepareLayout
 *  layoutAttributesForElementsInRect: 方法
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

/**
 *  返回的数组是rect(矩形方框)范围内所有cell的布局属性，即frame
 *  一个cell对应一个UICollectionViewLayoutAttributes对象
 *
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //取出父类算出的布局属性
    NSArray *attsArray = [super layoutAttributesForElementsInRect:rect];
    
    //collectionview中心点
    CGFloat centerX = self.collectionView.width/2 + self.collectionView.contentOffset.x;
//    NSLog(@"====%f",centerX);
    
    for (UICollectionViewLayoutAttributes *attr in attsArray) {
        //cell的中心点x和collectionview最中心点x的 间距
        CGFloat space = ABS(attr.center.x - centerX);
        //为了求view缩放的角度
        CGFloat scale = 1 - space/self.collectionView.width;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attsArray;
}

/** 计算collectionview停止移动时的偏移量,手离开屏幕时会调用。
 *  proposedContentOffset为停止时本来应该到的位置
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //停止移动时的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x; //最终停下来时的x
    rect.size = self.collectionView.frame.size;
    
    NSArray *attsArr = [super layoutAttributesForElementsInRect:rect];
    //计算停止滚动时collectionview的中心点x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.width/2;
    
    CGFloat minSpace = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attsArr) {
        if (ABS(minSpace) > ABS(attr.center.x - centerX)) {
            minSpace = attr.center.x - centerX;
        }
    }
    
    //修改原有偏移量
    proposedContentOffset.x += minSpace;
    return proposedContentOffset;
}

@end
