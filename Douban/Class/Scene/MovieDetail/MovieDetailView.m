//
//  MovieDetailView.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MovieDetailView.h"

#define TopHeight  190

@interface MovieDetailView ()
{
    UIScrollView * _bottomScrollView;
    UILabel * _movieIntroduceLabel;
}



@end

@implementation MovieDetailView

- (void)dealloc
{
    [_bottomScrollView release];
    [_movieImageView release];
    [_ratingLabel release];
    [_ratingCountLabel release];
    [_pubLabel release];
    [_runtimeLabel release];
    [_genresLabel release];
    [_countryLabel release];
    [_actorsLabel release];
    [_summaryLabel release];
    [_movieIntroduceLabel release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setupSubviews
{
    //scrollView
    _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.bounds.size.height-49)];
//    _bottomScrollView.backgroundColor = [UIColor cyanColor];
    [self addSubview:_bottomScrollView];
    
    //图片
    _movieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 80, 120)];
    _movieImageView.image = [UIImage imageNamed:@"picholder"];
    [_bottomScrollView addSubview:_movieImageView];

    
    //评分
    _ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(128, 20, 70, 20)];
    _ratingLabel.font = [UIFont systemFontOfSize:12.0];
//    _ratingLabel.backgroundColor = [UIColor greenColor];
    [_bottomScrollView addSubview:_ratingLabel];
//    _ratingLabel.text = @"评分：4.6";

    //评论人数
    _ratingCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(198, 20, 80, 20)];
    _ratingCountLabel.font = [UIFont systemFontOfSize:12.0];
//    _ratingCountLabel.backgroundColor = [UIColor greenColor];
    [_bottomScrollView addSubview:_ratingCountLabel];
//    _ratingCountLabel.text = @"(4000评论)";
    
    //发布时间
    _pubLabel = [[UILabel alloc] initWithFrame:CGRectMake(128, 44, 180, 20)];
    _pubLabel.font = [UIFont systemFontOfSize:12.0];
    //    _commentCountLabel.backgroundColor = [UIColor greenColor];
    [_bottomScrollView addSubview:_pubLabel];
//    _pubLabel.text = @"2014-08-22";

    //电影时长
    _runtimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(128, 68, 180, 20)];
    _runtimeLabel.font = [UIFont systemFontOfSize:12.0];
    //    _runtimeLabel.backgroundColor = [UIColor greenColor];
    [_bottomScrollView addSubview:_runtimeLabel];
//    _runtimeLabel.text = @"107分钟";

    //电影分类
    _genresLabel = [[UILabel alloc] initWithFrame:CGRectMake(128, 92, 180, 20)];
    _genresLabel.font = [UIFont systemFontOfSize:12.0];
    //    _genresLabel.backgroundColor = [UIColor greenColor];
    [_bottomScrollView addSubview:_genresLabel];
//    _genresLabel.text = @"动作";

    //国家地区
    _countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(128, 116, 180, 20)];
    _countryLabel.font = [UIFont systemFontOfSize:12.0];
    //    _countryLabel.backgroundColor = [UIColor greenColor];
    [_bottomScrollView addSubview:_countryLabel];
//    _countryLabel.text = @"美国";


    //制作人介绍
    UILabel * actorIntroduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 280, 20)];
    actorIntroduceLabel.text = @"制作人";
    actorIntroduceLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [_bottomScrollView addSubview:actorIntroduceLabel];
    [actorIntroduceLabel release];

    //制作人介绍Label
    _actorsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 280, 30)];
    _actorsLabel.font = [UIFont systemFontOfSize:12.0];
    _actorsLabel.numberOfLines = 0;
    [_bottomScrollView addSubview:_actorsLabel];
    
    
    //电影介绍
    _movieIntroduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 156, 280, 20)];
    _movieIntroduceLabel.text = @"电影情节";
    _movieIntroduceLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [_bottomScrollView addSubview:_movieIntroduceLabel];

    
    
    //电影简介
    _summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 156, 280, 20)];
    _summaryLabel.font = [UIFont systemFontOfSize:12.0];
    _summaryLabel.numberOfLines = 0;
    //    _summaryLabel.backgroundColor = [UIColor greenColor];
    [_bottomScrollView addSubview:_summaryLabel];
    //    _summaryLabel.text = @"美国";

    
    [self adjustSubviewsWithContent];
    
}

//根据电影内容调整scrollView和contextLabel的高度
- (void)adjustSubviewsWithContent
{
    //计算制作人内容
    CGRect actorsRect = [_actorsLabel.text boundingRectWithSize:CGSizeMake(280, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    
    //计算电影简介内容
    CGRect summaryRect = [_summaryLabel.text boundingRectWithSize:CGSizeMake(280, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    
#define kIntroduceTop 20
#define kIntroduceHeight 20
#define kSummaryTop 10
    
    CGFloat height = TopHeight + actorsRect.size.height + kIntroduceTop + kIntroduceHeight + kSummaryTop + summaryRect.size.height + 30;
    
    if (height < self.bounds.size.height) {
        
        height = self.bounds.size.height + 30;
    }
    
    _bottomScrollView.contentSize = CGSizeMake(320, height);

    
    CGRect actorsViewRect = _actorsLabel.frame;
    actorsViewRect.size.height = actorsRect.size.height;
    _actorsLabel.frame = actorsViewRect;
    
    
    CGRect introduceViewRect = _movieIntroduceLabel.frame;
    introduceViewRect.origin.y = _actorsLabel.frame.origin.y + _actorsLabel.frame.size.height + kIntroduceTop;
    _movieIntroduceLabel.frame = introduceViewRect;
    
    
    CGRect summaryViewRect = _summaryLabel.frame;
    summaryViewRect.origin.y = _movieIntroduceLabel.frame.origin.y + _movieIntroduceLabel.frame.size.height + kSummaryTop;
    summaryViewRect.size.height = summaryRect.size.height;
    _summaryLabel.frame = summaryViewRect;
    
    

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
