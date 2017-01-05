//
//  WheelBtn.m
//  Demo-抽奖转盘
//
//  Created by Suning on 16/4/6.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "WheelBtn.h"

@implementation WheelBtn

/**
 * 设置btn内的imageView位置
 *
 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imgW = 45;
    CGFloat imgH = 50;
    CGFloat imgX = (contentRect.size.width - imgW)/2;
    CGFloat imgY = 20;
    return CGRectMake(imgX, imgY, imgW, imgH);
    
}

@end
