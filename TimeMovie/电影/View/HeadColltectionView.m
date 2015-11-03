//
//  HeadColltectionView.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//


#import "HeadColltectionView.h"
#import "Movie.h"

@interface HeadColltectionView()


@end


@implementation HeadColltectionView 




#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor purpleColor];
    // 背景图片视图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    cell.backgroundView = imageView;
    // 读取图片
    Movie *movie = self.movieData[indexPath.row];
    NSURL *url = [NSURL URLWithString:movie.images[MovieImageKeySmall]];
    // 加载图片
    [imageView sd_setImageWithURL:url];
    
    
    return cell;
}





// 单元格的选中方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 单元格滑动
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    self.index = indexPath.item;
}


@end
