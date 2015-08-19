//
//  LTView.m
//  LoginSystem
//
//  Created by 侯垒 on 14-8-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "LTView.h"

@interface LTView ()

- (void)p_setupSubviews;
@end


@implementation LTView

- (void)dealloc
{
    [_descriptionLabel release];
    [_inputField release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self p_setupSubviews];
    }
    return self;
}

//初始化方法，指定label上显示的文字
- (instancetype)initWithFrame:(CGRect)frame description:(NSString *)labelText placeholder:(NSString *)placeholderText
{
    self = [self initWithFrame:frame];
    if (self) {
        
        [self setDecription:labelText];
        _inputField.placeholder = placeholderText;
    }
    
    return self;
}


- (void)p_setupSubviews
{
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    //默认情况下，label和textField宽度是1：2.
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width/3, height)];
    [self addSubview:_descriptionLabel];
    
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(width/3, 0, width - width/3, height)];
    _inputField.borderStyle = UITextBorderStyleRoundedRect;
    _inputField.text = @"";
    [self addSubview:_inputField];

}


//设置label显示的文字
- (void)setDecription:(NSString *)description
{
    _descriptionLabel.text = description;
}

//获取输入框里的内容
- (NSString *)descriptionText
{
    return _descriptionLabel.text;
}

//获取输入框的内容
- (NSString *)inputFieldText
{
    return _inputField.text;
}

//输入框是否 密码格式
- (void)setSecureTextEnabled:(BOOL)isSecureText
{
    _inputField.secureTextEntry = isSecureText;
}

//设置textField代理
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)fieldDelegate
{
    _inputField.delegate = fieldDelegate;
}

//textfield回收键盘
- (void)recyleKeyboard
{
    [_inputField resignFirstResponder];
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
