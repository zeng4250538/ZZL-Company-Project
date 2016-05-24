//
//  MySubViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/13.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "MySubViewCtrl.h"
#import "SubTableViewCell.h"
#import "ShopInfoTableViewCell.h"
#import "ShopService.h"
#import "FavShopCell.h"
#import "ShopInfoViewCtrl.h"

@interface MySubViewCtrl ()

@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)ShopInfoViewCtrl *vcs;

@end

@implementation MySubViewCtrl

-(void)viewWillDisappear:(BOOL)animated{

    [SVProgressHUD dismiss];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vcs = [ShopInfoViewCtrl new];
    
    self.tableView = [GUIHelper makeTableView:self.view delegate:self];
    
    
    [self.tableView registerClass:[FavShopCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.title=@"我的订阅";
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
     
    
    [self loadData];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;

    [self loadData];
    [_tableView reloadData];
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
    
    ShopService *service = [ShopService new];
    
    [service requestMyFavList:^(NSInteger code, NSString *message, id data) {
        
        
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
    
    return [ShopInfoTableViewCell height];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    // Return the number of rows in the section.
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    FavShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    NSDictionary *data = self.dataList[indexPath.row];
    
    
    
    cell.data = data;
    
    NSString *shopId = SafeString(data[@"shopId"]);
    
    
    
    cell.unFavBlock = ^(){
        
        
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        
        ShopService *service = [ShopService new];
        
        [service doUnFav:shopId success:^(NSInteger code, NSString *message, id data) {
            
            
            [SVProgressHUD dismiss];
            
            
            NSMutableArray *ary = [self.dataList mutableCopy];
            
            
            
            [ary removeObjectAtIndex:indexPath.row];
            
            self.dataList = ary;
            
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [self.tableView reloadData];
            
            
            
            
            
            
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            [SVProgressHUD showErrorWithStatus:@"取消订阅失败"];
            
        }];
        
        
        
        
        
    };
    
    
    
    [cell updateData];
    // Configure the cell...
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    NSDictionary *d = self.dataList[indexPath.row];
    
    _vcs.shopMode = ShopViewModeNetwork;
    _vcs.shopId  = SafeString(d[@"shopId"]);
    
    _vcs.data = d;
    
    
    [self.navigationController pushViewController:_vcs animated:YES];
    
    
    
    
    
    
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
