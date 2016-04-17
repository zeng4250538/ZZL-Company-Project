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

@interface BasketMessageViewCtrl ()

@property(nonatomic,strong)NSArray *dataList;

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
    
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    
    
    
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
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
