//
//  PersonInfoViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/12.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "PersonInfoViewCtrl.h"
#import "CartViewCtrl.h"
#import "MySubViewCtrl.h"
#import "ShopCommentViewCtrl.h"
#import "MyRemindViewCtrl.h"
#import "BasketContainerViewCtrl.h"
#import "FeedBackViewCtrl.h"
#import "SettingViewCtrl.h"
#import "SettingMessageTypeViewCtrl.h"
#import "CouponDrawBackListViewCtrl.h"
#import "HistoryOfConsumptionTableViewController.h"

#import "OrderContainerViewCtrl.h"
#import "LoginViewCtrl.h"




#define NAVBAR_CHANGE_POINT 50


@interface PersonInfoViewCtrl ()

@end

@implementation PersonInfoViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    CGFloat rate = 420.0f/750.0f;
    
    
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_WIDTH*rate )];
    
    header.image = [UIImage imageNamed:@"personbg.png"];
    
    self.tableView.tableHeaderView = header;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"setting_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        SettingViewCtrl *set = [SettingViewCtrl new];
        
        set.hidesBottomBarWhenPushed = YES;
        
        
        [self.navigationController pushViewController:set animated:YES];
        
        
    }];
    
    
    
    
    self.navigationItem.leftBarButtonItem=leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"message_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        SettingMessageTypeViewCtrl *vc = [SettingMessageTypeViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    self.navigationItem.rightBarButtonItem=rightBarButton;
    
    
    //  [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    [self makeFooterView];
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




-(void)makeFooterView{
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    footer.backgroundColor = [GUIConfig mainBackgroundColor];
    
    self.tableView.backgroundColor = [GUIConfig mainBackgroundColor];
    
    
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [footer addSubview:exitButton];
    
    [exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(footer).offset(30);
        make.right.equalTo(footer).offset(-30);
        make.centerY.equalTo(footer);
        make.height.equalTo(@40);
        
        
    }];
    
    exitButton.backgroundColor = [GUIConfig mainColor];
    
    [exitButton setTitle:@"退出" forState:UIControlStateNormal];
    
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.tableView.tableFooterView = footer;
    
    
    [exitButton bk_addEventHandler:^(id sender) {
        
        
        UIAlertView *av = [UIAlertView bk_alertViewWithTitle:@"注意" message:@"是否退出系统？"];
        
        [av bk_addButtonWithTitle:@"确认" handler:^{
            
            [[AppShareData instance] loginOut];
            
            
            LoginViewCtrl *vc = [LoginViewCtrl new];
            
            vc.loginEndBlock = ^(BOOL ret){
                
                
                [self.navigationController popViewControllerAnimated:YES];
                
            };
            
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        
        [av bk_addButtonWithTitle:@"取消" handler:^{
            
        }];
        
        [av show];
        
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [GUIConfig mainColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (![[AppShareData instance] isLogin]) {
        
        
        LoginViewCtrl *vc = [LoginViewCtrl new];
        
        vc.loginEndBlock = ^(BOOL ret){
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        };
        
        [self.navigationController pushViewController:vc animated:YES];
        
//        return ;
        
    }
    
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    
    
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
    
    self.automaticallyAdjustsScrollViewInsets=YES;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    // Return the number of rows in the section.
    if (section==0) {
        return 2;
    }
    
    if (section==1) {
        return 1;
    }
    
    
    if (section==2) {
        return 2;
    }
    if (section==3) {
        return 1;
    }
    
    return 0;
    
    //  return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if ([indexPath section]==0) {
        
        
        if ([indexPath row]==0) {
            cell.textLabel.text=@"我的订阅";
            
        }
        
        
        if ([indexPath row]==1) {
            cell.textLabel.text=@"我的评价";
            
        }
        
        
    }
    
    if ([indexPath section]==1) {
        
        if ([indexPath row]==0) {
            cell.textLabel.text=@"我的提醒";
            
        }
        
        
    }
    
    
    if ([indexPath section]==2) {
        
        
        
        if ([indexPath row]==0) {
            cell.textLabel.text=@"优惠篮子";
            
            
        }
        
        if ([indexPath row]==1) {
            cell.textLabel.text=@"消费历史";
            
            
        }
        
        
//        if ([indexPath row]==2) {
//            cell.textLabel.text=@"我的退款";
//            
//            
//        }
        
        
        
    }
    
    
    if ([indexPath section]==3) {
        
        if ([indexPath row]==0) {
            cell.textLabel.text=@"意见反馈";
            
            
        }
        
        
        
        
    }
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if ([indexPath section]==0) {
        
        if (indexPath.row==0) {
            MySubViewCtrl *vc = [MySubViewCtrl new];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        if (indexPath.row==1) {
            
            
            ShopCommentViewCtrl *vc = [ShopCommentViewCtrl new];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
            
            
            
        }
    }
    
    if ([indexPath section]==1) {
        
        
        MyRemindViewCtrl *vc = [MyRemindViewCtrl new];
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
    if (indexPath.section==2) {
        
        if (indexPath.row==0) {
            
            
            BasketContainerViewCtrl *vc = [BasketContainerViewCtrl new];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }
        
        if (indexPath.row==1) {
            
            
            HistoryOfConsumptionTableViewController *vc = [HistoryOfConsumptionTableViewController new];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }
        
        
        
        
//        if (indexPath.row==2) {
//            
//            CouponDrawBackListViewCtrl *vc =[CouponDrawBackListViewCtrl new];
//            
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//            
//            
//            
//            
//            
//            
//        }
        
    }
    
    
    if (indexPath.section==3) {
        
        
        FeedBackViewCtrl *vc = [FeedBackViewCtrl new];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
    
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
