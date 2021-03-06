//
//  MyRemindViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/20.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "MyRemindViewCtrl.h"

#import "CouponService.h"
#import "CouponDetailViewCtrl.h"
#import "CouponInfoTableViewCell.h"

#import "ReminderService.h"
#import "CouponDetailViewCtrl.h"
#import "ReminderService.h"

@interface MyRemindViewCtrl ()

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,assign)NSUInteger pageCount;

@end

@implementation MyRemindViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[CouponInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationItem.title=@"我的提醒";
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    [self loadData];
    
    
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
    
    
    [ReloadHud showHUDAddedTo:self.navigationController.view reloadBlock:^{
        
        
        [self doLoad:^(BOOL ret){
            
            if (ret) {
                [ReloadHud removeHud:self.navigationController.view animated:YES];
            }else{
                
                [ReloadHud showReloadMode:self.navigationController.view];
            }
            
            
        }];
        
        
    }];
    
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.navigationController.view animated:YES];
        }else{
            
            [ReloadHud showReloadMode:self.navigationController.view];
        }
        
        
    }];
    
    
    
}
-(void)doLoad:(void(^)(BOOL ret))completion{
    
    
    ReminderService *service = [ReminderService new];
    
    
    [service requestReminder:1 per_page:10 success:^(NSInteger code, NSString *message, id data) {
        
        self.data = data;
        
        [self.tableView reloadData];
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        completion(NO);

        
    }];
    
    
    
    
    
    
}



-(void)doLoadNextPage:(NSUInteger)page completion:(void(^)(BOOL ret))completion{
    
    
    ReminderService *service = [ReminderService new];
    
    
    [service requestReminder:page per_page:10 success:^(NSInteger code, NSString *message, id data) {
        
        self.data = [self.data arrayByAddingObjectsFromArray:data];
        
        [self.tableView reloadData];
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        completion(NO);
        
        
    }];
    
    
    
    
    
    
}








//-(void)loadData{
//    
//    
//    CouponService *service = [CouponService new];
//    
//    
//    [service queryRemindCoupon:nil success:
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
//     } failure:
//     ^(int code, BOOL retry, NSString *message, id data) {
//         
//         
//     }];
//    
//    //service qu
//    
//    
//    
//    
//    
//    
//}
//
//



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
    
    
    
    
    
    NSDictionary *d = self.data[indexPath.row];
    
//    NSDictionary *promotion = d;
    
    NSDictionary *couponData =@{@"name":d[@"coupon"][@"name"] ,@"shopName":d[@"shop"][@"name"],@"smallPhotoUrl":d[@"coupon"][@"photoUrl"],@"startTime":d[@"startTime"],@"id":d[@"coupon"][@"id"]};
    
    
    cell.couponActionType = CouponTypeUnLimited;
    
    cell.data =couponData;
    
    cell.remindBool = YES;
    cell.doActionBlock = ^(id sender){
    
        ReminderService *service = [ReminderService new];
        
        
        [service deleteReminder:d[@"reminderId"] success:^(NSInteger code, NSString *message, id data) {
            
            
            UIButton *button = (UIButton*)sender;
            
            [button setTitle:@"提醒" forState:UIControlStateNormal];
            
//            d[@"setReminder"]=@0;
            
            NSMutableArray *ary = [self.data mutableCopy];
            
            [ary removeObjectAtIndex:indexPath.row];
            
            self.data = ary;
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshFindShopTableView" object:nil];
            
            [SVProgressHUD showSuccessWithStatus:@"取消提醒成功"];
            
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            
            [SVProgressHUD showErrorWithStatus:@"取消提醒失败"];
            
            
        }];
    
    };
    
 //   cell.couponActionType = CouponTypeUnLimited;
    
    
    [cell updateData];
    
    //cell.textLabel.text=@"我的提醒";
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CouponDetailViewCtrl *CDVC = [CouponDetailViewCtrl new];
    NSDictionary *d = self.data[indexPath.row];
    
    
    NSDictionary *couponData =@{@"name":d[@"coupon"][@"name"] ,@"shopName":d[@"shop"][@"name"],@"smallPhotoUrl":d[@"coupon"][@"photoUrl"],@"startTime":d[@"startTime"],@"shopPhone":d[@"shop"][@"phone"],@"longitude":d[@"address"][@"longitude"],@"latitude":d[@"address"][@"latitude"],@"validEndDate":d[@"coupon"][@"validEndDate"],@"id":d[@"couponPromotion"][@"id"]};
    
    CDVC.data = couponData;
    
    [self.navigationController pushViewController:CDVC animated:YES];
    


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
