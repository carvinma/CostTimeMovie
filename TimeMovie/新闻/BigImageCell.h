//
//  BigImageCell.h
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/25.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigImageCell : UICollectionViewCell

@property (nonatomic, strong) NSURL *imageURL;  // 单元格中的imaageView 显示的图片


/**
 *  还原图片的缩放比例
 */
- (void)backImageZoomingScale;

@end
