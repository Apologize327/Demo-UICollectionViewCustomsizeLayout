//
//  JFImgViewCell.m
//  Demo-collectionView不规则排列
//
//  Created by Suning on 16/12/20.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "JFImgViewCell.h"
#import "UIView+Frame.h"
#import "UIColor+RandomColor.h"

@interface JFImgViewCell(){
    UIButton *_btn;
}

@end

@implementation JFImgViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpBackground];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self setUpBackground];
    }
    return self;
}

-(void)setUpBackground{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectZero;
    btn.backgroundColor = [UIColor randomColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:btn];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
    _btn = btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _btn.frame = self.bounds;
}

-(void)setItemName:(NSString *)itemName{
    [_btn setTitle:itemName forState:UIControlStateNormal];
    [_btn setTitle:itemName forState:UIControlStateHighlighted];
}

@end
