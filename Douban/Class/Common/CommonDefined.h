//
//  CommonDefined.h
//  Douban
//
//  Created by 侯垒 on 14-8-30.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//



#pragma mark --------日志设置 Log ---------

#define __DEBUG_LOG_ENABLED__ 1

#if __DEBUG_LOG_ENABLED__

#define NSLog(s, ...) NSLog(@"DEBUG %s(%d): %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])

#else

#define NSLog(s, ...)

#endif


#pragma mark -----cell重用标识-----

#define kActiviyCell            @"activityCell"
#define kMovieCell              @"movieCell"
#define kCinemaCell             @"cinemaCell"
#define kActivityFavoriteCell   @"activityFavoriteCell"
#define kMovieFavoriteCell      @"movieFavoriteCell"
#define kUserCell               @"userCell"

#pragma mark -----用户信息 key-----

#define kUserName     @"username"
#define kPassword     @"password"
#define kLoginState   @"isLogin"
#define kIconUrl      @"iconUrl"
#define kEmailAddress @"email"
#define kPhoneNumber  @"phone"


#pragma mark -------归档--------

#define kActivityArchiverKey  @"activity"
#define kMovieArchiverKey     @"movie"


#pragma mark -------通知--------

#define kCleanCachedNotification @"cleanImageCached"
#define kLoginSucessNotification @"loginSucess"
