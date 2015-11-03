//
//  Movie.h
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#define MovieImageKeySmall @"small"
#define MovieImageKeyLarge @"large"
#define MovieImageKeyMedium @"medium"

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Movie : NSObject

@property(nonatomic, copy) NSString *titleC;    // 电影名
@property(nonatomic, copy) NSString *titleE;    // 英文名
@property(nonatomic, assign) CGFloat rating;    // 评分
@property(nonatomic, copy) NSString *year;      // 上映时间
@property(nonatomic, strong) NSDictionary *images;  // 图片

/**
 *  电影对象的初始化方法
 *
 *  @param dictionary 存储数据的字典
 *
 *  @return 初始化完毕后的对象
 */
- (id)initWithContentsOfDictionary:(NSDictionary *)dictionary;

+ (id)movieWithContentsOfDictionary:(NSDictionary *)dictionary;

@end
