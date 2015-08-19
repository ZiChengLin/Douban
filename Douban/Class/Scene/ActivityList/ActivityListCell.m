//
//  ActivityListCell.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ActivityListCell.h"
#import "Activity.h"


@interface ActivityListCell ()
{
    UILabel * _titleLabel;
    UILabel * _timeLabel;
    UILabel * _addressLabel;
    UILabel * _categoryLabel;//分类
    
    UILabel * _wishLabel;//感兴趣
    UILabel * _participantLabel;//参加
    
}

//布局子视图
- (void)p_setupSubviews;

@end


@implementation ActivityListCell

- (void)dealloc
{

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

//布局子视图
- (void)p_setupSubviews
{
    //蓝色背景图
    UIImageView * cellBackgroundView = [UIImageView imageViewWithFrame:CGRectMake(10, 8, 302, 140) imageName:@"bg_eventlistcell"];
    [self.contentView addSubview:cellBackgroundView];
    
    //活动标题
    _titleLabel = [UILabel labelWithFrame:CGRectMake(8, 6, 282, 16) fontSize:14.0 lineBreak:NO];
    [cellBackgroundView addSubview:_titleLabel];
    //    _titleLabel.text = @"罗马与巴洛克艺术";
    
    //信息背景图
    UIImageView * infoBackgroundView = [UIImageView imageViewWithFrame:CGRectMake(2, 28, 298, 106) imageName:@"bg_share_large"];
    [cellBackgroundView addSubview:infoBackgroundView];
    
    //时间
    UIImageView * timeImageView = [UIImageView imageViewWithFrame:CGRectMake(6, 4, 16, 16) imageName:@"icon_date"];
    [infoBackgroundView addSubview:timeImageView];
    
    _timeLabel = [UILabel labelWithFrame:CGRectMake(24, 4, 192, 16) fontSize:12.0 lineBreak:NO];
    [infoBackgroundView addSubview:_timeLabel];
    //    _timeLabel.text = @"07-22 09:00 -- 10-16 17:00";
    
    
    //地址
    UIImageView * addressImageView = [UIImageView imageViewWithFrame:CGRectMake(6, 24, 16, 16) imageName:@"icon_spot"];
    [infoBackgroundView addSubview:addressImageView];
    
    _addressLabel = [UILabel labelWithFrame:CGRectMake(24, 24, 192, 16) fontSize:12.0 lineBreak:NO];
    [infoBackgroundView addSubview:_addressLabel];
    //    _addressLabel.text = @"北京 东城区 东长安街";
    
    //类型
    UIImageView * categoryImageView = [UIImageView imageViewWithFrame:CGRectMake(6, 44, 16, 16) imageName:@"icon_catalog"];
    [infoBackgroundView addSubview:categoryImageView];
    
    _categoryLabel = [UILabel labelWithFrame:CGRectMake(24, 44, 192, 16) fontSize:12.0 lineBreak:NO];
    [infoBackgroundView addSubview:_categoryLabel];
    //    _categoryLabel.text = @"类型：展览";
    
    //感兴趣
    UILabel * wish = [UILabel labelWithFrame:CGRectMake(12, 80, 40, 14) fontSize:10.0 lineBreak:NO];
    [infoBackgroundView addSubview:wish];
    wish.text = @"感兴趣：";
    
    
    _wishLabel = [UILabel labelWithFrame:CGRectMake(52, 80, 35, 14) fontSize:12.0 lineBreak:NO];
    _wishLabel.textColor = [UIColor redColor];
    [infoBackgroundView addSubview:_wishLabel];
    //    _wishLabel.text = @"1968";
    
    
    //参加
    UILabel * participant = [UILabel labelWithFrame:CGRectMake(94, 80, 30, 14) fontSize:10.0 lineBreak:NO];
    [infoBackgroundView addSubview:participant];
    participant.text = @"参加：";
    
    
    _participantLabel = [UILabel labelWithFrame:CGRectMake(124, 80, 30, 14) fontSize:12.0 lineBreak:NO];
    _participantLabel.textColor = [UIColor redColor];
    [infoBackgroundView addSubview:_participantLabel];
    //    _participantLabel.text = @"1638";
    
    //活动图片
    _activityImageView = [UIImageView imageViewWithFrame:CGRectMake(226, 4, 66, 98) imageName:@"picholder"];
    [infoBackgroundView addSubview:_activityImageView];
}

- (void)setActivity:(Activity *)activity
{
    if (_activity != activity) {
        [_activity release];
        _activity = [activity retain];
    }
    
    //标题
    _titleLabel.text = activity.title;
    
    //时间
    NSString * startTime = [activity.begin_time substringWithRange:NSMakeRange(5, 11)];
    NSString * endTime = [activity.end_time substringWithRange:NSMakeRange(5, 11)];
    _timeLabel.text = [NSString stringWithFormat:@"%@ -- %@",startTime,endTime];
    
    //地址
    _addressLabel.text = activity.address;
    
    //类型
    _categoryLabel.text = [NSString stringWithFormat:@"类型：%@",activity.category_name];
    
    //感兴趣人数
    _wishLabel.text = activity.wisher_count;
    
    //参与人数
    _participantLabel.text = activity.participant_count;
    
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
