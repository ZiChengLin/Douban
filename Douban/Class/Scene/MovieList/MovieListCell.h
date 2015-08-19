//
//  MovieListCell.h
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface MovieListCell : UITableViewCell

@property (nonatomic,retain,readonly) UIImageView * movieImageView;

@property (nonatomic,retain) Movie * movie;

@end
