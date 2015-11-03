//
//  MovieCell.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//


#import "MovieCell.h"
#import "Movie.h"
#import "StarView.h"

@interface MovieCell()
@property (weak, nonatomic) IBOutlet StarView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@end

@implementation MovieCell




// 覆写setMovie
- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    // 将电影model对象中存储的数据，取出来显示到label imageView
    _titleLabel.text = _movie.titleC;
    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@", _movie.year];
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f", _movie.rating];
    
    // 从网络读取图片
    // 创建url
    NSString *urlString = _movie.images[MovieImageKeyLarge];
    NSURL *url = [NSURL URLWithString:urlString];
    [_movieImageView sd_setImageWithURL:url];
    
    // 改变starView 的评分
    _starView.rating = _movie.rating;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
