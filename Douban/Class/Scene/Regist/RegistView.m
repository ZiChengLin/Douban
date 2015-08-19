//
//  RegistView.m
//  Douban
//
//  Created by 侯垒 on 14-8-30.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "RegistView.h"
#import "LTView.h"


@interface RegistView ()
{
    UIScrollView * _bottomScrollView;
}

- (void)p_setupSubviews;
@end

@implementation RegistView

- (void)dealloc
{
    [_usernameView release];
    [_passwordView release];
    [_confirmView release];
    [_emailView release];
    [_phoneNumberView release];
    [_bottomScrollView release];
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
    _bottomScrollView  = [[UIScrollView alloc] initWithFrame:self.bounds];
//    _bottomScrollView.contentSize = CGSizeMake(320, 1000);
    _bottomScrollView.scrollEnabled = NO;
    [self addSubview:_bottomScrollView];
    
    _usernameView = [[LTView alloc] initWithFrame:CGRectMake(20, 30, 280, 30) description:@"用户名：" placeholder:@"请输入用户名"];
    [_bottomScrollView addSubview:_usernameView];

    _passwordView = [[LTView alloc] initWithFrame:CGRectMake(20, 80, 280, 30) description:@"密码：" placeholder:@"请输入密码"];
    [_passwordView setSecureTextEnabled:YES];
    [_bottomScrollView addSubview:_passwordView];

    _confirmView = [[LTView alloc] initWithFrame:CGRectMake(20, 130, 280, 30) description:@"确认密码：" placeholder:@"再次输入密码"];
    [_confirmView setSecureTextEnabled:YES];
    [_bottomScrollView addSubview:_confirmView];

    _emailView = [[LTView alloc] initWithFrame:CGRectMake(20, 180, 280, 30) description:@"邮箱：" placeholder:@"请输入邮箱"];
    _emailView.inputField.keyboardType = UIKeyboardTypeEmailAddress;
    [_bottomScrollView addSubview:_emailView];
    
    _phoneNumberView = [[LTView alloc] initWithFrame:CGRectMake(20, 230, 280, 30) description:@"联系方式：" placeholder:@"请输入联系方式"];
    _phoneNumberView.inputField.keyboardType = UIKeyboardTypeNumberPad;
    [_bottomScrollView addSubview:_phoneNumberView];


    
    
}

//键盘显示
- (void)adjustSubviewsWithKeyboardShow
{

    _bottomScrollView.contentSize = CGSizeMake(320, self.bounds.size.height+20);
    _bottomScrollView.scrollEnabled = YES;
}

//键盘消失
- (void)adjustSubviewsWithKeyboardHide
{
    [UIView animateWithDuration:0.1 animations:^{

        _bottomScrollView.contentOffset = CGPointMake(0, -64);
        
    }];
    _bottomScrollView.scrollEnabled = NO;

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
