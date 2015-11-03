//
//  TopViewController.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "TopViewController.h"
#import "Movie.h"
#import "TopCell.h"
#import "MovieDetailViewController.h"



@interface TopViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_topData;
}
@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Top250";
    
    [self loadData];
}


#pragma mark - 读取数据
- (void)loadData
{
    // 初始化数组
    _topData = [[NSMutableArray alloc] init];
    
    NSDictionary *dic = [MovieJSON readJSONFile:@"top250"];
    for (NSDictionary *d in dic[@"subjects"])
    {
        Movie *movie = [[Movie alloc] initWithContentsOfDictionary:d];
        [_topData addObject:movie];
    }
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _topData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
    
    cell.movie = _topData[indexPath.item];
    
    return cell;
}


// 通过屏幕宽度 计算单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = (kScreenWidth - 10 * 4) / 3;
    CGFloat cellHeight = cellWidth * 1.3;
    return CGSizeMake(cellWidth, cellHeight);
}

// 单元格的选中事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // MovieDetailViewController *detail = [[MovieDetailViewController alloc] init];
    
    // 从故事版中 获取视图控制器
    // 1. 获取故事版对象
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    // 2. 从故事版中 读取视图控制器
    // - (id)instantiateInitialViewController;  // 获取一个故事版的入口
    // - (id)instantiateViewControllerWithIdentifier:(NSString *)identifier; // 获取某个id的视图控制器
    MovieDetailViewController *detail = [storyBoard instantiateViewControllerWithIdentifier:@"detail"];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
