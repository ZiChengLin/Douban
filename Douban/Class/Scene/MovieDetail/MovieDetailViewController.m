//
//  MovieDetailViewController.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieDetailView.h"
#import "Movie.h"
#import "LoginViewController.h"
#import "DoubanAPIUrl.h"
#import "DatabaseHandle.h"


@interface MovieDetailViewController ()

@property (nonatomic,retain) MovieDetailView * detailView;

//发起网络请求
- (void)p_sendReuqest;

@end

@implementation MovieDetailViewController

- (void)dealloc
{
    self.detailView = nil;
    self.movie = nil;
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

- (void)loadView
{
    self.detailView = [[[MovieDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _detailView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = _movie.movieName;
    
    self.navigationItem.rightBarButtonItem = nil;
    
    //如果活动未收藏，显示收藏按钮
    BOOL isFavorite = [[DatabaseHandle shareInstance] isFavoriteMovieWithID:_movie.movieId];

    
    if (isFavorite == YES) {
        //如果已经收藏过
        [self.detailView setupSubviews];
        [self setupData];

    }else{

        //如果为收藏过，发起请求
        [self p_sendReuqest];
        [self setupProgressHud];
    }


}

#pragma mark --网络请求、数据处理--
//发起网络请求
- (void)p_sendReuqest
{
    //拼接网址，需要使用 电影列表页面中得到的电影编号，根据电影编号获取某个电影的详情
    NSString * urlString = [NSString stringWithFormat:@"%@?movieId=%@",MovieDetailAPI,_movie.movieId];
    NSURL * url = [NSURL URLWithString:urlString];
    
    __block MovieDetailViewController * detailVC = self;
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        [self.hud hide:YES];
        
        if (data == nil) {
            
            return;
        }
        

        
        NSDictionary * movieDetailDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //电影列表页面已经获取到了部分数据，直接继续添加详情页面需要的数据即可，不需要创建一个新的movie对象
        
        //获取数据
        
        movieDetailDic = movieDetailDic[@"result"];
        
        detailVC.movie.rating = movieDetailDic[@"rating"];
        
        //评论人数
        detailVC.movie.rating_count = movieDetailDic[@"rating_count"];

        //时长
        detailVC.movie.runtime = movieDetailDic[@"runtime"];
        
        //类型
        detailVC.movie.genres = movieDetailDic[@"genres"];
        
        //国家
        detailVC.movie.country = movieDetailDic[@"country"];

        //简介
        detailVC.movie.plot_simple = movieDetailDic[@"plot_simple"];
        
        //上映时间
        detailVC.movie.release_date = movieDetailDic[@"release_date"];
        
        //制作人
        detailVC.movie.actors = movieDetailDic[@"actors"];
        
        
        //布局页面
        [detailVC.detailView setupSubviews];
        
        //设置显示数据
        [self setupData];
        
       
        
    }];

}

//用户登录
- (void)userLogin
{
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    UINavigationController * loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    //定义登录成功后回调的block
    
    __block MovieDetailViewController * detailVC = self;
    
    loginVC.successBlock = ^(id userInfo){
        
        NSLog(@"登陆成功");
        
        [detailVC favorite];
        
    };
    
    [self presentViewController:loginNC animated:YES completion:nil];
    
    [loginNC release];
    [loginVC release];
    
}

//收藏活动
- (void)favorite
{
    
    BOOL isFavorite = [[DatabaseHandle shareInstance] isFavoriteMovieWithID:_movie.movieId];
    
    if (YES == isFavorite) {
        
        [self showAlertViewWithTitle:@"提示" message:@"该电影已经被收藏过" cancelButtonTitle:nil otherButtonTitle:@"确定"];

        return;
    }
    
    //操作数据库，收藏活动
    [[DatabaseHandle shareInstance] insertNewMovie:_movie];
    
    //显示alertView提示用户
    UIAlertView * alertView = [self showAlertViewWithTitle:@"提示" message:@"收藏成功" cancelButtonTitle:nil otherButtonTitle:nil];
    
    [self performSelector:@selector(removeAlertView:) withObject:alertView afterDelay:0.3];
}

#pragma mark -----显示数据-----
- (void)setupData
{
    
    //设置收藏按钮
    [self setupFavoriteButtonItem];
    
    //电影图像
    if (_movie.downloadImage == nil) {
        //没有图像，下载图像
        [_movie addObserver:self forKeyPath:@"downloadImage" options:NSKeyValueObservingOptionNew context:nil];
        
        _detailView.movieImageView.image = [UIImage imageNamed:@"picholder"];
        [_movie loadImage];
        

        
    }else{
        
        _detailView.movieImageView.image = _movie.downloadImage;
    }
    
    //评分
    _detailView.ratingLabel.text = [NSString stringWithFormat:@"评分：%@",_movie.rating];
    
    //评论人数
    _detailView.ratingCountLabel.text = [NSString stringWithFormat:@"(%@评论)",_movie.rating_count];
    
    //上映日期
    _detailView.pubLabel.text = _movie.release_date;

    //时长
    _detailView.runtimeLabel.text = _movie.runtime;

    //分类
    _detailView.genresLabel.text = _movie.genres;

    //国家
    _detailView.countryLabel.text = _movie.country;
    
    //制作人
    _detailView.actorsLabel.text = _movie.actors;
    
    //简介
    _detailView.summaryLabel.text = _movie.plot_simple;
    
    [_detailView adjustSubviewsWithContent];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    UIImage *image = [change objectForKey:NSKeyValueChangeNewKey];
    
    _detailView.movieImageView.image = image;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
