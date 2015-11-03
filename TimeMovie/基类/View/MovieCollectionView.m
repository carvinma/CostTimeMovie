//
//  MovieCollectionView.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/28.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "MovieCollectionView.h"

@implementation MovieCollectionView


- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    // 创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 单元格大小
    _itemSize = CGSizeMake(frame.size.height * 0.6, frame.size.height * 0.9);
    layout.itemSize = _itemSize;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置四周距离
    CGFloat x = (frame.size.width - _itemSize.width) / 2;
    layout.sectionInset = UIEdgeInsetsMake(0, x, 0, x);
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self)
    {
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        // self.pagingEnabled = YES;
        
        // 注册单元格
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        UINib *nib = [UINib nibWithNibName:@"PostCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellWithReuseIdentifier:@"postCell"];
    }
    
    return self;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _movieData.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}


#pragma mark - UIScrollViewDelegate
/**
 *  滑动视图 即将结束拖拽时 调用的代理方法
 *
 *  @param scrollView          滑动视图
 *  @param velocity            手指离开屏幕时，视图滑动的速度
 *  @param targetContentOffset 滑动结束之后 视图的偏移量
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //NSLog(@"velocity = %f", velocity.x);
    // targetContentOffset 指向结构体的指针  要使用 -> 来访问里面的变量
    //NSLog(@"targetContentOffset = %f", targetContentOffset->x);
    
    
    
    /**
     *  实现自定义的分页效果
     *  1. 获取视图停止之后的偏移量 x
     *  2. 根据偏移量 计算停止之后 所在的页码
     *  3. 计算此页 显示在正中间时 滑动视图的偏移量
     *  4. 将计算所得的偏移量 设置给滑动视图
     */
    
    // 1.
    CGFloat xOffset = targetContentOffset->x;
    
    xOffset -= _itemSize.width / 2;
    
    // 2.
    //-0 - 10 ~   0 + 0     ---     0
    // 0      ~   1 + 10    ---     1
    // 1 + 10 ~   2 + 20    ---     2
    NSInteger index = xOffset / (_itemSize.width + 10);
    if (xOffset > 0)
    {
        index += 1;
    }
    self.index = index;
    
    // 3.
    xOffset = index * (_itemSize.width + 10);
    
    // 4.
    targetContentOffset->x = xOffset;
    
    
}


@end
