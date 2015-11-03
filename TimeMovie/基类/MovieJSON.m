//
//  MovieJSON.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/22.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "MovieJSON.h"

@implementation MovieJSON

+ (id)readJSONFile:(NSString *)fileName
{
    // 1. 获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    // 2. 读取文件
    // NSData 数据类 里面的数据是以二进制的形式储存 字符串，字典，数组，UIImage
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    // 3. 文件解析
    id json =[NSJSONSerialization JSONObjectWithData:data
                                             options:NSJSONReadingMutableLeaves
                                               error:nil];
    
    return json;
}



@end
