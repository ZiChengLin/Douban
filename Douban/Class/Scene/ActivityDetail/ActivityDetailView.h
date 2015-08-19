//
//  ActivityDetailView.h
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailView : UIView

@property (nonatomic,retain,readonly) UIImageView * activityImageView;
@property (nonatomic,retain,readonly) UILabel * titleLabel;
@property (nonatomic,retain,readonly) UILabel * timeLabel;
@property (nonatomic,retain,readonly) UILabel * addressLabel;
@property (nonatomic,retain,readonly) UILabel * ownerLabel;
@property (nonatomic,retain,readonly) UILabel * categoryLabel;
@property (nonatomic,retain,readonly) UILabel * contextLabel;


//根据活动内容调整scrollView和contextLabel的高度
- (void)adjustSubviewsWithContent:(NSString *)content;

@end
