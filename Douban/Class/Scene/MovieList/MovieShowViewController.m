//
//  MovieShowViewController.m
//  Douban
//
//  Created by 侯垒 on 14-9-28.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MovieShowViewController.h"
#import "MovieListViewController.h"
#import "MovieCollectionViewController.h"

@interface MovieShowViewController ()
{
    MovieListViewController * _listVC;
    MovieCollectionViewController * _collectionVC;
    BOOL _isShowList;
}
@end

@implementation MovieShowViewController
- (void)dealloc
{
    [_listVC release];
    [_collectionVC release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"电影";

    UIImage * image = [[UIImage imageNamed:@"btn_nav_collection"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * switchButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(didClickSwitchButtonItem:)];
    self.navigationItem.rightBarButtonItem = switchButtonItem;
    [switchButtonItem release];
    
    _listVC = [[MovieListViewController alloc] initWithStyle:UITableViewStylePlain];
    _listVC.view.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-44);
    [self addChildViewController:_listVC];
    
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionVC = [[MovieCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    _collectionVC.view.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-44-49);
    [flowLayout release];
    [self addChildViewController:_collectionVC];
    
    [self.view addSubview:_listVC.view];
    _isShowList = YES;
    
}

- (void)didClickSwitchButtonItem:(UIBarButtonItem *)buttonItem
{
    // UIViewAnimationOptionTransitionFlipFromRight
    
    if (_isShowList == NO) {
        
        UIImage * image = [[UIImage imageNamed:@"btn_nav_collection"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        buttonItem.image = image;
        [UIView transitionFromView:_collectionVC.view toView:_listVC.view duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) completion:nil];
        
        
    }else{

        UIImage * image = [[UIImage imageNamed:@"btn_nav_list"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        buttonItem.image = image;
        [UIView transitionFromView:_listVC.view toView:_collectionVC.view duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) completion:nil];
        
    }
    
    _isShowList = !_isShowList;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
