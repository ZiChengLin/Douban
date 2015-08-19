//
//  CinemaListCell.m
//  Douban
//
//  Created by 侯垒 on 14-9-24.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "CinemaListCell.h"
#import "Cinema.h"

#define kTop 28
#define kMargin  8

@interface CinemaListCell ()
{
    UIImageView * _cellBackgroundView;
    UILabel * _titleLabel;
    UILabel * _addressLabel;
    UILabel * _phoneNumberLabel;
}

//布局子视图
- (void)p_setupSubviews;

@end

@implementation CinemaListCell

- (void)dealloc
{
    self.cinema = nil;
    [_cellBackgroundView release];
    [_titleLabel release];
    [_addressLabel release];
    [_phoneNumberLabel release];
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
    _cellBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 302, 90)];
    _cellBackgroundView.image = [UIImage imageNamed:@"bg_eventlistcell"];
    [self.contentView addSubview:_cellBackgroundView];

    //活动标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 6, 282, 16)];
    _titleLabel.font = [UIFont systemFontOfSize:18.0];
    [_cellBackgroundView addSubview:_titleLabel];
    //    _titleLabel.text = @"罗马与巴洛克艺术";

    //地址
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 36, 278, 14)];
    _addressLabel.font = [UIFont systemFontOfSize:12.0];
    _addressLabel.numberOfLines = 0;
    [_cellBackgroundView addSubview:_addressLabel];
    //    _addressLabel.text = @"北京 东城区 东长安街";
    


    //联系方式
    _phoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 76, 278, 14)];
    _phoneNumberLabel.font = [UIFont systemFontOfSize:12.0];
    [_cellBackgroundView addSubview:_phoneNumberLabel];
    

}

- (void)setCinema:(Cinema *)cinema
{

    if (_cinema != cinema) {
        [_cinema release];
        _cinema = [cinema retain];
    }
    
    _titleLabel.text = cinema.cinemaName;
    
    _addressLabel.text = cinema.address;
    
    
    _phoneNumberLabel.text = cinema.telephone;
    
    CGRect addressRect = _addressLabel.frame;
    addressRect.size.height = [[self class] addressHeight:cinema.address];
    _addressLabel.frame = addressRect;
    
    
    CGRect phoneNumberRect = _phoneNumberLabel.frame;
    phoneNumberRect.origin.y = _addressLabel.frame.origin.y + _addressLabel.frame.size.height + 10;
    _phoneNumberLabel.frame = phoneNumberRect;
    
    CGRect backgroundRect = _cellBackgroundView.frame;
    backgroundRect.size.height = _phoneNumberLabel.frame.origin.y + _phoneNumberLabel.frame.size.height + 10;
    _cellBackgroundView.frame = backgroundRect;
    
}


+ (CGFloat)cellHeight:(Cinema *)cinema
{
    
    CGFloat addressHeight = [[self class] addressHeight:cinema.address];
    

    return 36 + addressHeight + kMargin + 14 + 30;
    
}

+ (CGFloat)addressHeight:(NSString *)address
{
    CGRect addressRect = [address boundingRectWithSize:CGSizeMake(278, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    
    return addressRect.size.height;

}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
