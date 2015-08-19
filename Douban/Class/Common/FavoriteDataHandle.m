//
//  FavoriteDataHandle.m
//  Douban
//
//  Created by 侯垒 on 14-8-31.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "FavoriteDataHandle.h"

#import "Activity.h"
#import "Movie.h"
#import "DatabaseHandle.h"

@interface FavoriteDataHandle ()

@property (nonatomic,retain) NSMutableArray * activityArray;
@property (nonatomic,retain) NSMutableArray * movieArray;
//@property (nonatomic,retain) DatabaseHandle * dbHandle;

@end

@implementation FavoriteDataHandle

static FavoriteDataHandle * handle = nil;

- (void)dealloc
{
    [_activityArray release];
    [_movieArray release];
    [super dealloc];
}

+ (FavoriteDataHandle *)shareInstance
{
    if (handle == nil) {
        handle = [[FavoriteDataHandle alloc] init];
        
    }
    
    return handle;
}

#pragma mark ------Activity活动 数据源-------
//从数据库读取“活动”的数据源
- (void)setupActivityDataSource
{
    self.activityArray = [[[DatabaseHandle shareInstance] selectAllActivity] mutableCopy];
}

//获取活动的个数
- (NSInteger)countOfActivity
{
    return [_activityArray count];
}

//获取某个活动对象
- (Activity *)activityForRow:(NSInteger)row
{
    return _activityArray[row];
}

//删除某个活动对象
- (void)deleteActivityForRow:(NSInteger)row
{
    //从数据库删除
    [[DatabaseHandle shareInstance] deleteActivity:[self activityForRow:row]];
    //从数据源删除
    [_activityArray removeObjectAtIndex:row];

}

#pragma mark ------Movie电影 数据源-------
//从数据库读取“电影”的数据源
- (void)setupMovieDataSource
{
    self.movieArray = [[[DatabaseHandle shareInstance] selectAllMovie] mutableCopy];
}

//获取电影的个数
- (NSInteger)countOfMovie
{
    return [_movieArray count];
}

//获取某个电影对象
- (Movie *)movieForRow:(NSInteger)row
{
    return _movieArray[row];
}

//删除某个电影对象
- (void)deleteMovieForRow:(NSInteger)row
{
    //从数据库删除
    [[DatabaseHandle shareInstance] deleteMovie:[self movieForRow:row]];
    //从数据源删除
    [_movieArray removeObjectAtIndex:row];
}
@end
