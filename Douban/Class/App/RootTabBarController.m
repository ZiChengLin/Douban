//
//  RootTabBarController.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "RootTabBarController.h"

#import "ActivityListViewController.h"
#import "MovieShowViewController.h"
#import "CinemaListViewController.h"
#import "UserViewController.h"

@interface RootTabBarController ()

//添加controller
- (void)p_setupControllers;

@end

@implementation RootTabBarController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加视图控制器
    [self p_setupControllers];
}

//添加controller
- (void)p_setupControllers
{
    
    //四个模块：活动、电影、影院、我的
    
    //活动
    ActivityListViewController * activityVC = [[[ActivityListViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    UINavigationController * activityNC = [[[UINavigationController alloc] initWithRootViewController:activityVC] autorelease];
    
    activityNC.tabBarItem.title = @"活动";
    activityNC.tabBarItem.image = [UIImage imageNamed:@"activity"];

    //电影
    MovieShowViewController * movieVC = [[[MovieShowViewController alloc] init] autorelease];
    UINavigationController * movieNC = [[[UINavigationController alloc] initWithRootViewController:movieVC] autorelease];

    movieNC.tabBarItem.title = @"电影";
    movieNC.tabBarItem.image = [UIImage imageNamed:@"movie"];
    
    //影院
    CinemaListViewController * cinemaVC = [[[CinemaListViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    UINavigationController * cinemaNC = [[UINavigationController alloc] initWithRootViewController:cinemaVC];
    
    cinemaNC.tabBarItem.title = @"影院";
    cinemaNC.tabBarItem.image = [UIImage imageNamed:@"cinema"];

    //我的
    UserViewController * userVC = [[[UserViewController alloc] init] autorelease];
    UINavigationController * userNC = [[[UINavigationController alloc] initWithRootViewController:userVC] autorelease];
    
    userNC.tabBarItem.title = @"我的";
    userNC.tabBarItem.image = [UIImage imageNamed:@"user"];

    //将所有导航栏设置竖屏时的背景图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
    
    self.viewControllers = @[activityNC,movieNC,cinemaNC,userNC];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
