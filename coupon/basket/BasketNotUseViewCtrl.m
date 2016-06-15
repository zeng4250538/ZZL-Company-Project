//
//  BasketNoUseViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/30.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "BasketNotUseViewCtrl.h"
#import "CouponInfoTableViewCell.h"
#import "CouponDetailViewCtrl.h"
#import "CouponService.h"
#import "CouponPaymentDetailViewCtrl.h"
#import "CouponDrawbackViewCtrl.h"
#import "BasketService.h"
#import "BasketNotUseTableViewCell.h"
#import "SubBasketViewController.h"

#import "AppShareData.h"
#import "UseCouponViewCtrl.h"

@interface BasketNotUseViewCtrl ()
@property(nonatomic,assign)NSUInteger pageCount;


@end

@implementation BasketNotUseViewCtrl

- (void)viewDidLoad {
    
    
    
    
    [super viewDidLoad];
    
    
    self.tableView = [GUIHelper makeTableView:self.view delegate:self];
    
    [self.tableView registerClass:[BasketNotUseTableViewCell class] forCellReuseIdentifier:@"cell"];
    
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





-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
    
    
}

-(void)loadData{
    
    
    [ReloadHud showHUDAddedTo:self.view reloadBlock:^{
        
        
        [self doLoad:^(BOOL ret){
            
            if (ret) {
                [ReloadHud removeHud:self.view animated:YES];
            }else{
                
                [ReloadHud showReloadMode:self.view];
            }
            
            
        }];
        
        
    }];
    
    
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.view animated:YES];
        }else{
            
            [ReloadHud showReloadMode:self.view];
        }
        
        
    }];
    
    
    
}


-(void)doLoad:(void(^)(BOOL ret))completion{
    
    
    BasketService *service = [BasketService new];
    
    
    
    [service requestNotUseStatus:@"未消费" page:1 per_page:10 success:^(NSInteger code, NSString *message, id data) {
        
        self.dataList = data;
        
        
        [self.tableView reloadData];
        
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        
        if (code>=400 && code<500) {
            
            
            
            [SVProgressHUD showErrorWithStatus:@"没有数据"];
        
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"后台数据错误"];
            
            
        }
        
        completion(NO);
        
    }];
    
    
    
    
    
    
    
}


-(void)doLoadNextPage:(NSUInteger)page completion:(void(^)(BOOL ret))completion{
    
    
    BasketService *service = [BasketService new];
    
    
    [service requestNotUseStatus:@"未消费" page:page per_page:10 success:^(NSInteger code, NSString *message, id data) {
        
      //  self.dataList = data;
        
        self.dataList = [self.dataList arrayByAddingObjectsFromArray:data];
        
        
        [self.tableView reloadData];
        
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        
        if (code>=400 && code<500) {
            
            
            
            [SVProgressHUD showErrorWithStatus:@"没有数据"];
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"后台数据错误"];
            
            
        }
        
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
    
    
    
    BasketNotUseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
    
    longPressed.minimumPressDuration = 1.0;
    
    [cell.contentView addGestureRecognizer:longPressed];
  
    cell.data  = self.dataList[indexPath.row];
    
    [cell updateData];
    
   // [cell updateData:self.dataList[[indexPath row]]];
    
    
    
   // cell.textLabel.text=@"未使用";
    
    
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
//    UseCouponViewCtrl *vc = [UseCouponViewCtrl new];
//    
    NSDictionary *d = self.dataList[[indexPath row]];
    
    SubBasketViewController *suvc  = [SubBasketViewController new];
    suvc.boolView = YES;
    suvc.subData = d;
    [self.navigationController pushViewController:suvc animated:YES];
    
    
    
    
    
}


#pragma mark - 长按删除

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture{
    

    
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:self.tableView];
        
        
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        
        
        if(indexPath == nil) return ;
        
        
        UIActionSheet *act = [UIActionSheet bk_actionSheetWithTitle:@"操作"];
        
        [act bk_addButtonWithTitle:@"删除" handler:^{
            
            BasketService *service =[BasketService new];
            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            
            
            NSString *itemId = self.dataList[indexPath.row][@"id"];
            
            [service requestDeleteBasket:itemId success:^(NSInteger code, NSString *message, id data) {
                
                
                [SVProgressHUD dismiss];
                
                NSMutableArray *ary = [self.dataList mutableCopy];
                
                [ary removeObjectAtIndex:indexPath.row];
                
                self.dataList = ary;
                
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshFindShopTableView" object:nil];
                
            } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                
                
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
