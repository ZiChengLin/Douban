//
//  BasedObject.h
//  Douban
//
//  Created by 侯垒 on 14-10-13.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloader.h"

@interface BasedObject : NSObject<ImageDownloaderDelegate,NSCoding>

@property (nonatomic,retain) UIImage  * downloadImage;      //下载的图像
@property (nonatomic,retain) NSString * imageFilePath;      //图像在沙盒中的路径
@property (nonatomic,assign) BOOL       isDownloading;      //图像下载状态


//开始下载图像
- (void)loadImage;

@end
