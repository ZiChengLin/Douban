//
//  PersistManager.h
//  Douban
//
//  Created by 侯垒 on 14-10-9.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface PersistManager : NSObject

+ (PersistManager *)shareInstance;

#pragma mark ----用户信息-----
//同步
- (void)synchronize;

//设置用户信息
- (void)setloginState:(BOOL)isLogin;
- (void)setUsername:(NSString *)username;
- (void)setPassword:(NSString *)password;
- (void)setEmail:(NSString *)email;
- (void)setPhoneNumber:(NSString *)phone;

//获取用户信息
- (BOOL)loginState;
- (NSString *)username;
- (NSString *)password;
- (NSString *)emailAddress;
- (NSString *)phoneNumber;

- (User *)user;

#pragma mark ----图片缓存-----
//cache路径
- (NSString *)cachesPath;
//存储下载图片文件夹的路径
- (NSString *)downloadImageManagerFilePath;
//下载的图片的完整路径
- (NSString *)imageFilePathWithURL:(NSString *)imageURL;
//根据图片网址从沙盒中获取图像
- (UIImage *)imageFromSandboxWithURL:(NSString *)imageURL;
//将下载的图片存储到沙盒中
- (void)saveDownloadImage:(UIImage *)image imageURL:(NSString *)imageURL;
//清除缓存
- (void)cleanDownloadImages;

#pragma mark ----数据库缓存-----
//数据库存储的路径
- (NSString *)databaseFilePath:(NSString *)databaseName;
//删除数据库
- (void)removeDatabase;
//将对象归档
- (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key;
//反归档
- (id)unarchiverObject:(NSData *)data forKey:(NSString *)key;
@end
