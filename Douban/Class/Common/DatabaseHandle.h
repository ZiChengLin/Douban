//
//  DatabaseHandle.h
//  Douban
//
//  Created by 侯垒 on 14-8-31.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Activity;
@class Movie;

@interface DatabaseHandle : NSObject

+ (DatabaseHandle *)shareInstance;

//打开数据库
- (void)openDB;
//关闭数据库
- (void)closeDB;

#pragma mark -----Activity活动  数据库操作-------
//添加新的活动
- (void)insertNewActivity:(Activity *)activity;
//删除某个活动
- (void)deleteActivity:(Activity *)activity;
//获取某个活动对象
- (Activity *)selectActivityWithID:(NSString *)ID;
//获取所有活动
- (NSArray *)selectAllActivity;

//判断活动是否被收藏
- (BOOL)isFavoriteActivityWithID:(NSString *)ID;

#pragma mark -----Movie电影  数据库操作-------
//添加新的电影
- (void)insertNewMovie:(Movie *)movie;
//删除某个电影
- (void)deleteMovie:(Movie *)movie;
//获取某个电影对象
- (Movie *)selectMovieWithID:(NSString *)ID;
//获取所有电影
- (NSArray *)selectAllMovie;

//判断对象是否被收藏
- (BOOL)isFavoriteMovieWithID:(NSString *)ID;




@end
