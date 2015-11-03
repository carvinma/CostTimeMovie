//
//  ImageListViewController.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/24.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "ImageListViewController.h"
#import "BigImageViewController.h"



@interface ImageListViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_imageCollectionView;
    NSMutableArray *_imageData;
}
@end

@implementation ImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片新闻";
    
    // 读取数据
    [self loadData];
    
    
    // 创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat itemWidth = (kScreenWidth - 10 * 5) / 4;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    // 创建collectionView
    _imageCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:_imageCollectionView];
    
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    // 注册单元格
    [_imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
}


#pragma mark - 文件读取
- (void)loadData
{
    NSArray *array = [MovieJSON readJSONFile:@"image_list副本"];
    
    
    // 数组初始化
    _imageData = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array)
    {
        NSString *urlString = dic[@"image"];
        NSURL *url = [NSURL URLWithString:urlString];
        
        [_imageData addObject:url];
    }
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageData.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    // 创建一个图片视图  并且设置为cell的背景视图
    UIImageView *imageView = [[UIImageView alloc] init];
    cell.backgroundView = imageView;
    // 网络读取图片
    // placeholderImage: 网络图片读取过程中 显示的默认图片
    [imageView sd_setImageWithURL:_imageData[indexPath.item] placeholderImage:[UIImage imageNamed:@"moreScore"]];
    
    
    // 视图的边框
    // CGColorRef
    // 设置边框颜色
    cell.layer.borderColor = [UIColor purpleColor].CGColor;
    // 设置边框宽度
    cell.layer.borderWidth = 3;
    // 视图的圆角
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    
    
    return cell;
}



#pragma mark - 单元格的选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BigImageViewController *big = [[BigImageViewController alloc] init];
    
    // 将图片数据传输给下一个控制器
    big.imageData = _imageData;
    
    big.hidesBottomBarWhenPushed = YES;
    
    // 纪录本次点击选中的单元格的索引
    big.indexPath = indexPath;
    [self.navigationController pushViewController:big animated:YES];
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
