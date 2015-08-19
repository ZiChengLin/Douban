//
//  RegistView.h
//  Douban
//
//  Created by 侯垒 on 14-8-30.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTView;

@interface RegistView : UIView

@property (nonatomic,retain,readonly) LTView * usernameView;
@property (nonatomic,retain,readonly) LTView * passwordView;
@property (nonatomic,retain,readonly) LTView * confirmView;
@property (nonatomic,retain,readonly) LTView * emailView;
@property (nonatomic,retain,readonly) LTView * phoneNumberView;

//键盘显示
- (void)adjustSubviewsWithKeyboardShow;
//键盘消失
- (void)adjustSubviewsWithKeyboardHide;

@end
