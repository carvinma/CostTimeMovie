//
//  WebNewsViewController.m
//  TimeMovie
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "WebNewsViewController.h"
#import "MovieJSON.h"

@interface WebNewsViewController ()

@end

@implementation WebNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页新闻";
//    //=====================UIWebView
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:web];
//    //URL网络地址
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    //网络请求
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
//    //使用一个网络请求
//    [web loadRequest:request];
    
    //==========================使用html字符串加载页面
// //   1.读取html文件路径
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"百度一下，你就知道" ofType:@"html"];
//    //2.读取文件数据
//    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    //3.加载页面
//    [web loadHTMLString:htmlString baseURL:nil];
//    web.scalesPageToFit = YES;
    //1.读取文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"html"];
    //读取文件
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //读取新闻数据json
    NSDictionary *dic = [MovieJSON readJSONFile:@"news_detail"];
    
    //读取网页需要使用的相关数据
    NSString *title = dic[@"title"];
    NSString *content = dic[@"content"];
    NSString *time = dic[@"time"];
    NSString *sourse = dic[@"source"];
    htmlString = [NSString stringWithFormat:htmlString,title,content,time,sourse];
    //3.加载页面
    [web loadHTMLString:htmlString baseURL:nil];
    
    web.scalesPageToFit = YES;
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
