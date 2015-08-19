//
//  ImageDownloader.h
//  Lesson36Kr
//
//  Created by 侯垒 on 14-8-4.
//  Copyright (c) 2014年 www.lanou3g.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ImageDownloader;
@protocol ImageDownloaderDelegate <NSObject>

- (void)imageDownloader:(ImageDownloader *)downloader finishLoadImage:(UIImage *)image;

@end

@interface ImageDownloader : NSObject

@property (nonatomic, copy)NSString *urlString;
@property (nonatomic, assign)id <ImageDownloaderDelegate>delegate;


//给一个 url字符串创建一个下载器，下载URL对应的图片
- (instancetype)initWithURLString:(NSString *)urlStr delegate:(id<ImageDownloaderDelegate>)delegate;


- (void)startDownload;

@end
