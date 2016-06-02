//
//  CouponListViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CouponListViewCtrl.h"
#import "CouponInfoTableViewCell.h"
#import "CouponService.h"
#import "CouponDetailViewCtrl.h"
#import "ReloadHud.h"
#import "ReminderService.h"
@interface CouponListViewCtrl ()

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,assign)NSUInteger pageCount;

@end

@implementation CouponListViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[CouponInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.title=@"优惠券列表";
    
    
    [self loadData];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    [self makePullRefresh];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)makePullRefresh{
    
    self.pageCount = 1;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self doLoad:^(BOOL ret) {
            
            
            [self.tableView.mj_header endRefreshing];
            
        }];
        
    }];
    
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        
        [self doLoadNextPage:self.pageCount+1 completion:^(BOOL ret) {
            [self.tableView.mj_footer endRefreshing];
            
            if (ret) {
                self.pageCount = self.pageCount+1;
            }
            
            
        }];
        
        
        
    }];
    
    
    
    
    
    
}







-(void)loadData{
    
    
    [ReloadHud showHUDAddedTo:self.tableView reloadBlock:^{
        
        
        [self doLoad:^(BOOL ret){
            
            if (ret) {
                [ReloadHud removeHud:self.tableView animated:YES];
            }else{
                
                [ReloadHud showReloadMode:self.tableView];
            }
            
            
        }];
        
        
    }];
    
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.tableView animated:YES];
        }else{
            
            [ReloadHud showReloadMode:self.tableView];
        }
        
        
    }];
    
    
    
}
-(void)doLoad:(void(^)(BOOL ret))completion{
    
    
    
    CouponService *couponService = [CouponService new];
    
    
    NSString *mallId = [AppShareData instance].mallId;

    
    
    
    [couponService requestRecommendCoupon:mallId page:1 pageCount:10 sort:@"endTime" success:^(NSInteger code, NSString *message, id data) {
        
        
        [ReloadHud removeHud:self.tableView animated:YES];
        
        self.data=data;
        
        [self.tableView reloadData];
        
        completion(YES);
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        
        [ReloadHud showReloadMode:self.tableView];
        
        completion(NO);
        
        
        
        
        
    }];
    
    
    
    
    
    
    
    
    
}


-(void)doLoadNextPage:(NSUInteger)page completion:(void(^)(BOOL ret))completion{
    
    
    
    CouponService *couponService = [CouponService new];
    
    
    NSString *mallId = [AppShareData instance].mallId;
    
    
    
    
    [couponService requestRecommendCoupon:mallId page:1 pageCount:10 sort:@"endTime" success:^(NSInteger code, NSString *message, id data) {
        
        
        
        self.data=[self.data arrayByAddingObjectsFromArray:data];
        
        [self.tableView reloadData];
        
        completion(YES);
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        
        
        completion(NO);
        
        
        
        
        
    }];
    
    
    
    
    
    
    
    
    
}






-(void)doLoad{
    
    
    
    CouponService *couponService = [CouponService new];
    
    
    
    
    
    
    
    
    
    
    NSString *mallId = [AppShareData instance].mallId;
    
    
    
    [couponService requestRecommendCoupon:mallId page:1 pageCount:10 sort:@"endTime" success:^(NSInteger code, NSString *message, id data) {
        
        
        [ReloadHud removeHud:self.tableView animated:YES];
        
        self.data=data;
        
        [self.tableView reloadData];
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        
        [ReloadHud showReloadMode:self.tableView];
        
        
        
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}





//-(void)loadData{
//    
//    
//    CouponService *service = [CouponService new];
//    
//    
//    [service queryPortalCoupon:nil success:
//     ^(int code, NSString *message, id data) {
//         
//         if (code==0) {
//            
//             self.data = data;
//             
//             [self.tableView reloadData];
//            
//         }
//        
//    } failure:
//     ^(int code, BOOL retry, NSString *message, id data) {
//        
//         
//    }];
//    
//    //service qu
//    
//    
//    
//    
//    
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [CouponInfoTableViewCell height];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    
    
    
    
    
    
    NSMutableDictionary *d = [self.data[indexPath.row] mutableCopy];
    
    cell.data = d;
    
    
    NSString *isRemider  = SafeString(d[@"setReminder"]);
    
    if ([isRemider isEqualToString:@"1"]) {
        
        cell.couponActionType = CouponTypeUnLimited;
    }else{
        
        cell.couponActionType = CouponTypeLimited;
        
    }

    
    
    cell.doActionBlock = ^(id sender){
        
        
        NSString *isReminder = SafeString(d[@"setReminder"]);
        
        if ([ isReminder isEqualToString:@"0"]) {
            
            NSString *promotionId = SafeString(d[@"couponPromotionId"]);
            ReminderService *service = [ReminderService new];
            [service addReminder:promotionId success:^(NSInteger code, NSString *message, id data) {
                UIButton *button = (UIButton*)sender;
                [button setTitle:@"取消提醒" forState:UIControlStateNormal];
                d[@"setReminder"]=@1;
                NSString * reminderId = data[@"reminderId"];
                
                d[@"reminderId"]=SafeString(reminderId);
                [SVProgressHUD showSuccessWithStatus:@"提醒成功"];
                
            } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                
                
                [SVProgressHUD showErrorWithStatus:@"提醒失败"];
                
                
            }];
            
            
            
        }else{
            
            
            
            NSString *reminderId = SafeString(d[@"reminderId"]);
            
            
            ReminderService *service = [ReminderService new];
            
            
            [service deleteReminder:reminderId success:^(NSInteger code, NSString *message, id data) {
                
                
                UIButton *button = (UIButton*)sender;
                
                [button setTitle:@"提醒" forState:UIControlStateNormal];
                
                d[@"setReminder"]=@0;
                
                
                [SVProgressHUD showSuccessWithStatus:@"取消提醒成功"];
                
                
            } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                
                
                [SVProgressHUD showErrorWithStatus:@"取消提醒失败"];
                
                
            }];
            
            
            
            
            
            
            
            
        }
        
        
    };
    
    

    
    [cell updateData];
    
    
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *d = self.data[indexPath.row];
    
    CouponDetailViewCtrl *vc = [CouponDetailViewCtrl new];
    
    vc.data = d;
    
    [self.navigationController pushViewController:vc animated:YES];
  
    

    
    
    
    
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
