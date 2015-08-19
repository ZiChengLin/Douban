//
//  ActivityDetailViewController.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailView.h"
#import "Activity.h"
#import "LoginViewController.h"
#import "DatabaseHandle.h"

@interface ActivityDetailViewController ()

@property (nonatomic,retain) ActivityDetailView * detailView;


@end

@implementation ActivityDetailViewController

- (void)dealloc
{
    self.detailView = nil;
    self.activity = nil;
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
    self.detailView = [[[ActivityDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _detailView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = _activity.title;
    
    
    //设置显示数据
    [self setupData];
}


//用户登录
- (void)userLogin
{
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    UINavigationController * loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    __block ActivityDetailViewController * detailVC = self;
    
    //定义登录成功后回调的block
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
    
    BOOL isFavorite = [[DatabaseHandle shareInstance] isFavoriteActivityWithID:_activity.ID];
    
    if (YES == isFavorite) {
        
        [self showAlertViewWithTitle:@"提示" message:@"该活动已经被收藏过" cancelButtonTitle:nil otherButtonTitle:@"确定"];
        
        return;
    }

    
    //操作数据库，收藏活动
    [[DatabaseHandle shareInstance] insertNewActivity:_activity];
    
    //显示alertView提示用户
    UIAlertView * alertView = [self showAlertViewWithTitle:@"提示" message:@"收藏成功" cancelButtonTitle:nil otherButtonTitle:nil];
    
    //0.3秒后alertView消失
    [self performSelector:@selector(removeAlertView:) withObject:alertView afterDelay:0.3];
    
}




#pragma mark -----显示数据-----
- (void)setupData
{
    
    //根据活动内容调整滚动视图的contentSize
    [_detailView adjustSubviewsWithContent:_activity.content];
    
    //活动图片
    
    if (_activity.downloadImage == nil) {
        //没有图像，下载图像
        [_activity addObserver:self forKeyPath:@"downloadImage" options:NSKeyValueObservingOptionNew context:nil];

        _detailView.activityImageView.image = [UIImage imageNamed:@"picholder"];
        [_activity loadImage];
        
    }else{
        _detailView.activityImageView.image = _activity.downloadImage;
    }

    
    //标题
    _detailView.titleLabel.text = _activity.title;
    
    //时间
    NSString * startTime = [_activity.begin_time substringWithRange:NSMakeRange(5, 11)];
    NSString * endTime = [_activity.end_time substringWithRange:NSMakeRange(5, 11)];
    _detailView.timeLabel.text = [NSString stringWithFormat:@"%@ -- %@",startTime,endTime];
    
    //主办方
    _detailView.ownerLabel.text = _activity.ownerName;

    //类型
    _detailView.categoryLabel.text = [NSString stringWithFormat:@"类型：%@",_activity.category_name];
    
    //地址
    _detailView.addressLabel.text = _activity.address;
    [_detailView.addressLabel sizeToFit];//label适应文本高度
    
    //内容
    _detailView.contextLabel.text = _activity.content;

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    UIImage *image = [change objectForKey:NSKeyValueChangeNewKey];
    
    _detailView.activityImageView.image = image;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
