//
//  LoginView.m
//  Douban
//
//  Created by 侯垒 on 14-8-30.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "LoginView.h"
#import "LTView.h"

@interface LoginView ()

- (void)p_setupSubviews;

@end

@implementation LoginView

- (void)dealloc
{
    [_usernameView release];
    [_passwordView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupSubviews];
    }
    return self;
}


- (void)p_setupSubviews
{
    _usernameView = [[LTView alloc] initWithFrame:CGRectMake(20, 60, 280, 30) description:@"用户名：" placeholder:@"请输入用户名"];
    [self addSubview:_usernameView];
    
    _passwordView = [[LTView alloc] initWithFrame:CGRectMake(20, 110, 280, 30) description:@"密码：" placeholder:@"请输入密码"];
    [self addSubview:_passwordView];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginButton.frame = CGRectMake(20, 170, 120, 40);
    [_loginButton setImage:[[UIImage imageNamed:@"login_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self addSubview:_loginButton];

    _registButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _registButton.frame = CGRectMake(180, 170, 120, 40);
    [_registButton setImage:[[UIImage imageNamed:@"register_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self addSubview:_registButton];

}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
