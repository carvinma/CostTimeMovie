//
//  MovieDetailViewController.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "DetailHeadView.h"
#import "Comment.h"
#import "CommentCell.h"
@interface MovieDetailViewController () <UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray *_comments;
    
    DetailHeadView *_head;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电影详情";
    
    [self _createHeadDetailView];
    [self loadData];
}



- (void)loadData
{
    NSDictionary *dic = [MovieJSON readJSONFile:@"movie_comment"];
    NSArray *array = dic[@"list"];
    _comments = [[NSMutableArray alloc] init];
    for (NSDictionary *d in array)
    {
        Comment *c = [[Comment alloc] initContentWithDic:d];
        [_comments addObject:c];
    }
//    NSDictionary *detail = [MovieJSON readJSONFile:@"movie_detail"];
//    _head.dictionary = detail;

}
-(void)_createHeadDetailView
{
    // 读取xib
    _head = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeadView" owner:nil options:nil] lastObject];
    _tableView.tableHeaderView = _head;
//    _head.scrollView.contentSize = CGSizeMake( 65 *  (_head.images.count - 1), 67);
    _head.scrollView.showsHorizontalScrollIndicator = NO;
   _head.scrollView.showsVerticalScrollIndicator = NO;
    
    _head.navivigationController = self.navigationController;
    NSDictionary *detail = [MovieJSON readJSONFile:@"movie_detail"];
    _head.dictionary = detail;

    for (int i = 0; i < _head.images.count; i++) {

//        UIView *view = [_head viewWithTag:100];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i * 65, 3, 60, 60)];
        _head.scrollView.contentSize = CGSizeMake((view.bounds.size.width +5) *  _head.images.count, 67);
//        view.frame = CGRectMake(i * 65, 3, 60, 60);
        
        UIImageView *imagview = [[UIImageView alloc]initWithFrame:view.bounds];
        NSURL *url = [NSURL URLWithString:_head.images[i]];
        [imagview sd_setImageWithURL:url];
        [view addSubview:imagview];
        
        [_head.scrollView addSubview:view];
    }
    
    
    
}

#pragma  mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    cell.comment = _comments[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // 计算字符Label高度
    // 拿到当前行的评论对象
    Comment *comment = _comments[indexPath.row];
    
    if (comment.isShow)
    {
        // 评论的内容
        NSString *string = comment.content;
        // 根据字符串的长度 计算Label的大小
        CGSize maxSize = CGSizeMake(kScreenWidth - 80, CGFLOAT_MAX);
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
        CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height + 50;
    }
    else
    {
        return 60;
    }
}
    
// 单元格的选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 改变这条数据的显示状态
    Comment *comment = _comments[indexPath.row];
    comment.isShow = !comment.isShow;
    // 刷新单元格
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

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
