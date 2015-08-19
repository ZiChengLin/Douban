//
//  Activity.h
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasedObject.h"

@interface Activity : BasedObject

@property (nonatomic,retain) NSString * ID;                 //活动id
@property (nonatomic,retain) NSString * title;              //活动标题
@property (nonatomic,retain) NSString * begin_time;         //活动开始时间
@property (nonatomic,retain) NSString * end_time;           //活动结束时间
@property (nonatomic,retain) NSString * address;            //活动地址
@property (nonatomic,retain) NSString * category_name;      //活动类型
@property (nonatomic,retain) NSString * imageUrl;           //活动图像网址
@property (nonatomic,retain) NSString * content;            //活动内容
@property (nonatomic,retain) NSString * ownerName;          //活动发起者
@property (nonatomic,retain) NSString * wisher_count;       //感兴趣人数
@property (nonatomic,retain) NSString * participant_count;  //参加人数

@end
