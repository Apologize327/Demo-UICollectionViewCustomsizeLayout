//
//  StudyNSArrayController.m
//  Demo-collectionView不规则排列
//
//  Created by Suning on 16/12/22.
//  Copyright © 2016年 jf. All rights reserved.
//
//  筛选arrayContents包含了哪些arrayFilter元素

#import "StudyNSArrayController.h"

@interface StudyNSArrayController ()

@property(nonatomic,strong) NSArray *arrayFilter;
@property(nonatomic,strong) NSMutableArray *arrayContents;

@end

@implementation StudyNSArrayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.arrayFilter = [NSArray arrayWithObjects:@"pict", @"blackrain", @"ip", nil];
    self.arrayContents = [NSMutableArray arrayWithObjects:@"I am a picture.", @"I am a guy", @"I am gagaga", @"pict", @"iphone", nil];
    
    [self emunateArrTwoFor];
    [self emunateArrOneFor];
    [self emunateArrNoFor];
}

//原始方法,两个for
-(void)emunateArrTwoFor{
    for (NSString *content in self.arrayContents) {
        for (NSString *filter in self.arrayFilter) {
            if ([filter isEqualToString:content]) {
                NSLog(@"相同元素为%@",content);
            }
        }
    }
}

//改进方法,一个for
-(void)emunateArrOneFor{
    NSArray *temp = [NSArray array];
    for (NSUInteger i=0; i<self.arrayFilter.count; i++) {
        NSString *filter = [self.arrayFilter objectAtIndex:i];
        NSPredicate *predict = [NSPredicate predicateWithFormat:@"self = %@",filter];
        temp = [self.arrayContents filteredArrayUsingPredicate:predict];
        if (temp.count > 0) {
            NSLog(@"-----%@",temp);
        }
    }
}

//最简洁方法，没有for
-(void)emunateArrNoFor{
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"self in %@",self.arrayFilter];
    NSArray *temp = [self.arrayContents filteredArrayUsingPredicate:predict];
    NSLog(@"+++++%@",temp);
}

@end
