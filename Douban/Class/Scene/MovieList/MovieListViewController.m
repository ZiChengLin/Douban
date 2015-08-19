//
//  MovieListViewController.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieListCell.h"
#import "Movie.h"
#import "DoubanAPIUrl.h"
#import "MovieDetailViewController.h"

@interface MovieListViewController ()

@property (nonatomic,retain) NSMutableArray * movieArray;

@end

@implementation MovieListViewController

- (void)dealloc
{
    self.movieArray = nil;
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.movieArray = [NSMutableArray arrayWithCapacity:40];
    
    [self.tableView registerClass:[MovieListCell class] forCellReuseIdentifier:kMovieCell];
    
    //发起网络请求获取数据
    [self sendRequest];


}


#pragma mark --网络请求、数据处理--

//发起网络请求
- (void)sendRequest
{
    
    //拼接网址
    NSString * urlString = MovieListAPI;
    NSURL * url = [NSURL URLWithString:urlString];
    
    
    //建立网络连接
    __block  MovieListViewController * listVC = self;
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self.hud hide:YES];
        
        if (data == nil) {
            
            return;
        }
        
        //解析数据
        NSDictionary * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //数据处理
        NSArray * sourceArray = sourceDic[@"result"];
        
        for (NSDictionary * movieDic in sourceArray) {
            
            
            Movie * m = [[Movie alloc] init];
            [m setValuesForKeysWithDictionary:movieDic];
            [listVC.movieArray addObject:m];
            [m release];
        }
        
        //刷新数据
        [listVC.tableView reloadData];
        
        
    }];

}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_movieArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MovieListCell *cell = [tableView dequeueReusableCellWithIdentifier:kMovieCell forIndexPath:indexPath];
    
    Movie * m = _movieArray[indexPath.row];
    cell.movie = m;
    
    //下载图片
    if (m.isDownloading == NO && m.downloadImage == nil) {
        
        //如果图片没有下载过，先显示占位图，再开始下载
        cell.movieImageView.image = [UIImage imageNamed:@"picholder"];

        [m loadImage];
        
        //给Movie对象添加观察者，监测image的变化
        [m addObserver:self forKeyPath:@"downloadImage" options:NSKeyValueObservingOptionNew context:[indexPath retain]];
    }else{
        
        //图片已经下载过，直接加载显示
        cell.movieImageView.image = m.downloadImage;
    }

    
    return cell;

}

//KVO需要实现的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    NSIndexPath * indexPath = (NSIndexPath *)context;
    
    UIImage * image = change[NSKeyValueChangeNewKey];
    
    NSArray * indexPaths = [self.tableView indexPathsForVisibleRows];
    
    if ([indexPaths containsObject:indexPath]) {
        
        MovieListCell * cell = (MovieListCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.movieImageView.image = image;
    }
    
    [object removeObserver:self forKeyPath:keyPath context:context];
    [indexPath release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 122;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //展示电影详情页面
    MovieDetailViewController * detailVC = [[MovieDetailViewController alloc] init];
    
    //传值
    Movie * m = _movieArray[indexPath.row];
    detailVC.movie = m;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
