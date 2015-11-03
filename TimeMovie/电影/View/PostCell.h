//
//  PostCell.h
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface PostCell : UICollectionViewCell

@property (nonatomic, strong) Movie *movie;

/**
 *  翻转单元格
 */
- (void)filpCell;


/**
 *  取消翻转
 */

- (void)backFilp;

@end
