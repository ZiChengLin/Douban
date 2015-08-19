//
//  MovieCollectionViewController.m
//  Douban
//
//  Created by 侯垒 on 14-9-28.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MovieCollectionViewController.h"
#import "Movie.h"
#import "DoubanAPIUrl.h"
#import "MovieDetailViewController.h"
#import "MBProgressHUD.h"
#import "MovieCollectionCell.h"

@interface MovieCollectionViewController ()

@property (nonatomic,retain) NSMutableArray * movieArray;
@property (nonatomic,retain) MBProgressHUD * hud;

//发起网络请求
- (void)p_sendReuqest;
- (void)p_setupProgressHud;

@end

@implementation MovieCollectionViewController
- (void)dealloc
{
    self.movieArray = nil;
    self.hud = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.movieArray = [NSMutableArray arrayWithCapacity:40];
    
    //设置collectionView的layout
    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    
    [self.collectionView registerClass:[MovieCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    

    //发起网络请求获取数据
    [self p_sendReuqest];
    
    //设置loading
    [self p_setupProgressHud];

}

//设置loading
- (void)p_setupProgressHud
{
    self.hud = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}


#pragma mark --网络请求、数据处理--

//发起网络请求
- (void)p_sendReuqest
{
    
    //拼接网址
    NSString * urlString = MovieListAPI;
    NSURL * url = [NSURL URLWithString:urlString];
    
    
    //建立网络连接
    __block  MovieCollectionViewController * listVC = self;
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [_hud hide:YES];
        
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
        [listVC.collectionView reloadData];
        
    }];
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 140);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_movieArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Movie * movie = _movieArray[indexPath.row];

    cell.movie = movie;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
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
