//
//  User.h
//  Douban
//
//  Created by 侯垒 on 14-8-31.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,retain) NSString * username;
@property (nonatomic,retain) NSString * password;
@property (nonatomic,retain) NSString * emailAddress;
@property (nonatomic,retain) NSString * phoneNumber;

@property (nonatomic,assign) BOOL isLogin;

@end
