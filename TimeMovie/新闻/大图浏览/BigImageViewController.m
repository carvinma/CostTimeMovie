//
//  BigImageViewController.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/25.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "BigImageViewController.h"
#import "BigImageCell.h"


@interface BigImageViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_imageCollectionView;
    
    
    BOOL _isHiddenNavigationBar;
}
@end

@implementation BigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片浏览";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _isHiddenNavigationBar = NO;
    
    // 创建视图
    [self _createView];
    
    
    // 根据纪录的单元格索引 来显示那个单元格
    [_imageCollectionView scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    // 接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenNavigationBar) name:kHiddenNavigationBar object:nil];

}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 隐藏导航栏的方法
- (void)hiddenNavigationBar
{
    _isHiddenNavigationBar = !_isHiddenNavigationBar;
    
    // 在视图控制器中 隐藏导航栏的方法
    [self.navigationController setNavigationBarHidden:_isHiddenNavigationBar animated:YES];
    
    // 隐藏状态栏
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:_isHiddenNavigationBar withAnimation:UIStatusBarAnimationSlide];
}


- (void)_createView
{
    // 创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - 64);
    layout.minimumInteritemSpacing = 10;
    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 四周空隙
    layout.sectionInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    
    
    _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth + 10, kScreenHeight - 64) collectionViewLayout:layout];
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    _imageCollectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_imageCollectionView];
    
    // 滑动视图的分页显示效果
    _imageCollectionView.pagingEnabled = YES;
    
    // 隐藏滑块
    _imageCollectionView.showsHorizontalScrollIndicator = NO;
    
    // 单元格的注册
    [_imageCollectionView registerClass:[BigImageCell class] forCellWithReuseIdentifier:@"BigImageCell"];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 显示图片
    // 2. 双击放大/缩小
    // 3. 单击隐藏导航栏和状态栏
    // 4. 双指捏合 缩放视图
    BigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BigImageCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blackColor];
    // 传入图片数据
    cell.imageURL = _imageData[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate
/**
 *  当某个单元格 结束显示时调用的方法
 *
 *  @param collectionView
 *  @param cell           结束显示的单元格
 *  @param indexPath      索引路径
 */
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取单元格 强制类型转换
    BigImageCell *big = (BigImageCell *)cell;
    // 将单元格中的图片缩放还原
    [big backImageZoomingScale];
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
