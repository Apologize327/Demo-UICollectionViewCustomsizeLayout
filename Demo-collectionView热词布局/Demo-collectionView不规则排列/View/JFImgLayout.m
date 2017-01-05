//
//  JFImgLayout.m
//  Demo-collectionView不规则排列
//
//  Created by Suning on 16/12/22.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "JFImgLayout.h"

#define kPadding    10

@interface JFImgLayout()<UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSMutableArray *itemAttributes;

@end

@implementation JFImgLayout

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

//当初始化UICollectionViewLayout后，该方法自动被调用
//计算所有cell的frame
-(void)prepareLayout{
    [super prepareLayout];
    
    //确定item个数
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    //初始化itemAttributes
    self.itemAttributes = [NSMutableArray arrayWithCapacity:itemCount];
    
    //两种写法，内边距由layout定义时就用上边的；由collectionview定义则用下边的
    //第一个cell坐标
    CGFloat xOffSet = self.sectionInset.left;
//    CGFloat xOffSet = self.collectionView.contentInset.left;
    CGFloat yOffSet = self.sectionInset.top;
    //第二个cell坐标
    CGFloat xNextOffSet = self.sectionInset.left;
    for (NSInteger i=0; i<itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        
        xNextOffSet += (self.minimumInteritemSpacing + itemSize.width);
        if (xNextOffSet > self.collectionView.bounds.size.width - self.sectionInset.right) {
            xOffSet = self.sectionInset.left;
            yOffSet += itemSize.height + self.minimumLineSpacing;
            xNextOffSet = self.sectionInset.left + itemSize.width + self.minimumInteritemSpacing;
        } else {
            xOffSet = xNextOffSet - (self.minimumInteritemSpacing + itemSize.width);
        }
        
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attribute.frame = CGRectMake(xOffSet, yOffSet, itemSize.width, itemSize.height);
        [self.itemAttributes addObject:attribute];
    }
    
}

//prepareLayout被调用后，接着调用该方法。
//返回rect内所有元素的布局属性，包括cell、头尾视图等
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.itemAttributes;
}

//下边这个方法和上边的是重复的，可以删除。不过这个更细化，对应到某个indexPath上
//返回indexPath对应位置cell的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemAttributes[indexPath.row];
}

//当边界改变时是否需要刷新布局，一般scroll时需要
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
