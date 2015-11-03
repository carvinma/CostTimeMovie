//
//  Cinema.h
//  TimeMovie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

/*
 {
 "lowPrice" : "40.00",
 "grade" : "8.8",
 "coord" : "116.36047,40.01433",
 "distance" : null,
 "address" : "北京市海淀区学清路甲8号，圣熙8号购物中心五层西侧。",
 "name" : "嘉华国际影城",
 "id" : "1396",
 "msg" : null,
 "districtId" : "1015",
 "tel" : "010-82732228",
 "isSeatSupport" : "1",
 "isCouponSupport" : "1",
 "isImaxSupport" : "0",
 "isGroupBuySupport" : "0",
 "circleName" : "五道口"
 }
 */


#import "BaseModel.h"

@interface Cinema : BaseModel

@property (nonatomic, copy) NSString *lowPrice;     //价格
@property (nonatomic, copy) NSString *grade;        //评分
@property (nonatomic, copy) NSString *address;      //地址
@property (nonatomic, copy) NSString *name;         //名字
@property (nonatomic, copy) NSString *districtId;   //地区ID
@property (nonatomic, copy) NSString *isSeatSupport;//是否能够选座位
@property (nonatomic, copy) NSString *isCouponSupport;//是否支持优惠券
@property (nonatomic, copy) NSString *isImaxSupport;//是否是IMAX
@property (nonatomic, copy) NSString *isGroupBuySupport;//是否有团购


@end
