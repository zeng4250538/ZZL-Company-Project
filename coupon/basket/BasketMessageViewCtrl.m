//
//  BasketMessageViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/24.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "BasketMessageViewCtrl.h"
#import "CouponInfoTableViewCell.h"
#import "CouponMessageService.h"
#import "BasketMessageCell.h"
#import "CouponDetailViewCtrl.h"
#import "BasketSubMessageSevice.h"
#import "SubBasketViewController.h"
#import "IdShopSevice.h"
#import "BasketContainerViewCtrl.h"
@interface BasketMessageViewCtrl ()

@property(nonatomic,strong)NSArray *dataList;

@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,assign)NSUInteger pageCount;

@end

@implementation BasketMessageViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[BasketMessageCell class] forCellReuseIdentifier:@"cell"];
    
    
    if (self.couponMessageType == CouponMessageTypeBasket) {
        self.navigationItem.title=@"篮子消息";
        
    }
    
    if (self.couponMessageType == CouponMessageTypeCoupon) {
        self.navigationItem.title=@"优惠券消息";
       
        
    }
    
    if (self.couponMessageType == CouponMessageTypeShop) {
        self.navigationItem.title=@"商店消息";
        
        
    }
    
    

    
    
    
    [self loadData];
    
    [self makePullRefresh];
    
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
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
    
    CouponMessageService *service = [CouponMessageService new];
    
    [service requestCouponMessageWithPage:1 per_page:10 isRead:NO sort:@""
            success:^(NSInteger code, NSString *message, id data) {
                
                self.dataList = data;
                
                [self.tableView reloadData];
                
                completion(YES);
                
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        completion(NO);
        
    }];
    
    
    
}


-(void)doLoadNextPage:(NSUInteger)page completion:(void(^)(BOOL ret))completion{
    
    CouponMessageService *service = [CouponMessageService new];
    
    [service requestCouponMessageWithPage:page per_page:10 isRead:NO sort:@""
                                  success:^(NSInteger code, NSString *message, id data) {
                                      
                                      self.dataList = [self.dataList arrayByAddingObjectsFromArray:data];
                                      
                                      [self.tableView reloadData];
                                      
                                      completion(YES);
                                      
                                      
                                  } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                                      
                                      
                                      completion(NO);
                                      
                                  }];
    
    
    
}





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
    return [self.dataList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasketMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    NSDictionary *d = self.dataList[indexPath.row];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    
    cell.data = d;
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    
    [cell addGestureRecognizer:longPress];
    
    
    // Configure the cell...
    
    return cell;
}

-(void)longPressClick:(UILongPressGestureRecognizer *)longPress{

    
        
    if(longPress.state == UIGestureRecognizerStateBegan){
        CGPoint point = [longPress locationInView:self.tableView];
        
        
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        
        
        if(indexPath == nil) return ;
        
        
        UIActionSheet *act = [UIActionSheet bk_actionSheetWithTitle:@"操作"];
        
        [act bk_addButtonWithTitle:@"删除" handler:^{
            
            
            
            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            
            
            NSString *itemId = self.dataList[indexPath.row][@"id"];
            
            
            BasketSubMessageSevice *BSMS = [BasketSubMessageSevice new];
            
            [BSMS removeMessageRequestMessageId:itemId withSuccess:^(id data) {
                
                 [SVProgressHUD dismiss];
                
                NSMutableArray *ary = [self.dataList mutableCopy];
                
                [ary removeObjectAtIndex:indexPath.row];
                
                self.dataList = ary;
                
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
            } withFailure:^(id data) {
                
                [SVProgressHUD showErrorWithStatus:@"删除出错！"];
                
                [SVProgressHUD dismiss];
                
            }];
            
            
            
            // [self.tableView reloadData];
            
            
            
            
            
            
            
            
        }];
        
        [act bk_setDestructiveButtonWithTitle:@"关闭" handler:^{
            
            
            
            
        }];
        
        
        [act showInView:self.view];
        
        //add your code here
        
        
        
    }
    

}

-(void)messageLoadDatamessageId:(NSString *)message withSuccess:(void(^)(id mdata))success{
// NSLog(@"消息详情数据------->%@",message);
    BasketSubMessageSevice *BSMS = [BasketSubMessageSevice new];
    [BSMS basketMessageRequestMessageId:message withSuccess:^(id data) {
        NSLog(@"消息详情数据------->%@",data);
        success(data);
        
    } withFailure:^(id data) {
        
    }];
    
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SubBasketViewController *suvc  = [SubBasketViewController new];
    BasketContainerViewCtrl *bcvc = [BasketContainerViewCtrl new];
    IdShopSevice *ls = [IdShopSevice new];
    
    NSString *messageId = self.dataList[indexPath.row][@"id"];
    NSString *typeString = SafeString(self.dataList[indexPath.row][@"couponMessageType"]);
    int type = [typeString intValue];
    NSLog(@"消息ID%@",messageId);
    
    [self messageLoadDatamessageId:messageId withSuccess:^(id mdata) {
       [ls shopIdRequrestString:mdata[@"couponInstance"][@"coupon"][@"shopId"] withSuccess:^(id data) {
           _dataDic = @{@"name":mdata[@"couponInstance"][@"coupon"][@"name"],@"photoUrl":mdata[@"couponInstance"][@"coupon"][@"photoUrl"],@"shopName":data[@"name"],@"phone":data[@"phone"],@"startTime":mdata[@"couponInstance"][@"couponPromotion"][@"startTime"],@"endTime":mdata[@"couponInstance"][@"couponPromotion"][@"endTime"]};
           
           if (type == 1) {
               suvc.subData = _dataDic;
               suvc.boolView = YES;
               [self.navigationController pushViewController:suvc animated:YES];
               
           }
           else{
           
           [self.navigationController pushViewController:bcvc animated:YES];
           
           };
           
           
       } withFailure:^(id data) {
           
       }];
        
        
    }];
    
    
}

-(void)messageLoadData{
    
    


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
