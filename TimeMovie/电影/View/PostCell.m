//
//  PostCell.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//


#import "PostCell.h"
#import "StarView.h"

@interface PostCell()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleCNLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleENLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet StarView *starView;

@end


@implementation PostCell


- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    NSURL *url = [NSURL URLWithString:_movie.images[MovieImageKeyLarge]];
    [_bigImageView sd_setImageWithURL:url];
    [_smallImageView sd_setImageWithURL:url];
    _titleCNLabel.text = _movie.titleC;
    _titleENLabel.text = _movie.titleE;
    _yearLabel.text = _movie.year;
    _starView.rating = _movie.rating;
}


// 翻转单元格
- (void)filpCell
{
    [UIView transitionWithView:self
                      duration:0.3
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        _bigImageView.hidden = !_bigImageView.hidden;
                    }
                    completion:nil];
}


- (void)backFilp
{
    _bigImageView.hidden = NO;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
