//
//  BaseViewController.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/19.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabBarController.h"

@interface BaseViewController ()
{
    UILabel *_titleLabel;
    
    BOOL _isHiddenTabBar;  // 此界面 是否要隐藏标签栏
    
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 自定义Title
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:25];
    _titleLabel.text = @"title";
    
    // 将label 显示到导航栏上去
    self.navigationItem.titleView = _titleLabel;
    
    
    // 设置背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
}


- (void)setTitle:(NSString *)title
{
    // _title 是一个 @package 修饰的属性 所以不能直接修改
    // _title = title;
    // 所以需要使用父类中的setTitle方法来修改_title
    [super setTitle:title];
    _titleLabel.text = title;
}


#pragma  mark - 标签栏的隐藏和显示控制
- (void)viewWillAppear:(BOOL)animated
{
    if (_isHiddenTabBar)
    {
        // 隐藏标签栏
        BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
        [tab setTabBarHidden:YES];
    }
    else
    {
        // 显示标签栏
        BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
        [tab setTabBarHidden:NO];
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    // 显示标签栏
    BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
    [tab setTabBarHidden:NO];
}


- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    _isHiddenTabBar = hidesBottomBarWhenPushed;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
