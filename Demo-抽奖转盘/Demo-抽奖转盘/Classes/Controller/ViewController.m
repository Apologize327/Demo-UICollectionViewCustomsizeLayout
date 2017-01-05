//
//  ViewController.m
//  Demo-CALayerTest
//
//  Created by Suning on 16/3/29.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "WheelView.h"

#define mScreenWidth    [UIScreen mainScreen].bounds.size.width
#define mScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property(nonatomic,strong) UIView *animaView;
@property(nonatomic,strong) NSArray *nameArr;
@property(nonatomic,strong) WheelView *wheelView;
@property(nonatomic,strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(50, 50, 100, 50);
    [playBtn setTitle:@"转动" forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:playBtn];
    [playBtn addTarget:self action:@selector(playIt) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.frame = CGRectMake(playBtn.right+80 , 50, 100, 50);
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:stopBtn];
    [stopBtn addTarget:self action:@selector(stopIt) forControlEvents:UIControlEventTouchUpInside];

    [self setUpWheelView];
    
}

-(void)setUpWheelView{
    WheelView *wheel = [WheelView wheel];
    wheel.frame = CGRectMake(0, 100, 286, 286);
    self.wheelView = wheel;
    wheel.center = self.view.center;
    [self.view addSubview:wheel];
}

/** 滚动转盘 */
-(void)playIt{
    [self.wheelView playTheWheel];
}

/** 停止转盘 */
-(void)stopIt{
    [self.wheelView stopTheWheel];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

/**
 *
 */
-(void)callPhone{
    //最简单的方式，直接跳到打电话界面，缺点是电话打完后会停留在通话记录界面，不会返回到应用界面
    NSURL *url = [NSURL URLWithString:@"tel://10010"];
    [[UIApplication sharedApplication] openURL:url];
    
    //拨号前询问用户是否拨打，打完后回到应用界面，缺点是为私有API，可能审核不通过
    NSURL *url2 = [NSURL URLWithString:@"telprompt://10010"];
    [[UIApplication sharedApplication] openURL:url2];
    
    //创建webview来加载url，播完后能自动回到应用。需要注意的是，这个webview不能添加到界面上来，否则会挡住其他界面
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://10010"]]];
}

@end
