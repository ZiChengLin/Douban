//
//  MovieCollectionCell.m
//  Douban
//
//  Created by 侯垒 on 14-9-28.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MovieCollectionCell.h"
#import "Movie.h"
#import "UIImageView+WebCache.h"

@interface MovieCollectionCell ()
{
    UIImageView * _movieImageView;
    UILabel *_movieNameLabel;
}

- (void)p_setupSubviews;

@end

@implementation MovieCollectionCell
- (void)dealloc
{
    [_movieImageView release];
    [_movieNameLabel release];
    self.movie = nil;
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self p_setupSubviews];
    }
    return self;
}

- (void)p_setupSubviews
{
    _movieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 110)];
    [self.contentView addSubview:_movieImageView];


    _movieNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, self.bounds.size.width, 30)];
    _movieNameLabel.textAlignment = NSTextAlignmentCenter;
    _movieNameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _movieNameLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_movieNameLabel];
}

- (void)setMovie:(Movie *)movie
{
    if (_movie != movie) {
        [_movie release];
        _movie = [movie retain];
    }
    
    
    NSURL * url = [NSURL URLWithString:movie.pic_url];
    [_movieImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"picholder.png"]];
    
    _movieNameLabel.text = movie.movieName;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
