//
//  WheelView.h
//  Demo-抽奖转盘
//
//  Created by Suning on 16/4/5.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelView : UIView

+(instancetype)wheel;

/** 滚动转盘 */
-(void)playTheWheel;

/** 停止转盘 */
-(void)stopTheWheel;

@end
