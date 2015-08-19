//
//  LoginViewController.h
//  Douban
//
//  Created by 侯垒 on 14-8-30.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginSuccessBlock)(id userInfo);

@interface LoginViewController : UIViewController

@property (nonatomic,copy) LoginSuccessBlock successBlock;//登陆成功后回调

@end
