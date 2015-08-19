//
//  UserInfo.m
//  Douban
//
//  Created by 侯垒 on 14-8-31.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "User.h"

@implementation User

- (void)dealloc
{
    self.username = nil;
    self.password = nil;
    self.emailAddress = nil;
    self.phoneNumber = nil;
    [super dealloc];
}

@end
