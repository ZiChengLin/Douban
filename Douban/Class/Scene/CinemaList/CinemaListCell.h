//
//  CinemaListCell.h
//  Douban
//
//  Created by 侯垒 on 14-9-24.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  Cinema;

@interface CinemaListCell : UITableViewCell

@property (nonatomic,retain) Cinema * cinema;


+ (CGFloat)cellHeight:(Cinema *)cinema;

@end
