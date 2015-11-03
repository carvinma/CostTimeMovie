//
//  DetailHeadView.h
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface DetailHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleCnLable;
@property (weak, nonatomic) IBOutlet UILabel *directorsLable;
@property (weak, nonatomic) IBOutlet UILabel *actorsLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;
@property (weak, nonatomic) IBOutlet UILabel *yearLable;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong)NSArray *images;

@property(nonatomic,strong)NSDictionary *dictionary;
@property(nonatomic,weak)UINavigationController *navivigationController;



@end
