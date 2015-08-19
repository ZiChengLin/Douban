//
//  BasedTableViewController.h
//  Douban
//
//  Created by 侯垒 on 14-10-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

@interface BasedTableViewController : UITableViewController

@property (nonatomic,retain) MBProgressHUD * hud;  //loading

//发起网络请求
- (void)sendRequest;

@end
