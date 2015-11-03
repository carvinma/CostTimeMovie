//
//  PostCollectionView.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//


#import "PostCollectionView.h"
#import "PostCell.h"

@interface PostCollectionView() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end


@implementation PostCollectionView



#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor purpleColor];
    cell.movie = self.movieData[indexPath.item];
    return cell;
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 根据偏移量 计算正中间单元格的索引
    NSInteger index = collectionView.contentOffset.x / (collectionView.width * 0.6 + 10);
    // 判断选中的单元格 是不是正中间单元格
    if (indexPath.item == index)
    {
        // 1. YES  翻转这个单元格
        // 获取单元格
        PostCell *cell = (PostCell *)[collectionView cellForItemAtIndexPath:indexPath];
        // 翻转单元格
        [cell filpCell];
    }
    else
    {
        // 2. NO   将这个单元格 移动到正中间
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        //改变index
        self.index = indexPath.item;
        
        // 将前一个单元格 翻转回来
        // 获取单元格
        PostCell *cell = (PostCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        // 翻转单元格
        [cell backFilp];
    }
}



- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *postCell = (PostCell *)cell;
    [postCell backFilp];
    
}
@end
