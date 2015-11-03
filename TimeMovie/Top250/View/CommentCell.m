//
//  CommentCell.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    _bgView.layer.borderWidth = 2;
    _bgView.layer.masksToBounds = YES;
    
}


- (void)setComment:(Comment *)comment
{
    _comment = comment;
    _commentLabel.text = _comment.content;
    NSURL *url = [NSURL URLWithString:_comment.userImage];
    [_i sd_setImageWithURL:url];
    _rating.text = _comment.rating;
    _name.text = _comment.nickname;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
