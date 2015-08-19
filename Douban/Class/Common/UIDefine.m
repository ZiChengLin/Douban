//
//  UIDefine.m
//  Douban
//
//  Created by 侯垒 on 14-10-9.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "UIDefine.h"

@implementation UIButton (Create)

+ (UIButton *)buttonWithFrame:(CGRect)frame
              normalImageName:(NSString *)normalName
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    
    UIImage * image = [[UIImage imageNamed:normalName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [button setImage:image forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalTitle:(NSString *)normalTitle
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;

    [button setTitle:normalTitle forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
              normalImageName:(NSString *)normalName
                       addTarget:(id)target
                       action:(SEL)action
{
    UIButton * button = [self buttonWithFrame:frame normalImageName:normalName];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                  normalTitle:(NSString *)normalTitle
                       addTarget:(id)target
                       action:(SEL)action
{
    UIButton * button = [self buttonWithFrame:frame normalTitle:normalTitle];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end



@implementation UILabel (Create)

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    
    return [label autorelease];
}

+ (UILabel *)labelWithFrame:(CGRect)frame
                   fontSize:(CGFloat)size
                  lineBreak:(BOOL)isBreak
{
    UILabel * label = [self labelWithFrame:frame text:nil];
    label.font = [UIFont systemFontOfSize:size];
    if (isBreak == YES) {
        label.numberOfLines = 0;
    }
    
    return label;
}


@end



@implementation UIImageView (Create)


+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    
    return [imageView autorelease];
}


@end



@implementation UITextField (Create)

+ (UITextField *)textFieldWithFrame:(CGRect)frame
{
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    return [textField autorelease];
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder secure:(BOOL)isSecure
{

    UITextField * textField = [self textFieldWithFrame:frame];
    
    textField.placeholder = placeholder;
    
    textField.secureTextEntry = isSecure;
    
    return textField;
    
}

@end
