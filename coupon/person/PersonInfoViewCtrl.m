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
#import "AppShareData.h"
#import "OrderContainerViewCtrl.h"
#import "LoginViewCtrl.h"
#import "MyInformationViewController.h"
#import "MyInformationSevice.h"
#import "MyCommentViewCtrl.h"
#import "CustomerService.h"
#import "HistoryCouponUsageViewCtrl.h"
#import "PersonDetailInfoViewCtrl.h"
#import "CouponUsageDetailViewCtrl.h"



#define NAVBAR_CHANGE_POINT 50


@interface PersonInfoViewCtrl ()

@property(nonatomic,strong)NSDictionary *myInformationDictionary;

@property(nonatomic,strong) PersonDetailInfoViewCtrl *vc;

@property(nonatomic,strong) UIImageView *header;

@property(nonatomic,strong) UIImageView *myInfromation;

@property(nonatomic,strong) UILabel *myInformationTitleLabel;

@property(nonatomic,strong) UIButton *exitButton;

@end

@implementation PersonInfoViewCtrl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //消费完跳转的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushViewView) name:@"pushView" object:nil];
    
    _vc = [PersonDetailInfoViewCtrl new];
    
    self.tableView = [GUIHelper makeTableView:self.view delegate:self];
  
    
    
    self.view.backgroundColor = [GUIConfig mainBackgroundColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    {
    
        CGFloat rate = 420.0f/750.0f;
        
        
        _header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_WIDTH*rate )];
        
        _header.image = [UIImage imageNamed:@"personbg.png"];
        
        self.tableView.tableHeaderView = _header;
        [self.tableView.tableHeaderView setUserInteractionEnabled:YES];
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
        
        
        [self makeHeader:_header];
        
        [self notification];
        
        
        
        __weak typeof(self) weakSelf = self;
        _vc.inforMationRefreshBlock = ^(id data){
//            if (weakSelf.refreshBlock) {
//                weakSelf.refreshBlock();
//            }
            CustomerService *service = [CustomerService new];
            
            
            NSString *customerId = [AppShareData instance].customId;
            
            
            [service requestCustomer:customerId success:^(NSInteger code, NSString *message, id data) {
                
                NSLog(@"data = %@ ",data);
                
                
                NSURL *url =SafeUrl(data[@"photoUrl"]);
                
                
                [weakSelf.myInfromation sd_setImageWithURL:url placeholderImage:nil options:SDWebImageCacheMemoryOnly];
                
                
                
                weakSelf.myInformationTitleLabel.text= [NSString stringWithFormat:@"%@",SafeString(data[@"name"])];
                
            } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                
            }];

        };
        
    }
    
    {
    
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"setting_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
            
            SettingViewCtrl *set = [SettingViewCtrl new];
            set.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:set animated:YES];
            
        }];
        
        
        
        
        self.navigationItem.leftBarButtonItem=leftBarButton;
        
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"message_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
            
            SettingMessageTypeViewCtrl *vc = [SettingMessageTypeViewCtrl new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        
        self.navigationItem.rightBarButtonItem=rightBarButton;
        
    }
    
    
    //  [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    [self makeFooterView];
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark ----------- 接收通知
-(void)notification{

    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updatePageData) name:@"updatePageView" object:nil];

}

