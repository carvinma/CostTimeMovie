//
//  CinemaCell.m
//  TimeMovie
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "CinemaCell.h"
#import "Cinema.h"

@implementation CinemaCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setCinemaModal:(Cinema *)cinemaModal
{
    _nameLable.text = cinemaModal.name;
    NSString *rating = [NSString stringWithFormat:@"%@",cinemaModal.grade];
    _ratingLable.text = rating;
    
    NSString *price = [NSString stringWithFormat:@"￥%@",cinemaModal.lowPrice];
    _priceLable.text = price;

//    if ([cinemaModal.price isEqualToString:@"null"]) {
//        _priceLable.text = price;
//    }
//    else
//    {
//        _priceLable.text = nil;
//    }
    _addressLable.text = cinemaModal.address;
    if (cinemaModal.isSeatSupport) {
        _seatImageView.image = [UIImage imageNamed:@"cinemaSeatMark"];
    }
    if (cinemaModal.isCouponSupport) {
    
        _couponImageView.image = [UIImage imageNamed:@"cinemaCouponMark"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
