//
//  Movie.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (void)dealloc
{

    self.rating = nil;
    self.release_date = nil;
    self.movieName = nil;
    self.movieId = nil;
    self.pic_url = nil;
    self.genres = nil;
    self.country = nil;
    self.runtime = nil;
    self.rating_count = nil;
    self.plot_simple = nil;
    self.actors = nil;

    [super dealloc];
}


- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"pic_url"]) {
    
        
        //图像在沙盒中的路径
        self.imageFilePath = [[PersistManager shareInstance] imageFilePathWithURL:self.pic_url];
        
        //从沙盒中读取图片
        self.downloadImage = [UIImage imageWithContentsOfFile:self.imageFilePath];
        
    }

}


//下载图像
- (void)loadImage
{
    //创建图像下载工具下载图像
    ImageDownloader *loader = [[ImageDownloader alloc] initWithURLString:self.pic_url delegate:self];
    
    self.isDownloading = YES;
    
    [loader autorelease];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"key = %@",key);
}

@end
