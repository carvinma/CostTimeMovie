//
//  BaseTabBarController.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/19.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//


#import "BaseTabBarController.h"
#import "TabBarButton.h"

@interface BaseTabBarController ()
{
    UIView *_newTabBar;  // 自定义的标签栏
    
    UIImageView *_selectView;    // 选中视图
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建一个自定义的标签栏
    [self _createTabBar];
    

    

}


- (void)setTabBarHidden:(BOOL)isHidden
{
    _newTabBar.hidden = isHidden;
}



- (void)_createTabBar
{
    // 隐藏系统自带的标签栏
    self.tabBar.hidden = YES;
    
    // 创建自定义标签栏
    _newTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    _newTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all"]];
    [self.view addSubview:_newTabBar];
    
    // 创建按钮
    // 1. 计算按钮宽
    CGFloat buttonWidth = kScreenWidth / self.viewControllers.count;
    
    
    // 创建选中框
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 49)];
    _selectView.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    [_newTabBar addSubview:_selectView];
    
    
    
    NSArray *titles = @[@"电影",
                        @"新闻",
                        @"Top",
                        @"影院",
                        @"更多"];
    NSArray *imageNames = @[@"movie_home",
                            @"msg_new",
                            @"start_top250",
                            @"icon_cinema",
                            @"more_setting"];
    
    
    for (int i = 0; i < self.viewControllers.count; i++)
    {
        // 创建一个子类化按钮
        TabBarButton *button = [[TabBarButton alloc] initWithTitle:titles[i] imageName:imageNames[i] frame:CGRectMake(i * buttonWidth, 0, buttonWidth, 49)];
        button.tag = i;
        
        // 给按钮添加点击事件
        [button addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        // 将这个按钮添加到标签栏上去
        [_newTabBar addSubview: button];
    }
    
    
}

- (void)tabBarButtonAction:(UIButton *)button
{
    NSInteger tag = button.tag;
//    NSLog(@"点击了 %li ", tag);
    
    // 根据按钮的tag 来切换显示的页面
    self.selectedIndex = tag;
    
    // 选中框移动
    [UIView animateWithDuration:0.2 animations:^{
        _selectView.center = button.center;
    }];
    
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