-(void)makeHeader:(UIImageView*)header{

    
    
    /**
     *  头像显示（个人信息入口）
     */
    _myInfromation = [[UIImageView alloc]init];
    _myInfromation.backgroundColor = [UIColor whiteColor];
    _myInfromation.layer.masksToBounds = YES;
    _myInfromation.layer.cornerRadius = 65/2;
    [header addSubview:_myInfromation];
    /**
     *  开启交互
     */
    [_myInfromation setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_myInfromation addGestureRecognizer:tap];
    [_myInfromation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@65);
        make.height.equalTo(@65);
        make.left.equalTo(header).offset(20);
        make.bottom.equalTo(header).offset(-20);
    }];

    
    _myInformationTitleLabel = [UILabel new];
    _myInformationTitleLabel.font = [UIFont systemFontOfSize:15];
    _myInformationTitleLabel.textColor = [UIColor whiteColor];
    [header addSubview:_myInformationTitleLabel];
    [_myInformationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@110);
        make.height.equalTo(@65);
        make.left.equalTo(header).offset(95);
        make.bottom.equalTo(header).offset(-20);
        
    }];
    
    
    if (![AppShareData instance].isLogin) {
        _myInformationTitleLabel.text=@"未登录";
        _myInfromation.backgroundColor = [UIColor whiteColor];
        return ;
    }
    
    else{
    CustomerService *service = [CustomerService new];
    
    
    NSString *customerId = [AppShareData instance].customId;
    
    
    [service requestCustomer:customerId success:^(NSInteger code, NSString *message, id data) {
        
        NSLog(@"data = %@ ",data);
        
        
        NSURL *url =SafeUrl(data[@"photoUrl"]);
        
        
        [_myInfromation sd_setImageWithURL:url placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        
        
        
        _myInformationTitleLabel.text= [NSString stringWithFormat:@"%@",SafeString(data[@"name"])];
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
    }];
    
    
    
        
    }
    
    
}
#pragma mark ---------- 通知的方法
-(void)updatePageData{
    
    CustomerService *service = [CustomerService new];
    
    
    NSString *customerId = [AppShareData instance].customId;
    
    
    [service requestCustomer:customerId success:^(NSInteger code, NSString *message, id data) {
        
        NSLog(@"data = %@ ",data);
        
        
        NSURL *url =SafeUrl(data[@"photoUrl"]);
        
        
        [_myInfromation sd_setImageWithURL:url placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        
        
        
        _myInformationTitleLabel.text= [NSString stringWithFormat:@"%@",SafeString(data[@"name"])];
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
    }];
    
    
    [self makeFooterView];
    
    
}
#pragma mark ---------- 头像的点击方法
-(void)tapClick{

    
    
    
    if (![[AppShareData instance] isLogin]) {
        
        SafePostMessage(NoLoginNotice, self);
        return ;
        
        
    }
    
    
    
    
    
    _vc.hidesBottomBarWhenPushed = YES;
    
    
    
    
    [self.navigationController pushViewController:_vc animated:YES];


}


-(void)makeFooterView{
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    footer.backgroundColor = [GUIConfig mainBackgroundColor];
    
    self.tableView.backgroundColor = [GUIConfig mainBackgroundColor];
    
    
    
    _exitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [footer addSubview:_exitButton];
    
    [_exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(footer).offset(30);
        make.right.equalTo(footer).offset(-30);
        make.centerY.equalTo(footer);
        make.height.equalTo(@40);
        
        
    }];
    
    
    
    
    _exitButton.backgroundColor = [GUIConfig mainColor];
    
    [_exitButton setTitle:@"退出" forState:UIControlStateNormal];
    
    [_exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.tableView.tableFooterView = footer;
    
    
    [_exitButton bk_addEventHandler:^(id sender) {
        
        
        UIAlertView *av = [UIAlertView bk_alertViewWithTitle:@"注意" message:@"是否退出系统？"];
        
        
        
        
        
        [av bk_addButtonWithTitle:@"确认" handler:^{
            
            [[AppShareData instance] loginOut];
            
            LoginViewCtrl *vc = [LoginViewCtrl new];
            
            
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            [self presentViewController:nav animated:YES completion:^{
                
            }];
            
            
            
            
            
            
            
//            vc.loginEndBlock = ^(BOOL ret){
//                
//                [self.navigationController popViewControllerAnimated:YES];
//                
//            };
//            
//            [self.navigationController pushViewController:vc animated:YES];
//            
        }];
        
        [av bk_addButtonWithTitle:@"取消" handler:^{
            
        }];
        
        [av show];
        
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([[AppShareData instance] isLogin]) {
        
        _exitButton.hidden = NO;
        
    }else{
        
        _exitButton.hidden = YES;
        
    }
    
    
    
    
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

#pragma mark -------------- 是否登陆判断
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
   
}

- (void)exitPageData{

    _myInfromation.image = [UIImage imageNamed:@""];
    _myInformationTitleLabel.text = @"未登录";

}

-(void)pushViewView{

    HistoryCouponUsageViewCtrl *vc = [HistoryCouponUsageViewCtrl new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"pushView" object:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//     CouponUsageDetailViewCtrl *vc = [CouponUsageDetailViewCtrl new];
    
//点击正路界面的关闭后来的刷新通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exitPageData) name:@"exitPageView" object:nil];

    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.navigationController.navigationBar.translucent = YES;

    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self makeFooterView];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    //销毁通知
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
            
            if (![AppShareData instance].isLogin) {
                
                SafePostMessage(NoLoginNotice, @"");
                
                return ;
                
            }
            
            
            MySubViewCtrl *vc = [MySubViewCtrl new];
            
            vc.hidesBottomBarWhenPushed = YES;
              
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        if (indexPath.row==1) {
            
            if (![AppShareData instance].isLogin) {
                
                SafePostMessage(NoLoginNotice, @"");
                
                return ;
                
            }
            
            
            
            MyCommentViewCtrl *vc = [MyCommentViewCtrl new];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
            
            
            
        }
    }
    
    if ([indexPath section]==1) {
        
        
        if (![AppShareData instance].isLogin) {
            
            SafePostMessage(NoLoginNotice, @"");
            
            return ;
            
        }
        
        
        
        MyRemindViewCtrl *vc = [MyRemindViewCtrl new];
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
    if (indexPath.section==2) {
        
        if (indexPath.row==0) {
            
            
            if (![AppShareData instance].isLogin) {
                
                SafePostMessage(NoLoginNotice, @"");
                
                return ;
                
            }
            
            
            
            BasketContainerViewCtrl *vc = [BasketContainerViewCtrl new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }
        
        if (indexPath.row==1) {
            
            
            if (![AppShareData instance].isLogin) {
                
                SafePostMessage(NoLoginNotice, @"");
                
                return ;
                
            }
            
            
            HistoryCouponUsageViewCtrl *vc = [HistoryCouponUsageViewCtrl new];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
        
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
