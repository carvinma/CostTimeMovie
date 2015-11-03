//
//  DetailHeadView.m
//  TimeMovie
///
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "DetailHeadView.h"
#import <MediaPlayer/MediaPlayer.h>
@implementation DetailHeadView

-(void)awakeFromNib
{
    _scrollView.layer.cornerRadius = 10;
    _scrollView.layer.borderWidth = 3;
    _scrollView.layer.backgroundColor = [UIColor whiteColor].CGColor;
}

-(void)setDictionary:(NSDictionary *)dictionary
{
    NSString *str = dictionary[@"image"];
        
    NSURL *url = [NSURL URLWithString:str];
    [_imageImageView sd_setImageWithURL:url];
        
    _titleCnLable.text = dictionary[@"titleCn"];

    NSString *directors = [dictionary[@"directors"] componentsJoinedByString:@","];
    NSString *directorsText = [NSString stringWithFormat:@"导演：%@",directors];
    _directorsLable.text = directorsText ;
    
    NSString *actors = [dictionary[@"actors"] componentsJoinedByString:@","];
    NSString *actorsText = [NSString stringWithFormat:@"主演：%@",actors];
    _actorsLable.text = actorsText;
    
    NSString *type = [dictionary[@"type"] componentsJoinedByString:@","];
    NSString *typeText = [NSString stringWithFormat:@"类型：%@",type];
    _typeLable.text = typeText;
    
    NSString *year = [NSString stringWithFormat:@"上映年份：%@",dictionary[@"year"]];
    _yearLable.text = year ;
    
    _images = dictionary[@"images"];
}
- (IBAction)button:(UIButton *)sender {
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"]];
    [self.navivigationController pushViewController:moviePlayer animated:YES];
}

@end
