//
//  LoginView.h
//  Douban
//
//  Created by 侯垒 on 14-8-30.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTView;

@interface LoginView : UIView

@property (nonatomic,retain,readonly) LTView * usernameView;
@property (nonatomic,retain,readonly) LTView * passwordView;
@property (nonatomic,retain,readonly) UIButton * loginButton;
@property (nonatomic,retain,readonly) UIButton * registButton;



@end
