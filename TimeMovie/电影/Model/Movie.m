//
//  Movie.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "Movie.h"

@implementation Movie
- (id)initWithContentsOfDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        
        // 中文标题
        _titleC = dictionary[@"title"];
        // 英文标题
        _titleE = dictionary[@"original_title"];
        // 评分
        NSDictionary *ratingDic = dictionary[@"rating"];
        NSNumber *number = ratingDic[@"average"];
        _rating = [number floatValue];
        // 图片
        _images = dictionary[@"images"];
        // 上映年份
        _year = dictionary[@"year"];
        
    }
    
    return self;
}


+ (id)movieWithContentsOfDictionary:(NSDictionary *)dictionary
{
    return [[Movie alloc] initWithContentsOfDictionary:dictionary];
}


@end
