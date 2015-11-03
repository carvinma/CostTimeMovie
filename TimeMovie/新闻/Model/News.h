//
//  News.h
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/22.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

/**
 {
 "id" : 1491520,
 "type" : 0,
 "title" : "科幻大作《全面回忆》全新预告片发布",
 "summary" : "",
 "image" : "http://img31.mtime.cn/mg/2012/06/28/100820.21812355.jpg"
 }
 */
@interface News : BaseModel

@property (nonatomic, strong) NSNumber *newsID;
@property (nonatomic, strong) NSNumber *type;   // 新闻的类型 0普通 1图片 2视频
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;  // 新闻简介
@property (nonatomic, copy) NSString *image;



@end
