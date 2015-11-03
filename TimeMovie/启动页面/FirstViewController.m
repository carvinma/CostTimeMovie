//
//  FirstViewController.m
//  TimeMovie
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UIScrollViewDelegate>
{
    UIImageView *_guideProgressImageView;
    UIButton *_enterButton;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.backgroundColor = [UIColor blackColor];
    
    //创建子视图
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    UIImageView *imageView1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide1"]];
    imageView1.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [view1 addSubview:imageView1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    UIImageView *imageView2 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide2"]];
    imageView2.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [view2 addSubview:imageView2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*2, 0, self.view.bounds.size.width, 128)];
    UIImageView *imageView3 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide3"]];
    imageView3.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [view3 addSubview:imageView3];
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*3, 0, self.view.bounds.size.width, 128)];
    UIImageView *imageView4 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide4"]];
    imageView4.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [view4 addSubview:imageView4];
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*4, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    UIImageView *imageView5 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide5"]];
    imageView5.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [view5 addSubview:imageView5];
    [self.view addSubview:scrollView];
    
    _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
     _enterButton.frame = CGRectMake((kScreenWidth-100) / 2, kScreenHeight - 60, 100, 20);
    [_enterButton setTitle: @"进入电影院" forState:UIControlStateNormal];
    [_enterButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _enterButton.backgroundColor = [UIColor clearColor];

    _enterButton.hidden = YES;
   _enterButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_enterButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_enterButton];
    
    [scrollView addSubview:view1];
    [scrollView addSubview:view2];
    [scrollView addSubview:view3];
    [scrollView addSubview:view4];
    [scrollView addSubview:view5];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    //设置内容视图尺寸
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*5, 0);
    
    //是否分页
    scrollView.pagingEnabled =YES;
    
    //是否显示垂直或者水平方向的huadongtiao
    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.showsVerticalScrollIndicator = NO;
    
    //显示进度条
    _guideProgressImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 86.5) / 2, kScreenHeight-30, 86.5, 13)];
    _guideProgressImageView.image = [UIImage imageNamed:@"guideProgress1"];

    [self.view addSubview:_guideProgressImageView];
    scrollView.delegate = self;
    
}
-(void)buttonAction:(UIButton *)button
{
    //读取故事板  获取ViewController
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //获取故事板
    UIViewController *vc = [story instantiateInitialViewController];
    //获取当前控制器的view 所显示在哪个窗口上
    self.view.window.rootViewController = vc;
    //界面显示动画
    vc.view.transform = CGAffineTransformMakeScale(.2, .2);
    [UIView animateWithDuration:.3 animations:^{
        vc.view.transform = CGAffineTransformIdentity;
    }];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:@YES forKey:@"first"];
}

-(void)viewWillAppear:(BOOL)animated
{
    //设置状态栏隐藏
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    //设置状态栏显示
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:NO];
}
#pragma mark - 滑动视图的滑动代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取x方向的偏移量
    CGFloat xoffset = scrollView.contentOffset.x;
    //计算当前显示的页码
    NSInteger index = xoffset / kScreenWidth;
    //改变图片
    NSString *imageName = [NSString stringWithFormat:@"guideProgress%ld",index + 1];
    _guideProgressImageView.image = [UIImage imageNamed:imageName];
    _enterButton.hidden = !(index == 4);
    
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
