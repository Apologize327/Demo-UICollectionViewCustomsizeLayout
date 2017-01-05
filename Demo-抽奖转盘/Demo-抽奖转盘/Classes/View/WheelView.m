//
//  WheelView.m
//  Demo-抽奖转盘
//
//  Created by Suning on 16/4/5.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "WheelView.h"
#import "UIView+Frame.h"
#import "WheelBtn.h"

@interface WheelView(){
    UIImageView *_baseRollView;
    CADisplayLink *_link;
    
}

@property(nonatomic,strong) UIButton *selectedBtn; //被选择的按钮

@end

@implementation WheelView

-(instancetype)init{
    if (self = [super init]) {
        UIImageView *baseView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LuckyBaseBackground"]];
        baseView.frame = CGRectMake(0, 0, 286, 286);
        [self addSubview:baseView];
        
        UIImageView *baseRollView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LuckyRotateWheel"]];
        baseRollView.frame = baseView.frame;
        baseRollView.center = baseView.center;
        _baseRollView = baseRollView;
        _baseRollView.userInteractionEnabled = YES;
        [self addSubview:baseRollView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 100, 100);
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyCenterButton"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyCenterButtonPressed"] forState:UIControlStateHighlighted];
        btn.center = baseRollView.center;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(clickTheCenterBtn) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
        UIImage *bigImageSelected = [UIImage imageNamed:@"LuckyAstrologyPressed"];
        CGFloat scaleNum = [UIScreen mainScreen].scale;
        CGFloat smallImgW = bigImage.size.width/12 * scaleNum;
        CGFloat smallImgH = bigImage.size.height * scaleNum;
        
        //添加12星座按钮，相当于将第一个按钮依次旋转30度得到环形上的按钮
        for (NSInteger i=0; i<12; i++) {
            //每个按钮弧度
            CGFloat angle = (30 * i)/180.0 * M_PI;
            WheelBtn *btn = [WheelBtn buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 68, 143);
            //按钮图片
            CGRect smallRect = CGRectMake(i*smallImgW, 0, smallImgW, smallImgH);
            CGImageRef smallImg = CGImageCreateWithImageInRect(bigImage.CGImage, smallRect);
            CGImageRef smallImgSelected = CGImageCreateWithImageInRect(bigImageSelected.CGImage, smallRect);
            [btn setImage:[UIImage imageWithCGImage:smallImg] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageWithCGImage:smallImgSelected] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
            
            btn.layer.anchorPoint = CGPointMake(0.5, 1);
            btn.layer.position = CGPointMake(_baseRollView.width/2, _baseRollView.height/2);

            btn.transform = CGAffineTransformMakeRotation(angle);
//            btn.backgroundColor = [UIColor blueColor];
            
            [btn addTarget:self action:@selector(clickTheStarBtn:) forControlEvents:UIControlEventTouchDown];
            [_baseRollView addSubview:btn];
            
            if (i==0) {
                [self clickTheStarBtn:btn];
            }
        }
    }
    return self;
}

+(instancetype)wheel{
    return [[WheelView alloc]init];
}

-(void)clickTheStarBtn:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

-(void)playTheWheel{
//    CAKeyframeAnimation *anima = [CAKeyframeAnimation animation];
//    anima.keyPath = @"transform.rotation";
//    anima.values = @[@(0),@(M_PI*2)];
//    anima.duration = 6.0f;
//    anima.repeatCount = MAXFLOAT;
//    anima.removedOnCompletion = NO;
//    anima.fillMode = kCAFillModeForwards;
//    [_baseRollView.layer addAnimation:anima forKey:@"baseViewRoll"];
    
    if (_link) {
        return;
    }
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(scrollTheView)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link = link;
}

-(void)scrollTheView{
    _baseRollView.transform = CGAffineTransformRotate(_baseRollView.transform, M_PI/300);
}

-(void)stopTheWheel{
    [_link invalidate];
    _link = nil;
}

/**
 *  点击选号按钮
 */
-(void)clickTheCenterBtn{
    [self stopTheWheel];
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"transform.rotation";
    anima.toValue = @(M_PI*2*3);
    anima.duration = 1.5;
    anima.delegate = self;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_baseRollView.layer addAnimation:anima forKey:nil];
    self.userInteractionEnabled = NO;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.userInteractionEnabled = YES;
    
    //2秒后开始转盘
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playTheWheel];
    });
}

@end
