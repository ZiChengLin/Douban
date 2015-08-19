//
//  BasedObject.m
//  Douban
//
//  Created by 侯垒 on 14-10-13.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BasedObject.h"
#import "NSObject+NSCoding.h"

@implementation BasedObject

- (void)dealloc
{
    //注销“清除缓存”通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCleanCachedNotification object:nil];
    
    self.downloadImage = nil;
    self.imageFilePath = nil;
    [super dealloc];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //注册“清除缓存”通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCleanImageCachedNotification:) name:kCleanCachedNotification object:nil];
    }
    
    return self;
}

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [self autoEncodeWithCoder:aCoder];

}

//反归档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        [self autoDecode:aDecoder];
        
    }
    
    return self;
}

//当接收“清除缓存”通知时的响应方法
- (void)handleCleanImageCachedNotification:(NSNotification *)notification
{
    //清除缓存时，将image置为空
    self.downloadImage = nil;
}

//开始下载图像
- (void)loadImage
{
    //子类实现具体方法
}


//代理方法
- (void)imageDownloader:(ImageDownloader *)downloader finishLoadImage:(UIImage *)image
{
    self.isDownloading = NO;
    self.downloadImage = image;
}


@end
