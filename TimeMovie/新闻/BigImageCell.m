//
//  BigImageCell.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/25.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "BigImageCell.h"

@interface BigImageCell() <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;  // 底层的滑动视图  用来实现图片的捏合
    UIImageView *_imageView;    // 图片视图
    
    NSTimer *_timer;
    
}
@end


@implementation BigImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _createViews];
    }
    
    return self;
}


- (void)_createViews
{
    // 创建滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.contentSize = self.frame.size;
    // 设置缩放倍数
    _scrollView.maximumZoomScale = 3;
    _scrollView.minimumZoomScale = 0.3;
    
    _scrollView.delegate = self;
    
    [self.contentView addSubview:_scrollView];
    
    
    // 创建图片视图
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.image = [UIImage imageNamed:@"11@2x"];
    [_scrollView addSubview:_imageView];
    
    // 图片的拉伸模式
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
    // 创建手势识别器
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapAction)];
    // 点击的次数
    oneTap.numberOfTapsRequired = 1;
    // 点击时手指的数量
    oneTap.numberOfTouchesRequired = 1;
    
    // 将手势识别器 添加到某个视图上
    [_imageView addGestureRecognizer:oneTap];
    
    // 给图片视图 开启点击事件
    _imageView.userInteractionEnabled = YES;
    
    
    // 双击
    // 创建手势识别器
    UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoTapAction)];
    // 点击的次数
    twoTap.numberOfTapsRequired = 2;
    // 点击时手指的数量
    twoTap.numberOfTouchesRequired = 1;
    
    // 将手势识别器 添加到某个视图上
    [_imageView addGestureRecognizer:twoTap];

}

// 单击时执行的方法
- (void)oneTapAction
{
    NSLog(@"一次点击");
    // 单击
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(oneAction) userInfo:nil repeats:NO];
}

// 单击之后 延迟调用执行的方法
- (void)oneAction
{
    NSLog(@"单击了一次");
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kHiddenNavigationBar object:nil];

}


- (void)twoTapAction
{
    // 取消单击  取消定时器
    [_timer invalidate];
    // 双击 放大
    // 判断当前的缩放状态
    if (_scrollView.zoomScale >= 2)
    {
        // 已经处于放大状态下
        [_scrollView setZoomScale:1 animated:YES];
    }
    else
    {
        // 还未处于放大状态下
        [_scrollView setZoomScale:3 animated:YES];
    }
    
}



// 滑动视图的代理方法  返回值为捏合手势缩放的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}


- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [_imageView sd_setImageWithURL:_imageURL];
}


// 还原
- (void)backImageZoomingScale
{
    // 滑动视图的缩放比例
    [_scrollView setZoomScale:1];
}
@end
