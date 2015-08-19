//
//  RegistViewController.m
//  Douban
//
//  Created by 侯垒 on 14-8-30.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistView.h"
#import "LTView.h"

@interface RegistViewController ()
{

}

- (void)p_showAlertView:(NSString *)title message:(NSString *)message;

@property (nonatomic,retain) RegistView * registView;
@end

@implementation RegistViewController

- (void)dealloc
{
    //注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

    self.registView = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //注册通知，监测键盘弹出和消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}


- (void)loadView
{
    self.registView = [[[RegistView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _registView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"注册";
    
    //注册
    UIBarButtonItem * registButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(didClickRegistButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = registButtonItem;
    [registButtonItem release];

    //设置输入框的代理
    [_registView.usernameView setTextFieldDelegate:self];
    [_registView.passwordView setTextFieldDelegate:self];
    [_registView.confirmView setTextFieldDelegate:self];
    [_registView.emailView setTextFieldDelegate:self];
    [_registView.phoneNumberView setTextFieldDelegate:self];

}

//进行注册
- (void)didClickRegistButtonItemAction:(UIBarButtonItem *)buttonItem
{
    
    //注册时，用户名和密码不能为空
    if ([[_registView.usernameView inputFieldText] isEqualToString:@""] || [[_registView.passwordView inputFieldText] isEqualToString:@""]) {
        
        [self p_showAlertView:@"提示" message:@"用户名和密码不能为空"];
        return;
    }
    
    //注册时，两次输入的密码必须一致
    if (NO == [[_registView.passwordView inputFieldText] isEqualToString:[_registView.confirmView inputFieldText]]) {
        
        [self p_showAlertView:@"提示" message:@"两次输入的密码不一致"];
        return;
    }
    
    //保存注册的用户信息
    [[PersistManager shareInstance] setUsername:[_registView.usernameView inputFieldText]];
    [[PersistManager shareInstance] setPassword:[_registView.passwordView inputFieldText]];
    [[PersistManager shareInstance] setEmail:[_registView.emailView inputFieldText]];
    [[PersistManager shareInstance] setPhoneNumber:[_registView.phoneNumberView inputFieldText]];
    
    //设置用户为登陆状态
    [[PersistManager shareInstance] setloginState:YES];

    [[PersistManager shareInstance] synchronize];

    
    //注册完成后，返回登陆页面
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

//接收到键盘显示通知时，执行该方法
-(void)keyboardWillShow:(NSNotification *)notification
{
    //设置视图可以滚动
    [_registView adjustSubviewsWithKeyboardShow];
}

//接收到键盘消失通知时，执行该方法
-(void)keyboardWillHide:(NSNotification *)notification
{
    
    //设置视图不能滚动
    [_registView adjustSubviewsWithKeyboardHide];
}

//键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
