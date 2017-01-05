//
//  JFImgLayout.h
//  Demo-collectionView不规则排列
//
//  Created by Suning on 16/12/22.
//  Copyright © 2016年 jf. All rights reserved.
//
//  不规则排列的layout

#import <UIKit/UIKit.h>

@protocol JFCollectionViewLayoutDelegate <UICollectionViewDelegateFlowLayout>

@end

@interface JFImgLayout : UICollectionViewFlowLayout

@property(nonatomic,assign) id<JFCollectionViewLayoutDelegate> delegate;

@end
