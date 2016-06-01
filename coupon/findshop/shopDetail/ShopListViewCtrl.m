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
@property(nonatomic,assign)NSUInteger pageCount;


@end

@implementation ShopListViewCtrl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadData];
    
    
    [self.tableView registerClass:[ShopInfoTableViewCell class] forCellReuseIdentifier:@"cell"];

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
    
    
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        
        
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
    
    
    
    ShopService *service = [ShopService new];
    
     
    
    
    NSString *mallId = [AppShareData instance].mallId;
    
    
    
    
    if (self.shopQueryType == ShopQueryTypeRecommend) {
        
        
        [service requestRecommendShop:mallId page:1 pageCount:10 success:^(NSInteger code, NSString *message, id data) {
            
            self.shopList = data;
            
            
            [self.tableView reloadData];
            
            completion(YES);
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            
            completion(NO);
            
        }];

        
    }
  
    if (self.shopQueryType == ShopQueryTypeNearBy) {
        
        
        
        [service requestNearbyShop:mallId page:1 per_page:10 success:^(NSInteger code, NSString *message, id data) {
            self.shopList = data;
            
            
            [self.tableView reloadData];
            
            completion(YES);

        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            completion(NO);
            
        }];
        
        
        
          
    }
    
    
  
    
    
}



-(void)doLoadNextPage:(NSUInteger)page completion:(void (^)(BOOL))completion{
    
    
    
    ShopService *service = [ShopService new];
    
    
    
    
    NSString *mallId = [AppShareData instance].mallId;
    
    
    
    
    if (self.shopQueryType == ShopQueryTypeRecommend) {
        
        
        [service requestRecommendShop:mallId page:page pageCount:10 success:^(NSInteger code, NSString *message, id data) {
            
            
            
            self.shopList = [self.shopList arrayByAddingObjectsFromArray:data];
            
            
              
            [self.tableView reloadData];
            
            completion(YES);
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            
            completion(NO);
            
        }];
        
        
    }
    
    if (self.shopQueryType == ShopQueryTypeNearBy) {
        
        
        
        [service requestNearbyShop:mallId page:page per_page:10 success:^(NSInteger code, NSString *message, id data) {
            
            
            self.shopList = [self.shopList arrayByAddingObjectsFromArray:data];
            
            
            
            
            [self.tableView reloadData];
            
            completion(YES);
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            completion(NO);
            
        }];
        
        
        
        
    }

    
    

    
    
}








-(void)doLoad{
    
    ShopService *service = [ShopService new];
    
    
    NSString *mallId = [AppShareData instance].mallId;
    
    [service requestRecommendShop:mallId page:1 pageCount:10 success:^(NSInteger code, NSString *message, id data) {
       
        self.shopList = data;
        
        [ReloadHud removeHud:self.tableView animated:YES];
        
        [self.tableView reloadData];
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        [ReloadHud showReloadMode:self.tableView];
        
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
    
    vc.shopId = SafeString(data[@"id"]);
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
