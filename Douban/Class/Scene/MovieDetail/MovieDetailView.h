//
//  MovieDetailView.h
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailView : UIView

@property (nonatomic,retain,readonly) UIImageView * movieImageView;
@property (nonatomic,retain,readonly) UILabel * ratingLabel;
@property (nonatomic,retain,readonly) UILabel * ratingCountLabel;
@property (nonatomic,retain,readonly) UILabel * pubLabel;
@property (nonatomic,retain,readonly) UILabel * runtimeLabel;
@property (nonatomic,retain,readonly) UILabel * genresLabel;
@property (nonatomic,retain,readonly) UILabel * countryLabel;
@property (nonatomic,retain,readonly) UILabel * actorsLabel;
@property (nonatomic,retain,readonly) UILabel * summaryLabel;


- (void)setupSubviews;

- (void)adjustSubviewsWithContent;


@end
