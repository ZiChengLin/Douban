//
//  CinemaListViewController.m
//  Douban
//
//  Created by 侯垒 on 14-9-24.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "CinemaListViewController.h"
#import "CinemaListCell.h"

#import "DoubanAPIUrl.h"
#import "Cinema.h"

@interface CinemaListViewController ()

@property (nonatomic,retain) NSMutableArray * cinemaArray;


@end

@implementation CinemaListViewController

- (void)dealloc
{
    self.cinemaArray = nil;
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
    
    self.navigationItem.title = @"影院";
    
    self.cinemaArray = [NSMutableArray arrayWithCapacity:40];
 
    [self.tableView registerClass:[CinemaListCell class] forCellReuseIdentifier:kCinemaCell];
    
    [self sendRequest];
}



#pragma mark --网络请求、数据处理--

//发起网络请求
- (void)sendRequest
{
    
    //拼接网址
    
    NSString * urlString = CinemaListAPI;
        
    NSURL * url = [NSURL URLWithString:urlString];
    
    __block CinemaListViewController * listVC = self;
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self.hud hide:YES];
        
        if (data == nil) {
            
            return;
        }
        
        //解析数据
        NSDictionary * sourceDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //数据处理
        NSDictionary * resultDic = sourceDic[@"result"];
        NSArray * sourceArray = resultDic[@"data"];
        
        for (NSDictionary * cinemaDic in sourceArray) {
            
            Cinema * c = [[Cinema alloc] init];
            [c setValuesForKeysWithDictionary:cinemaDic];
            [listVC.cinemaArray addObject:c];
            [c release];
        }
        
        //刷新数据
        [listVC.tableView reloadData];
        
        
    }];


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [_cinemaArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cinema * cinema = _cinemaArray[indexPath.row];
    return [CinemaListCell cellHeight:cinema];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CinemaListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCinemaCell forIndexPath:indexPath];

    
    Cinema * cinema = _cinemaArray[indexPath.row];
    
    cell.cinema = cinema;
    
    
    
    return cell;
}



@end
