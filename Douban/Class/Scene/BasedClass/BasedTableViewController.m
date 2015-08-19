//
//  BasedTableViewController.m
//  Douban
//
//  Created by 侯垒 on 14-10-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BasedTableViewController.h"

@interface BasedTableViewController ()


//设置loading
- (void)p_setupProgressHud;

@end

@implementation BasedTableViewController

- (void)dealloc
{
    self.hud = nil;
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
    
    //不显示tableView的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    //设置显示loading
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

//发起网络请求
- (void)sendRequest
{
    //子类重写实现具体方法
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
