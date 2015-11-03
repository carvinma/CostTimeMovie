//
//  NewsViewController.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/19.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "NewsViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "ImageListViewController.h"
#import "BaseTabBarController.h"
#import "WebNewsViewController.h"


@interface NewsViewController ()  <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_newsData;
    
    UIImageView *_topImageView; // 头条新闻的图片视图
    
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    [self loadData];
}



- (void)loadData
{
    NSArray *array = [MovieJSON readJSONFile:@"news_list"];
    _newsData = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array)
    {
        News *news = [[News alloc] initContentWithDic:dic];
        [_newsData addObject:news];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *news = _newsData[indexPath.row];
    if (indexPath.row == 0)
    {
        /**
         *  如何从故事版中 创建单元格
         *  1. 在故事版中 绘制表视图
         *  2. 在表视图上添加单元格 并自定义单元格上的控件
         *  3. 给单元格设定id
         *  4. 在代码中 使用dequeueReusableCellWithIdentifier: 来读取单元格
         */
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopNewsCell"];
        // 使用全局变量 来获取头条的图片视图
        _topImageView = (UIImageView *)[cell.contentView viewWithTag:100];
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
        label.text = news.title;
        [_topImageView sd_setImageWithURL:[NSURL URLWithString:news.image]];
        
        return cell;
    }
    else
    {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
        cell.titleLabel.text = news.title;
        [cell.newsImage sd_setImageWithURL:[NSURL URLWithString:news.image]];
        cell.summaryLabel.text = news.summary;
        if ([news.type intValue]== 1) {
            
            cell.typeImage.image = [UIImage imageNamed:@"sctpxw"];
        }
        if ([news.type intValue] == 2) {
            cell.typeImage.image = [UIImage imageNamed:@"scspxw"];
        }
        return cell;
    }
}

// 设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 150;
    }
    else
    {
        return 60;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// 单元格的选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *news = _newsData[indexPath.row];
    if ([news.type isEqualToNumber:@1])
    {
        // push 到图片界面
        ImageListViewController *imageList = [[ImageListViewController alloc] init];
        
        // 设置某个视图控制器，当他在被push的时候 隐藏标签栏
        // 只能控制系统自带标签栏
        // 因为在本项目中，使用的是自己创建的标签栏  所以无法自动隐藏
        imageList.hidesBottomBarWhenPushed = YES;
        
        
        [self.navigationController pushViewController:imageList animated:YES];
    }
    else if([news.type isEqualToNumber:@0])
    {
        WebNewsViewController *webNews = [[WebNewsViewController alloc]init];
        webNews.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webNews animated:YES];
    }
}


// 滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取滑动视图的y偏移
    CGFloat yOffset = scrollView.contentOffset.y + 64;
    
    if (yOffset < 0)
    {
        // 图片的原始高度
        CGFloat oldImageHeight = 150;
        // 图片的变化后的高度
        CGFloat newImageHeight = 150 - yOffset;
        // 放大的比例
        CGFloat scale = newImageHeight / oldImageHeight;
        
        // 放大图片
        CGAffineTransform transfrom = CGAffineTransformMakeScale(scale, scale);
        _topImageView.transform = transfrom;
        
        // 改变图片的位置
        _topImageView.top = yOffset;
    }
    
    
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
