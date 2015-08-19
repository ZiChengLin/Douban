//
//  ActivityListViewController.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ActivityListViewController.h"
#import "ActivityDetailViewController.h"

#import "ActivityListCell.h"
#import "Activity.h"

#import "DoubanAPIUrl.h"

@interface ActivityListViewController ()

@property (nonatomic,retain) NSMutableArray * activityArray;

@end

@implementation ActivityListViewController

- (void)dealloc
{
    self.activityArray = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"活动";
    
    [self.tableView registerClass:[ActivityListCell class] forCellReuseIdentifier:kActiviyCell];
    
    //初始化数组
    self.activityArray = [NSMutableArray arrayWithCapacity:40];
    
    //发起网络请求获取数据
    [self sendRequest];

}


#pragma mark --网络请求、数据处理--

//发起网络请求
- (void)sendRequest
{
    
    //拼接网址
    NSString * urlString = ActivityListAPI;
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    
    //建立网络连接
    __block  ActivityListViewController * listVC = self;
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self.hud hide:YES];

        if (data == nil) {
            
            return;
        }
        
        //解析数据
        NSDictionary * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
        //数据处理
        NSArray * sourceArray = sourceDic[@"events"];
        
        for (NSDictionary * activityDic in sourceArray) {
            
            Activity * act = [[Activity alloc] init];
            [act setValuesForKeysWithDictionary:activityDic];
            [listVC.activityArray addObject:act];
            [act release];
        }
        
        //刷新数据
        [listVC.tableView reloadData];
        
    }];
    
}


#pragma mark -- Table view data source --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_activityArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:kActiviyCell forIndexPath:indexPath];
    
    Activity * act = _activityArray[indexPath.row];
    
    cell.activity = act;
    
    //下载图片
    if (act.isDownloading == NO && act.downloadImage == nil) {
        
        //如果图片没有下载过，先显示占位图，再开始下载
       cell.activityImageView.image = [UIImage imageNamed:@"picholder"];
        
       [act loadImage];
        
        //给Activity对象添加观察者，监测image的变化
       [act addObserver:self forKeyPath:@"downloadImage" options:NSKeyValueObservingOptionNew context:[indexPath retain]];//把indexPath座位参数的主要原因：下载完图片，检查此indexPath是否属于正在显示的indexPath，如果是，就刷新cell的imageView，如果不是，什么都不做，下载重用的时候，更新image。
    }else{
        
        //图片已经下载过，直接加载显示
        cell.activityImageView.image = act.downloadImage;
    }
    
    return cell;
}

// KVO需要实现的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //context是 我们 开启监听时 传入的indexPath
    //object是我们 监听的对象 acitivity
    //change里面包含了keyPath对应的新值
    NSIndexPath *indexPath = (NSIndexPath *)context;
    UIImage *image = [change objectForKey:NSKeyValueChangeNewKey];
    
    //获得正在显示的所有的indexPath。
    NSArray *indexPaths = [self.tableView indexPathsForVisibleRows];
    if ([indexPaths containsObject:indexPath]) {//如果我们下载时传入的indexPath包含在显示的indexPaths里，更新cell的imageView.image。
        
        ActivityListCell *cell = (ActivityListCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.activityImageView.image =  image;
    }
    
    //移除观察者
    [object removeObserver:self forKeyPath:keyPath context:context];
    
    [indexPath release];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 155;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //进入活动详情页面
    ActivityDetailViewController * detailVC = [[ActivityDetailViewController alloc] init];
    
    //传值
    Activity * activity = _activityArray[indexPath.row];
    detailVC.activity = activity;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
