//
//  ShopListViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopListViewCtrl.h"
#import "ShopInfoTableViewCell.h"
#import "ShopService.h"
#import "ShopInfoViewCtrl.h"
#import "ReloadHud.h"



@interface ShopListViewCtrl ()

@property(nonatomic,strong)NSArray *shopList;

@end

@implementation ShopListViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self loadData];
    
    self.navigationItem.title=@"商家列表";
    [self.tableView registerClass:[ShopInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)doLoad{
    
    
    ShopService *service = [ShopService new];
    
    
    
    [service requestRecommendShop:@"123456" customerId:15818865756 page:2 pageCount:10 success:^(NSInteger code, NSString *message, id data) {
        
        
        
        self.shopList = data;
        
        [ReloadHud removeHud:self.tableView animated:YES];
        
        [self.tableView reloadData];
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        [ReloadHud showReloadMode:self.tableView];
        
        
    }];
    
    
    
    
    
    
}


-(void)loadData{
    
    
    
    
    [ReloadHud showHUDAddedTo:self.tableView reloadBlock:^{
        
        
        
        [self doLoad];
        
        
        
        
        
    }];
    
    
    [self doLoad];
    
    
    
    
    
    
    
    
    
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
    return [self.shopList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    cell.data = self.shopList[[indexPath row]];
    
    [cell updateData];
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *data = self.shopList[indexPath.row];
    
    ShopInfoViewCtrl *vc = [ShopInfoViewCtrl new];
    
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
