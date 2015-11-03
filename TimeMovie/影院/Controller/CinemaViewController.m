//
//  CinemaViewController.m
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "CinemaViewController.h"
#import "District.h"
#import "Cinema.h"
#import "CinemaCell.h"


@interface CinemaViewController ()
{
    NSMutableArray *_districtData;
    UITableView *_table;
    UIButton *_button;
    BOOL _isExpend[100];
}
@end

@implementation CinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"影院";
    
    // 读取数据
    [self loadData];
    [self _createTableView];

    
    NSLog(@"%@", _districtData);
}





- (void)loadData
{
    // 读取地区数据
    NSDictionary *dic1 = [MovieJSON readJSONFile:@"district_list"];
    NSArray *array1 = dic1[@"districtList"]; // 储存地区数据的数组
    _districtData = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array1)
    {
        District *disrtict = [[District alloc] initContentWithDic:dic];
        [_districtData addObject:disrtict];
    }
    
    
    
    // 读取电影院数据
    NSDictionary *dic2 = [MovieJSON readJSONFile:@"cinema_list"];
    NSArray *array2 = dic2[@"cinemaList"];
    for (NSDictionary *dic in array2)
    {
        Cinema *cinema = [[Cinema alloc]initContentWithDic:dic];
        
        for (District *dis in _districtData)
        {
            // 比较电影院的地区id 和 地区是否匹配
            if ([dis.districtID isEqualToString:cinema.districtId])
            {
                // 如果匹配  就说明这家电影院在这个地区中
                [dis.cinemas addObject:cinema];
                
                break;
            }
        }
    }
    
    
    
}

-(void)_createTableView
{
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    //自定义表的头视图
    //    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 100)];
    //    headerView.image = [UIImage imageNamed:@"hotMovieBottomImage"];
    //    _table.tableHeaderView = headerView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //滑动到指定的单元格
        [_table scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    });
}


#pragma mark - 代理协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_isExpend[section]) {
        
        District *dis = _districtData[section];
        return dis.cinemas.count;
    }
    else
        return 0;
    //    return cinemas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CinemaCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CinemaCell" owner:self options:nil]lastObject];
    }
    District *dis = _districtData[indexPath.section];
    cell.cinemaModal = dis.cinemas[indexPath.row];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _districtData.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    District *modal = _districtData[section];
    NSString *str = modal.name;
    return str;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImage *image = [UIImage imageNamed:@"hotMovieBottomImage"];
    District *modal = _districtData[section];
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    [_button addTarget:self action:@selector(expendAction:) forControlEvents:UIControlEventTouchUpInside];
    _button.tag = 100+section;
    [_button setBackgroundImage:image forState:UIControlStateNormal];
    [_button setTitle:[NSString stringWithFormat:@"%@",modal.name] forState:UIControlStateNormal];
    _button.titleLabel.textColor = [UIColor whiteColor];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return _button;
}

-(void)expendAction:(UIButton *)btn
{
    NSInteger section = btn.tag-100;
    _isExpend[section] =!_isExpend[section];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [_table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
