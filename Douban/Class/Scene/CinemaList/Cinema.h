//
//  Cinema.h
//  Douban
//
//  Created by 侯垒 on 14-9-24.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cinema : NSObject

@property (nonatomic,retain) NSString * cinemaId;
@property (nonatomic,retain) NSString * cinemaName;
@property (nonatomic,retain) NSString * address;
@property (nonatomic,retain) NSString * trafficRoutes;
@property (nonatomic,retain) NSString * telephone;
@property (nonatomic,retain) NSMutableArray * broadcasts;


@end
