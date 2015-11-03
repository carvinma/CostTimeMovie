//
//  TabBarButton.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/19.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

- (id)initWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 创建图片和label
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 20) / 2, 8, 20, 22)];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
        
        // 设置图片的拉伸模式
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, frame.size.width, 15)];
        label.text = title;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    
    return self;
}

@end
