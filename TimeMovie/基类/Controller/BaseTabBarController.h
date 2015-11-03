//
//  BaseTabBarController.h
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/19.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController


/**
 *  隐藏当前的标签栏
 *
 *  @param isHidden YES 隐藏/ NO 显示
 */
- (void)setTabBarHidden:(BOOL) isHidden;

@end
