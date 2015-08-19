//
//  Activity.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "Activity.h"

@implementation Activity
- (void)dealloc
{
    self.title = nil;
    self.begin_time = nil;
    self.end_time = nil;
    self.address = nil;
    self.category_name = nil;
    self.imageUrl = nil;
    self.content = nil;
    self.ownerName = nil;
    self.wisher_count = nil;
    self.participant_count = nil;
 
    [super dealloc];
}



//使用KVC赋值，处理model类中不存在字典中的key
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //字典中是id，属性中是ID
    if ([key isEqualToString:@"id"]) {
        
        self.ID = value;
    }
    
    //字典中owner的值是字典，字典中的name是需要的值
    //如果key是owner，从字典中取出name给ownerName赋值。
    if ([key isEqualToString:@"owner"]) {
        
        NSDictionary * ownerDic = (NSDictionary *)value;
        self.ownerName = ownerDic[@"name"];
    }
    
}

//使用KVC赋值，处理model类中存在字典中的key
- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    //wisher_count对应的值可能是 NSString 或 NSNumber
    if ([key isEqualToString:@"wisher_count"]) {
        self.wisher_count = [NSString stringWithFormat:@"%@",value];
    }

    //participant_count对应的值可能是 NSString 或 NSNumber
    if ([key isEqualToString:@"participant_count"]) {
        self.participant_count = [NSString stringWithFormat:@"%@",value];
    }
    
    //字典中的image对应的网址，model对象中imageUrl存网址
    if ([key isEqualToString:@"image"]) {
        
        //图像网址
        self.imageUrl = value;

        NSLog(@"file path = %@",self.imageUrl);

        //图像沙盒中路径
        self.imageFilePath = [[PersistManager shareInstance] imageFilePathWithURL:self.imageUrl];
        
        //从沙盒中创建图像
        self.downloadImage = [UIImage imageWithContentsOfFile:self.imageFilePath];
    }
}



//开始下载图像
- (void)loadImage
{
   
    //使用图像下载工具下载图像
    ImageDownloader *loader = [[ImageDownloader alloc] initWithURLString:self.imageUrl delegate:self];
    
    //标记正在下载图像状态
    self.isDownloading = YES;
    
    [loader autorelease];
    
}




@end
