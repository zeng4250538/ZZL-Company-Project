//
//  HistoryCouponUsageViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "HistoryCouponUsageViewCtrl.h"
#import "CustomerService.h"
#import "HistoryCouponCell.h"
#import "CouponUsageDetailViewCtrl.h"
#import "CommentSubmitViewCtrl.h"



@interface HistoryCouponUsageViewCtrl ()
@property(nonatomic,strong)NSMutableArray *data;

//准备修改的行
@property(nonatomic,assign)NSUInteger updateRow;
@end

@implementation HistoryCouponUsageViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    [self.tableView registerClass:[HistoryCouponCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationItem.title=@"消费历史";
    
    
//    [self loadData];
    
    
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotice:) name: ReviewUpdateNotice object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



-(void)updateNotice:(id)sender{
    
    
    NSLog(@"NSNotificationCenter update %@",sender);
    
    
    NSMutableDictionary *d = [self.data[self.updateRow] mutableCopy];
    
    d[@"reviewId"]=@0;
    
    
    self.data[self.updateRow]=d;
    
    
    [self.tableView reloadData];
    
    
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self loadData];
    
    
    
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
    
    
    CustomerService *service = [CustomerService new];
    
    [service requestCuponHistoryWithPage:1 per_page:10
                         success:^(NSInteger code, NSString *message, id data) {
        
        
        self.data = [data mutableCopy];
        
        [self.tableView reloadData];
        
        completion(YES);
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        completion(NO);
        
        
        
        
    }];
    
    
    
}





#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    cell.data = self.data[indexPath.row];
    
    
    cell.commentTouchBlock = ^(NSDictionary *data){
        
        CommentSubmitViewCtrl *vc = [CommentSubmitViewCtrl new];
        
        vc.data= data;
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
        
    };
    
    
    

    
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CouponUsageDetailViewCtrl *vc = [CouponUsageDetailViewCtrl new];
    
    vc.data =self.data[indexPath.row];
    
    
    self.updateRow =indexPath.row;
    
    
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
