//
//  LaunchViewController.m
//  TimeMovie
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(showImageView:) userInfo:nil repeats:YES];
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
-(void)showImageView:(NSTimer *)timer
{
    static NSInteger i = 101;
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:i];
    imageView.hidden = NO;
    i++;
    if (i == 125) {
        [timer invalidate];
        [self performSelector:@selector(jumpToMainViewController) withObject:nil afterDelay:.5];
    }
}

-(void)jumpToMainViewController
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
