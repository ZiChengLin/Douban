//
//  UserViewController.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "UserViewController.h"
#import "LoginViewController.h"
#import "ActivityFavoriteViewController.h"
#import "MovieFavoriteViewController.h"
#import "SDImageCache.h"

#define kLoginAlertViewTag   100
#define kCleanAlertViewTag   101

@interface UserViewController ()
{
    NSArray * _titleArray;//标题
    
    
}

//显示活动收藏页面
- (void)p_showFavoriteActivity;
//显示电影收藏页面
- (void)p_showFavoriteMovie;
//清除缓存
- (void)p_cleanImageCache;
//设置登陆按钮
- (void)p_setupLoginButtonItem;
//设置注销按钮
- (void)p_setupLogoutButtonItem;


@end

@implementation UserViewController

- (void)dealloc
{
    
    //注销“登录成功”通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSucessNotification object:nil];

    [_titleArray release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        _titleArray = [[NSArray alloc ] initWithObjects:@"我的活动",@"我的电影",@"清除缓存", nil];
        
        //注册“登录成功”通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoginSuccessNotification:) name:kLoginSucessNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的";
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kUserCell];
    
    if (YES == [[PersistManager shareInstance] loginState]) {
        
        //已登录，设置注销按钮
        [self p_setupLogoutButtonItem];
        
    }else{
        
        //已注销，设置登陆按钮
        [self p_setupLoginButtonItem];
    }
    

}

//设置登陆按钮
- (void)p_setupLoginButtonItem
{
    UIBarButtonItem * loginButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(didClickLoginButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = loginButtonItem;
    [loginButtonItem release];
}

//设置注销按钮
- (void)p_setupLogoutButtonItem
{
    UIBarButtonItem * closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCloseButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = closeButtonItem;
    [closeButtonItem release];
}


//注销按钮的响应方法
- (void)didClickCloseButtonItemAction:(UIBarButtonItem *)buttonItem
{
    //使用警告框提醒用户是否确定注销
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认注销" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = kLoginAlertViewTag;
    [alertView show];
    [alertView release];

}

//登陆按钮响应方法
- (void)didClickLoginButtonItemAction:(UIBarButtonItem *)buttonItem
{
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    UINavigationController * loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    __block UserViewController * userVC = self;
    
    loginVC.successBlock = ^(id userInfo){
        
        NSLog(@"登陆成功");
        
        //设置登陆按钮
        [userVC p_setupLogoutButtonItem];

    };
    
    [self presentViewController:loginNC animated:YES completion:nil];
    
    [loginNC release];
    [loginVC release];
}

- (void)handleLoginSuccessNotification:(NSNotification *)notification
{

    [self p_setupLogoutButtonItem];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        
        switch (alertView.tag) {
            case kLoginAlertViewTag:{
                
                //用户注销，修改登陆状态
                [[PersistManager shareInstance] setloginState:NO];
                [[PersistManager shareInstance] synchronize];
                [[PersistManager shareInstance] removeDatabase];//移除数据库
                
                //设置登陆按钮
                [self p_setupLoginButtonItem];

                break;
            }
            case kCleanAlertViewTag:{
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kCleanCachedNotification object:self];
                
                NSLog(@"清除缓存");
                [[PersistManager shareInstance] cleanDownloadImages];
                [[SDImageCache sharedImageCache] clearDisk];

                break;
            }
            default:
                break;
        }
    }
}

#pragma mark ------UITableView 配置------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kUserCell forIndexPath:indexPath];
    
    cell.textLabel.text = _titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            //我的活动
            [self p_showFavoriteActivity];
            
            break;
        }
        case 1:{
            //我的电影
            [self p_showFavoriteMovie];
            break;
        }
        case 2:{
            //清除缓存
            [self p_cleanImageCache];
            
            break;
        }
        default:
            break;
    }
}

#pragma mark ------UITableViewCell点击的响应方法------
//进入活动收藏页面
- (void)p_showFavoriteActivity
{
    //获取登陆状态
    BOOL isLogin = [[PersistManager shareInstance] loginState];
    
    if (YES == isLogin) {
        //已登录，进入活动收藏页面
        ActivityFavoriteViewController * activityVC = [[ActivityFavoriteViewController alloc] init];
        [self.navigationController pushViewController:activityVC animated:YES];
        
    }else{
        
        //未登陆，进入登陆页面
        LoginViewController * loginVC = [[LoginViewController alloc] init];
        UINavigationController * loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
        __block UserViewController * userVC = self;
        
        loginVC.successBlock = ^(id userInfo){
            
            NSLog(@"登陆成功");
            
            //登录成功后，进入活动收藏页面
            ActivityFavoriteViewController * activityVC = [[ActivityFavoriteViewController alloc] init];
            [userVC.navigationController pushViewController:activityVC animated:YES];
            [activityVC release];
        };
        
        [self presentViewController:loginNC animated:YES completion:nil];
        
        [loginNC release];
        [loginVC release];

    }
}

//进入电影收藏页面
- (void)p_showFavoriteMovie
{
    //获取登陆状态
    BOOL isLogin = [[PersistManager shareInstance] loginState];
    
    if (YES == isLogin) {
        
        //已登录，进入电影收藏页面
        MovieFavoriteViewController * favoriteVC = [[MovieFavoriteViewController alloc] init];
        [self.navigationController pushViewController:favoriteVC animated:YES];
        
    }else{
        
        //未登录，进入登陆页面
        LoginViewController * loginVC = [[LoginViewController alloc] init];
        UINavigationController * loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
 
        
        __block UserViewController * userVC = self;
        loginVC.successBlock = ^(id userInfo){
            
            NSLog(@"登陆成功");
            
            //登录成功后，进入电影收藏页面
            MovieFavoriteViewController * favoriteVC = [[MovieFavoriteViewController alloc] init];
            [userVC.navigationController pushViewController:favoriteVC animated:YES];
            [favoriteVC release];

        };
        
        [self presentViewController:loginNC animated:YES completion:nil];
        
        [loginNC release];
        [loginVC release];

    }
}

//清除缓存
- (void)p_cleanImageCache
{
    
    //使用警告框提醒用户是否确定清楚缓存
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = kCleanAlertViewTag;
    [alertView show];
    [alertView release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
