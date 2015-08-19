//
//  BasedDetailViewController.h
//  Douban
//
//  Created by 侯垒 on 14-10-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

@interface BasedDetailViewController : UIViewController

@property (nonatomic,retain) MBProgressHUD * hud;  //loading

//设置收藏按钮
- (void)setupFavoriteButtonItem;
//设置loading
- (void)setupProgressHud;
//设置数据
- (void)setupData;
//用户登录
- (void)userLogin;
//用户收藏
- (void)favorite;
//显示alertView
- (UIAlertView *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle;
//移除alertView
- (void)removeAlertView:(UIAlertView *)alertView;

@end
