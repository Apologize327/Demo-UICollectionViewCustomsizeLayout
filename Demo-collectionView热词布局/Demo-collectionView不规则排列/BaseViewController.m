//
//  BaseViewController.m
//  Demo-collectionView不规则排列
//
//  Created by Suning on 16/12/22.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "BaseViewController.h"
#import "ViewController.h"
#import "StudyNSArrayController.h"

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
}

@property(nonatomic,strong) NSArray *titlesArr;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpBackground];
}

-(void)setUpBackground{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlesArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"cellIdentity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentity];
    }
    cell.textLabel.text = [self.titlesArr objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    [cell.textLabel sizeToFit];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            StudyNSArrayController *vc = [[StudyNSArrayController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            ViewController *vc = [[ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

-(NSArray *)titlesArr{
    if (!_titlesArr) {
        _titlesArr = [NSArray arrayWithObjects:@"数组遍历",@"collectionView不规则排列", nil];
    }
    return _titlesArr;
}

@end
