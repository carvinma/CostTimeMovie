//
//  MoreViewController.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cacheLable;

@end

@implementation MoreViewController
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"更多";
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 40)];
    titleLable.text = @"更多";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:21];
    self.navigationItem.titleView = titleLable;

    
}
-(void)viewDidAppear:(BOOL)animated
{
    _cacheLable.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    
}
-(CGFloat)countCacheFileSize{
    NSString *homePath = NSHomeDirectory();
    NSLog(@"%@",homePath);
    /*
     1)  子文件夹1：视频缓存 /tmp/MediaCache/
     2)  子文件夹2：SDWebImage框架的缓存图片  /Library/Caches/com.hackemist.SDWebImageCache.default/
     3)  子文件夹3：/Library/Caches/com.huiwen.TimeMovie/
     */
    NSArray *pathArray = @[@"/tmp/MediaCache/",@"/Library/Caches/com.hackemist.SDWebImageCache.default/",@"/Library/Caches/com.huiwen.TimeMovie/"];
    CGFloat fileSize = 0;
    for (NSString *string in pathArray) {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        fileSize += [self getFileSize:filePath];
    }
    return fileSize;
}

-(CGFloat)getFileSize:(NSString *)filePath
{
    
    //文件管理器 单例
    NSFileManager *manager = [NSFileManager defaultManager];
    //数组 储存文件夹中所有的子文件夹以及文件的名字
    NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
    //遍历数组
    long long size = 0;
    for (NSString *fileName in fileNames) {
        //拼接获取文件的路径
        NSString *subFliePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
        //获取文件信息
        NSDictionary *dic = [manager attributesOfItemAtPath:subFliePath error:nil];
        NSNumber *sizeNumber = dic[NSFileSize];
        long long subFileSize = [sizeNumber longLongValue];
        size += subFileSize;
    }
    return size / 1024.0 /1024;
}
-(void)cleanCacheFile
{
    _cacheLable.text = @"清理中...";
    //获取缓存文件的路径
    NSString *homePath = NSHomeDirectory();
    //2.删除文件
    NSArray *pathArray = @[@"/tmp/MediaCache/",@"/Library/Caches/com.hackemist.SDWebImageCache.default/",@"/Library/Caches/com.huiwen.TimeMovie/"];

    for (NSString *string in pathArray) {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];

        //文件管理
        NSFileManager *manager = [NSFileManager defaultManager];
        //获取子文件夹中的文件名
        NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
        //遍历文件夹 删除文件
        for (NSString *fileName in fileNames) {
            //拼接子文件路径
            NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
            //删除文件
            [manager removeItemAtPath:subFilePath error:nil];
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cacheLable.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    });
}
//单元格选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIAlertView *alret = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alret show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //清理订单
        [self cleanCacheFile];
    }
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
