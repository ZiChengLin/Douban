//
//  ImageDownloader.m
//  Lesson36Kr
//
//  Created by 侯垒 on 14-8-4.
//  Copyright (c) 2014年 www.lanou3g.com. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

- (instancetype)initWithURLString:(NSString *)urlStr delegate:(id<ImageDownloaderDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.urlString = urlStr;
        self.delegate = delegate;
        
        [self startDownload];
    }
    return self;

}



- (void)startDownload
{
    //先从沙盒中读取图像
    UIImage * image = [[PersistManager shareInstance] imageFromSandboxWithURL:self.urlString];
    
    //如果沙盒中已经存储下载过的图像
    if (image != nil) {
        
        if ([_delegate respondsToSelector:@selector(imageDownloader:finishLoadImage:)]) {
            [_delegate imageDownloader:self finishLoadImage:image];
        }
        
        return;
    }
    
    //如果图片未下载过，先下载
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        UIImage *image = [UIImage imageWithData:data];
        [[PersistManager shareInstance] saveDownloadImage:image imageURL:self.urlString];
        
        if ([_delegate respondsToSelector:@selector(imageDownloader:finishLoadImage:)]) {
            [_delegate imageDownloader:self finishLoadImage:image];
        }
        
    }];

}


@end
