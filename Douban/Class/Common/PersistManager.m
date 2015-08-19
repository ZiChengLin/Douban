//
//  PersistManager.m
//  Douban
//
//  Created by 侯垒 on 14-10-9.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "PersistManager.h"
#import "User.h"

@implementation PersistManager

static PersistManager * manager = nil;

+ (PersistManager *)shareInstance
{
    if (manager == nil) {
        
        manager = [[PersistManager alloc] init];
        
    }
    
    return manager;
}

#pragma mark ----用户信息-----

//同步
- (void)synchronize
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//设置用户信息
- (void)setloginState:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:kLoginState];
}
- (void)setUsername:(NSString *)username
{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:kUserName];
}
- (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPassword];
    
}
- (void)setEmail:(NSString *)email
{
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:kEmailAddress];
    
}
- (void)setPhoneNumber:(NSString *)phone
{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:kPhoneNumber];
    
}


//获取用户信息
- (BOOL)loginState
{
    return     [[NSUserDefaults standardUserDefaults] boolForKey:kLoginState];
    
}
- (NSString *)username
{
    return     [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    
}
- (NSString *)password
{
    return     [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
    
}
- (NSString *)emailAddress
{
    return     [[NSUserDefaults standardUserDefaults] objectForKey:kEmailAddress];
    
}
- (NSString *)phoneNumber
{
    return     [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneNumber];
    
}

- (User *)user
{
    User * user = [[User alloc] init];
    user.username = [self username];
    user.password = [self password];
    user.emailAddress = [self emailAddress];
    user.phoneNumber = [self phoneNumber];
    user.isLogin = YES;
    
    return [user autorelease];
}

#pragma mark ----图片缓存-----
//cache路径
- (NSString *)cachesPath
{
    return  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

//存储下载图片的文件夹路径
- (NSString *)downloadImageManagerFilePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * imageManagerPath = [[self cachesPath] stringByAppendingPathComponent:@"DownloadImages"];
    if (NO == [fileManager fileExistsAtPath:imageManagerPath]) {
        //如果沙盒中没有存储图像的文件夹，创建文件夹
        [fileManager createDirectoryAtPath:imageManagerPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return imageManagerPath;
}

//下载的图片的完整路径
- (NSString *)imageFilePathWithURL:(NSString *)imageURL;
{
    //根据图像的URL，创建图像在存储时的文件名
    NSString * imageName = [imageURL stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    return [[self downloadImageManagerFilePath] stringByAppendingPathComponent:imageName];
}

//根据图片网址从沙盒中获取图像
- (UIImage *)imageFromSandboxWithURL:(NSString *)imageURL
{
    NSString * filePath = [self imageFilePathWithURL:imageURL];
    UIImage * image = [UIImage imageWithContentsOfFile:filePath];
    
    return image;
}


//将下载的图片存储到沙盒中
- (void)saveDownloadImage:(UIImage *)image imageURL:(NSString *)imageURL;
{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    NSString * filePath = [self imageFilePathWithURL:imageURL];
    [data writeToFile:filePath atomically:YES];
}


//清除缓存
- (void)cleanDownloadImages
{
    NSString * imageManagerPath = [self downloadImageManagerFilePath];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imageManagerPath error:nil];
    
    [self downloadImageManagerFilePath];
}

#pragma mark ----数据库路径-----
//数据库存储的路径
- (NSString *)databaseFilePath:(NSString *)databaseName
{
    
    return [[self cachesPath] stringByAppendingPathComponent:databaseName];
}

//删除数据库
- (void)removeDatabase
{
    
    [[DatabaseHandle shareInstance] closeDB];
    
    NSString * filePath = [self databaseFilePath:@"Douban.sqlite"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

//将对象归档
- (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key
{
    NSMutableData * data = [NSMutableData data];
    
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    
    [archiver release];
    
    return data;
}

//反归档
- (id)unarchiverObject:(NSData *)data forKey:(NSString *)key
{
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    id object = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    
    [unarchiver release];
    
    return object;
}

@end
