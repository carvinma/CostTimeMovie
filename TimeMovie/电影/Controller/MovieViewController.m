//
//  MovieViewController.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"
#import "MovieCell.h"
#import "PostCollectionView.h"
#import "HeadColltectionView.h"

@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UIButton *_rightButton;      //右上角切换
    
    // 中间视图
    UITableView *_listView;
    UIView *_postView;
    PostCollectionView *_postCollectionView;
    
    // 数据储存
    NSMutableArray *_movieData;
    
    
    // 头部视图
    UIView *_headView;
    // 下拉按钮
    UIButton *_upDownButton;
    // 黑色的遮罩视图
    UIView *_maskView;
    
    HeadColltectionView *_headCollection;
    
}
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电影";
    
    // 读取数据
    [self loadData];
    
    // 创建右上角切换按钮
    [self _createRightButton];
    
    // 创建中间视图
    [self _createViews];
    
    // 创建头部视图
    [self _createHeadViews];
    [self addKVO];
}

#pragma mark - 读取数据
- (void)loadData
{
    NSDictionary *dic = [MovieJSON readJSONFile:@"us_box"];
    // 4. 数据处理和储存
    NSArray *subjects = dic[@"subjects"];
    
    _movieData = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in subjects)
    {
        Movie *movie = [Movie movieWithContentsOfDictionary:dictionary[@"subject"]];
        [_movieData addObject:movie];
    }
    
    
}

#pragma mark - create
// 创建中间视图
- (void)_createViews
{
    // 创建列表视图
    _listView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _listView.dataSource = self;
    _listView.delegate = self;
    [self.view addSubview:_listView];
    _listView.backgroundColor = [UIColor redColor];
    
    // 创建海报视图
    _postView = [[UIView alloc] initWithFrame:self.view.bounds];
    _postView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_postView];
    _postView.hidden = YES;
    
    // 创建collectionView
    _postCollectionView = [[PostCollectionView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, 380)];
    _postCollectionView.backgroundColor = [UIColor blackColor];
    // 将电影的数据 传给_postCollectionView
    _postCollectionView.movieData = _movieData;
    [_postView addSubview:_postCollectionView];
}

- (void)_createRightButton
{
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(0, 0, 49, 25);
    // 设置背景 和 标题图片
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateSelected];
    [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 将按钮打包，添加到导航栏上去
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)_createHeadViews
{
    // 创建遮罩视图
    _maskView = [[UIView alloc] initWithFrame:_postView.bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _maskView.hidden = YES;
    
    [_postView addSubview:_maskView];
    
    
    // 给遮罩视图 添加单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewMoveUp)];
    [_maskView addGestureRecognizer:tap];
    
    
    // 向下滑动手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(headViewMoveDown)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_postView addGestureRecognizer:swipe];
    
    
    // 创建头部视图
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 - 100, kScreenWidth, 130)];
    _headView.backgroundColor = [UIColor clearColor];
    [_postView addSubview:_headView];
    
   
    
    // 读取图片 并且拉伸
    UIImage *indexBG = [UIImage imageNamed:@"indexBG_home"];
    indexBG = [indexBG stretchableImageWithLeftCapWidth:0 topCapHeight:5];
    // 创建一个背景视图
    UIImageView *BGImageView = [[UIImageView alloc] initWithFrame:_headView.bounds];
    BGImageView.image = indexBG;
    [_headView addSubview:BGImageView];

    
    // 创建下啦按钮
    _upDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _upDownButton.frame = CGRectMake(0, 0, 26, 20);
    _upDownButton.center = CGPointMake(kScreenWidth / 2 + 3, 120);
    [_upDownButton setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [_upDownButton setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    
    [_upDownButton addTarget:self action:@selector(upDownButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headView addSubview:_upDownButton];
    
    
    // 创建头部collection
    _headCollection = [[HeadColltectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _headCollection.movieData = _movieData;
    [_headView addSubview:_headCollection];
    //创建灯视图
    UIImageView *lightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 0, 62, 130)];
    lightImageView.image = [UIImage imageNamed:@"light"];
    [_headView addSubview:lightImageView];
    
    UIImageView *lightImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 155, 0, 62, 130)];
    lightImageView2.image = [UIImage imageNamed:@"light"];
    [_headView addSubview:lightImageView2];

}



#pragma mark - buttonAction

- (void)rightButtonAction:(UIButton *)button
{
    
    // 表达式 ? 值1 : 值2
    /*
    if（表达式成立）
    {
        值1;
    }
    else
    {
        值2;
    }
    */
     
    UIViewAnimationOptions option = button.selected ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    
    [self filpView:_rightButton options:option];
    [self filpView:self.view options:option];
    _rightButton.selected = !_rightButton.selected;
    _postView.hidden = !_postView.hidden;
    _listView.hidden = !_listView.hidden;
    
}

- (void)upDownButtonAction:(UIButton *)button
{
    if (button.selected)
    {
        [self headViewMoveUp];
    }
    else
    {
        [self headViewMoveDown];
    }
}


#pragma mark - 头部视图上下移动控制方法
- (void)headViewMoveUp
{
    [UIView animateWithDuration:0.4 animations:^{
        _headView.top = -36;
        _upDownButton.selected = NO;
        _maskView.hidden = YES;
    }];
}

- (void)headViewMoveDown
{
    [UIView animateWithDuration:0.4 animations:^{
        _headView.top = 64;
        _upDownButton.selected = YES;
        _maskView.hidden = NO;
    }];
}

/**
 *  将某个视图进行翻转
 *
 *  @param view    需要进行翻转动画的视图
 *  @param options 动画的选项
 */
- (void)filpView:(UIView *)view options:(UIViewAnimationOptions)options
{
    [UIView transitionWithView:view
                      duration:0.35
                       options:options
                    animations:^{
                    }
                    completion:nil];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 从闲置池中获取cell
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieCell" owner:nil options:nil] lastObject];
    }
    
    // 将这个单元格所对应的电影对象 设置给单元格
    // 将一个电影对象 交给单元格去显示
    cell.movie = _movieData[indexPath.row];
    
    return cell;
}
// 设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


-(void)addKVO
{
    [_postCollectionView addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
    [_headCollection addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)dealloc
{
    [_headCollection removeObserver:self forKeyPath:@"index"];
    [_postCollectionView removeObserver:self forKeyPath:@"index"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//观察者方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //获取变化后得index值
    NSNumber *itemNumber = change[@"new"];
    NSInteger itemIndex = [itemNumber integerValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
    
    //判断被观察对象是哪一个collection
    if (object == _postCollectionView && _headCollection.index != indexPath.item) {
        //滑动小的
        [_headCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _headCollection.index = indexPath.item;
        
    }
    else if(object == _headCollection && _postCollectionView.index != indexPath.item)
    {
        //滑动大的
        [_postCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _postCollectionView.index = indexPath.item;
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
