//
//  MainViewController.m
//  Demo-collectionviewExample
//
//  Created by Suning on 16/3/17.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+Frame.h"
#import "CircleLayout.h"
#import "LineLayout.h"
#import "Masonry.h"

#define mScreenWidth    [UIScreen mainScreen].bounds.size.width

static NSString *identifier = @"imageCell";

@interface ImageCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *imgCell;
@property(nonatomic,copy) UIImage *img;

@end

@implementation ImageCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgCell = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.imgCell.layer.borderColor = [UIColor whiteColor].CGColor;
        self.imgCell.layer.borderWidth = 5;
        
        [self.contentView addSubview:self.imgCell];
        
        [self.imgCell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    return self;
}

-(void)setImg:(UIImage *)img{
    _img = img;
    self.imgCell.image = img;
}

@end

@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collectionView;
    UIView *_view;
}

@property(nonatomic,strong) NSMutableArray *itemArr;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpCellItems];
    
    [self setUpCollectionView];

}

-(void)setUpCellItems{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        [tempArr addObject:img];
    }
    self.itemArr = tempArr;
}

-(void)setUpCollectionView{
    
    if (nil == _collectionView) {
        CircleLayout *circle = [[CircleLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, mScreenWidth, 300) collectionViewLayout:circle];
        [_collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:identifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
}

/** 点击切换属性 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.itemArr.count == 0) {
        [self setUpCellItems];
    }
    
    CircleLayout *circle = [[CircleLayout alloc]init];

    if ([_collectionView.collectionViewLayout isKindOfClass:[LineLayout class]]) {
        [_collectionView setCollectionViewLayout:circle animated:YES];
    } else {
        LineLayout *layout = [[LineLayout alloc]init];
        layout.itemSize = CGSizeMake(160,160);
        [_collectionView setCollectionViewLayout:layout animated:YES];
    }
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell *imgCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    imgCell.img = [self.itemArr objectAtIndex:indexPath.item];
    
    return imgCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.itemArr removeObjectAtIndex:indexPath.item];
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
