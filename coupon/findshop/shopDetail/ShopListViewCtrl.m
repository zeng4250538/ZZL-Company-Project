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
    
    
    NSString *mallId = [AppShareData instance].mallId;
    
    [service requestRecommendShop:mallId page:1 pageCount:3 success:^(NSInteger code, NSString *message, id data) {
       
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


@end
