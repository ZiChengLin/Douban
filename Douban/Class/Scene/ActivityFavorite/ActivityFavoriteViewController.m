//
//  ActivityFavoriteViewController.m
//  Douban
//
//  Created by 侯垒 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ActivityFavoriteViewController.h"
#import "FavoriteDataHandle.h"
#import "Activity.h"

#import "ActivityDetailViewController.h"

@interface ActivityFavoriteViewController ()

@end

@implementation ActivityFavoriteViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"活动收藏";
    
    //初始化数据源
    [[FavoriteDataHandle shareInstance] setupActivityDataSource];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kActivityFavoriteCell];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[FavoriteDataHandle shareInstance] countOfActivity];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kActivityFavoriteCell forIndexPath:indexPath];
  
    
    Activity * act = [[FavoriteDataHandle shareInstance] activityForRow:indexPath.row];
    
    cell.textLabel.text = act.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    //进入详情页面
    ActivityDetailViewController * detailVC = [[ActivityDetailViewController alloc] init];
    
    //从数据库获取数据，传值
    detailVC.activity = [[FavoriteDataHandle shareInstance] activityForRow:indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [detailVC release];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        //删除数据
        [[FavoriteDataHandle shareInstance] deleteActivityForRow:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
