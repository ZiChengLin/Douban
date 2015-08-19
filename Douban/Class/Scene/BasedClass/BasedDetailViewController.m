//
//  BasedDetailViewController.m
//  Douban
//
//  Created by 侯垒 on 14-10-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BasedDetailViewController.h"

@interface BasedDetailViewController ()

//设置返回按钮
- (void)p_setupBackButtonItem;

@end

@implementation BasedDetailViewController

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
    
    //设置返回按钮
    [self p_setupBackButtonItem];
    //设置收藏按钮
    [self setupFavoriteButtonItem];
    
}

//设置loading
- (void)setupProgressHud
{
    self.hud = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}

//设置返回按钮
- (void)p_setupBackButtonItem
{
    //返回按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];

}

//设置收藏按钮
- (void)setupFavoriteButtonItem
{
    //收藏按钮
    UIBarButtonItem * favoriteButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavoriteButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = favoriteButtonItem;
    [favoriteButtonItem release];

}

#pragma mark -----控制方法-----
//返回
- (void)didClickBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}


//收藏
- (void)didClickFavoriteButtonItemAction:(UIBarButtonItem *)buttonItem
{
    //收藏之前先判断用户是否登录
    BOOL isLogin = [[PersistManager shareInstance] loginState];
    
    if (NO == isLogin) {
        //用户没有登录，显示登录页面进行登录
        [self userLogin];
        
    }else {
        //用户已近登录，直接收藏
        [self favorite];
    }
}

//设置详情页面显示数据
- (void)setupData
{
    //子类重写实现具体方法
}

//用户登录
- (void)userLogin
{
    //子类重写实现具体方法
}

//收藏
- (void)favorite
{
    //子类重写实现具体方法
}

//显示alertView
- (UIAlertView *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    [alertView show];
    [alertView release];

    return alertView;
}

//移除alertView
- (void)removeAlertView:(UIAlertView *)alertView
{
    //alertView消失
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
