//
//  FavoriteDataHandle.h
//  Douban
//
//  Created by 侯垒 on 14-8-31.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Activity;
@class Movie;

@interface FavoriteDataHandle : NSObject

+ (FavoriteDataHandle *)shareInstance;

#pragma mark ------Activity活动 数据源-------
//从数据库读取“活动”的数据源
- (void)setupActivityDataSource;
//获取活动的个数
- (NSInteger)countOfActivity;
//获取某个活动对象
- (Activity *)activityForRow:(NSInteger)row;
//删除某个活动对象
- (void)deleteActivityForRow:(NSInteger)row;

#pragma mark ------Movie电影 数据源-------
//从数据库读取“电影”的数据源
- (void)setupMovieDataSource;
//获取电影的个数
- (NSInteger)countOfMovie;
//获取某个电影对象
- (Movie *)movieForRow:(NSInteger)row;
//删除某个电影对象
- (void)deleteMovieForRow:(NSInteger)row;


@end
