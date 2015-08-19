//
//  MovieListCell.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MovieListCell.h"
#import "Movie.h"

@interface MovieListCell ()
{
    UILabel * _titleLabel;
    UILabel * _ratingLabel;//分数
    UILabel * _pubdateLabel;//上映时间
}

- (void)p_setupSubviews;

@end

@implementation MovieListCell

- (void)dealloc
{
    self.movie = nil;
    [_titleLabel release];
    [_ratingLabel release];
    [_pubdateLabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self p_setupSubviews];
    }
    return self;
}


- (void)p_setupSubviews
{
   
    //蓝色背景图
    UIImageView * cellBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 302, 106)];
    cellBackgroundView.image = [UIImage imageNamed:@"bg_eventlistcell"];
    [self.contentView addSubview:cellBackgroundView];
    [cellBackgroundView release];
    
    //电影图片
    _movieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 66, 98)];
    _movieImageView.image = [UIImage imageNamed:@"picholder"];
    [cellBackgroundView addSubview:_movieImageView];


    //电影标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 200, 30)];
    _titleLabel.font = [UIFont systemFontOfSize:18.0];
    [cellBackgroundView addSubview:_titleLabel];
//    _titleLabel.backgroundColor = [UIColor yellowColor];
//    _titleLabel.text = @"四大名捕大结局";

    //电影评分
    _ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 200, 25)];
    _ratingLabel.font = [UIFont systemFontOfSize:14.0];
    [cellBackgroundView addSubview:_ratingLabel];
//    _ratingLabel.backgroundColor = [UIColor yellowColor];
//    _ratingLabel.text = @"评分：4.6";

    //上映时间
    _pubdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 68, 200, 25)];
    _pubdateLabel.font = [UIFont systemFontOfSize:14.0];
    [cellBackgroundView addSubview:_pubdateLabel];
//    _pubdateLabel.backgroundColor = [UIColor yellowColor];
//    _pubdateLabel.text = @"评分：4.6";
}


- (void)setMovie:(Movie *)movie
{
    if (_movie != movie) {
        
        [_movie release];
        _movie = [movie retain];
    }
    
    //标题
    _titleLabel.text = movie.movieName;
    
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
