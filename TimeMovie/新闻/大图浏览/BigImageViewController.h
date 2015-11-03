//
//  BigImageViewController.h
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/25.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "BaseViewController.h"

@interface BigImageViewController : BaseViewController

@property (nonatomic, strong) NSArray *imageData;   // 接受imageList中传递过来的数据
@property (nonatomic, strong) NSIndexPath *indexPath;   // 纪录前一个页面点中的单元格

@end
