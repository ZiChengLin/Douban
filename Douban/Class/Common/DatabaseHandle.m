//
//  DatabaseHandle.m
//  Douban
//
//  Created by 侯垒 on 14-8-31.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "DatabaseHandle.h"
#import <sqlite3.h>

#import "Activity.h"
#import "Movie.h"

#define kDatabaseName   @"Douban.sqlite"

@implementation DatabaseHandle

static DatabaseHandle * handle = nil;

+ (DatabaseHandle *)shareInstance
{
    if (nil == handle) {
        handle = [[DatabaseHandle alloc] init];
        [handle openDB];
    }
    
    return handle;
}


static sqlite3 * db = nil;
//打开数据库
- (void)openDB
{
    if (db != nil) {
        return;
    }
    
    //数据库存储在沙盒中的caches文件夹下
    NSString * dbPath = [[PersistManager shareInstance] databaseFilePath:kDatabaseName];
    
    //打开数据库，第一个参数是数据库存储的完整路径
    //如果数据库文件已经存在，是打开操作。如果数据库文件不存在，是先创建，再打开
    int result = sqlite3_open([dbPath UTF8String], &db);
    if (result == SQLITE_OK) {
        
        NSLog(@"打开数据库成功");
        //创建表的sql语句
        NSString * createActivitySql = @"CREATE TABLE ActivityList (ID TEXT PRIMARY KEY , title TEXT, imageUrl TEXT, data BLOB)";
        //执行sql语句
        sqlite3_exec(db, [createActivitySql UTF8String], NULL, NULL, NULL);
        
        NSString * createMovieSql = @"CREATE TABLE MovieList (ID INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, imageUrl TEXT, data BLOB)";
        //执行sql语句
        sqlite3_exec(db, [createMovieSql UTF8String], NULL, NULL, NULL);

    }
    
}

//关闭数据库
- (void)closeDB
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        
        NSLog(@"数据库关闭成功");
        db = nil;
    }
}


#pragma mark -----Activity活动  数据库操作-------
//添加新的活动
- (void)insertNewActivity:(Activity *)activity
{
    
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"insert into ActivityList (ID,title,imageUrl,data) values (?,?,?,?)";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [activity.ID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [activity.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [activity.imageUrl UTF8String], -1, NULL);
        
        NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kActivityArchiverKey,activity.ID];
        NSData * data = [[PersistManager shareInstance] dataOfArchiverObject:activity forKey:archiverKey];
        
        
        sqlite3_bind_blob(stmt, 4, [data bytes], (int)[data length], NULL);
    
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
}

//删除某个活动
- (void)deleteActivity:(Activity *)activity
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"delete from ActivityList where ID = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [activity.ID UTF8String], -1, NULL);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);

}

//获取某个活动对象
- (Activity *)selectActivityWithID:(NSString *)ID
{
    
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select data from ActivityList where ID = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    Activity * activity = nil;
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        
        if (sqlite3_step(stmt) == SQLITE_ROW) {

            //bytes length
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
                        
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kActivityArchiverKey,ID];
            activity = [[PersistManager shareInstance] unarchiverObject:data forKey:archiverKey];
        }
        
    }
    
    sqlite3_finalize(stmt);

    return activity;
}

//获取所有活动
- (NSArray *)selectAllActivity
{
    
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select ID,data from ActivityList";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    NSMutableArray * activityArray = [NSMutableArray arrayWithCapacity:40];
    
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString * ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kActivityArchiverKey,ID];

            Activity * act = [[PersistManager shareInstance] unarchiverObject:data forKey:archiverKey];
            [activityArray addObject:act];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return activityArray;
}

//判断活动是否被收藏
- (BOOL)isFavoriteActivityWithID:(NSString *)ID
{
    Activity * act = [self selectActivityWithID:ID];
    if (act == nil) {
        return NO;
    }
    
    return YES;
}
    

#pragma mark -----Movie电影  数据库操作-------
//添加新的电影
- (void)insertNewMovie:(Movie *)movie
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"insert into MovieList (ID,title,imageUrl,data) values (?,?,?,?)";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
                
        sqlite3_bind_text(stmt, 1, [movie.movieId UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [movie.movieName UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [movie.pic_url UTF8String], -1, NULL);
        
        NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kMovieArchiverKey,movie.movieId];

        NSData * data = [[PersistManager shareInstance] dataOfArchiverObject:movie forKey:archiverKey];
        
        sqlite3_bind_blob(stmt, 4, [data bytes], (int)[data length], NULL);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);

}

//删除某个电影
- (void)deleteMovie:(Movie *)movie
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"delete from MovieList where ID = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [movie.movieId UTF8String], -1, NULL);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);

}

//获取某个电影对象
- (Movie *)selectMovieWithID:(NSString *)ID
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select data from MovieList where ID = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    Movie * movie = nil;
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kMovieArchiverKey,ID];
            
            movie = [[PersistManager shareInstance] unarchiverObject:data forKey:archiverKey];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return movie;
}

//获取所有电影
- (NSArray *)selectAllMovie
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select ID,data from MovieList";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    NSMutableArray * movieArray = [NSMutableArray arrayWithCapacity:40];
    
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString * ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kMovieArchiverKey,ID];
            
            Movie * m = [[PersistManager shareInstance] unarchiverObject:data forKey:archiverKey];
            [movieArray addObject:m];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return movieArray;

}

//判断对象是否被收藏
- (BOOL)isFavoriteMovieWithID:(NSString *)ID
{
    
    Movie * m = [self selectMovieWithID:ID];
    
    if (m == nil) {
        return NO;
    }
    
    return YES;
}


@end
