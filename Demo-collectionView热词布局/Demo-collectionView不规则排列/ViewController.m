//
//  ViewController.m
//  Demo-collectionView不规则排列
//
//  Created by Suning on 16/12/20.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "JFImgViewCell.h"
#import "JFImgLayout.h"

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kPadding    10

static NSString *cellIdentity = @"cellIdentity";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JFCollectionViewLayoutDelegate>{
    UICollectionView *_collectionView;
}

@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) NSMutableArray *dataWidthArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpBackground];
}

-(void)setUpBackground{
    JFImgLayout *layout = [[JFImgLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = kPadding;
    layout.minimumInteritemSpacing = kPadding;
    layout.sectionInset = UIEdgeInsetsMake(kPadding, kPadding, 0, kPadding);
    layout.delegate = self;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[JFImgViewCell class] forCellWithReuseIdentifier:cellIdentity];
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JFImgViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentity forIndexPath:indexPath];
    if (nil == cell) {
        cell = [[JFImgViewCell alloc]init];
    }
    cell.itemName = [self.dataArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = [[self.dataWidthArr objectAtIndex:indexPath.row] CGSizeValue];
    return itemSize;
}

//这与自定义layout重复，也有影响
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(kPadding, kPadding, 0, kPadding);
//}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray arrayWithObjects:@"华为Mate 9",@"vivo X9（全网通）",@"苹果iPhone 7",@"荣耀Magic（全网通）",@"中兴天机7",@"OPPO R9s",@"苹果iPhone 7 Plus",@"vivo Xplay6（全网通）",@"华为P9",@"荣耀畅玩6X",@"一加手机3T",@"索尼Xperia XZ",@"酷派cool S1", nil];
    }
    return _dataArr;
}

-(NSMutableArray *)dataWidthArr{
    if (!_dataWidthArr) {
        _dataWidthArr = [NSMutableArray arrayWithCapacity:self.dataArr.count];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyle};
        for (NSString *item in self.dataArr) {
            CGSize labelSize = [item boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            [_dataWidthArr addObject:[NSValue valueWithCGSize:CGSizeMake(labelSize.width+10, 44)]];
        }
    }
    return _dataWidthArr;
}

@end
