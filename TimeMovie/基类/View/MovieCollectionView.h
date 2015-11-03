//
//  MovieCollectionView.h
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/28.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCollectionView : UICollectionView <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *movieData;
@property (nonatomic, assign) CGSize itemSize;

@property(nonatomic,assign)NSInteger index;
@end
