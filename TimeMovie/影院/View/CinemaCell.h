//
//  CinemaCell.h
//  TimeMovie
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CinimaModal;

@interface CinemaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *ratingLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
//@property (weak, nonatomic) IBOutlet UILabel *distanseLable;
@property (weak, nonatomic) IBOutlet UIImageView *seatImageView;
@property (weak, nonatomic) IBOutlet UIImageView *couponImageView;

@property(nonatomic,strong)CinimaModal *cinemaModal;

@end
