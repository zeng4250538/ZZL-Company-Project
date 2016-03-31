//
//  PortalShopViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopPortalViewCtrl.h"
#import "ShopInfoTableViewCell.h"
#import "ShopInfoViewCtrl.h"
#import "KeyWordSearchViewCtrl.h"
#import "SelectMallTableCtrl.h"
#import "SelectCityTableViewCtrl.h"
#import "ShopListViewCtrl.h"
#import "MallMapViewCtrl.h"
#import "ShopService.h"
#import "CouponInfoTableViewCell.h"
#import "CouponListViewCtrl.h"
#import "SelectMallPopViewCtrl.h"
#import "CouponDetailViewCtrl.h"
#import "CouponService.h"
#import "ReloadHud.h"
#import "Shop.h"
#import "Coupon.h"
#import "MallService.h"


@interface ShopPortalViewCtrl ()

@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)NSArray *hotShopData;
@property(nonatomic,strong)NSArray *couponData;
@property(nonatomic,strong)NSArray *hotBrandData;
@property(nonatomic,strong)NSArray *otherData;
@property(nonatomic,strong)NSDictionary *portalData;
@property(nonatomic,assign)BOOL bools;
@property(nonatomic,strong)SelectMallPopViewCtrl *selectTitle;
@property(nonatomic,strong)NSString *cityString;

@end

@implementation ShopPortalViewCtrl


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self titleItenLabel];
    
    self.navigationItem.title=@"找商家";
    
    [self.tableView registerClass:[ShopInfoTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    [self.tableView registerClass:[CouponInfoTableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    [self makeSearchBar];
 
    [self loadData];
    
    self.selectTitle = [[SelectMallPopViewCtrl alloc]init];
//    [self makeBarItem];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self doLoad:^(BOOL ret) {
            
            
            [self.tableView.mj_header endRefreshing];
            
        }];
        
    }];
    
    [self makeBarItem];
    
}

-(void)titleItenLabel{

    
//    [self.mallArray addObserver:self forKeyPath:@"mallArray" options:1 context:nil];
//
//
//#pragma mark ------ 周边商城网络请求
//    MallService *services = [[MallService alloc] init];
//    [services queryMallByNear:@"广州" lon:113.333655 lat:23.138651 success:^(NSInteger code, NSString *message, id data) {
//        
//        self.mallArray = data;
//        
//        NSLog(@"%@",self.mallArray[0][@"name"]);
//        
//        
//        
//    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
//        
//    }];



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
    
    CouponService *couponService = [CouponService new];
    
    
#pragma mark ---- 即时优惠网络请求
    [couponService requestRecommendCoupon:@"2" page:1 pageCount:10 sort:@"endTime" success:^(NSInteger code, NSString *message, id data) {
        
        
        
        self.couponData=data;
        
        [self.tableView reloadData];
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
       
        completion(NO);
       
        
    }];

    
#pragma mark ---- 优选品牌网络请求
    [service requestRecommendShop:@"2" customerId:15818865756 page:1 pageCount:13 success:^(NSInteger code, NSString *message, id data) {
       
        self.hotShopData = data;
        
        [self.tableView reloadData];
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        completion(NO);
        
    }];
    
    
    
    
#pragma mark ---- 品牌街网络请求
    [service requestNearbyShop:@"2" page:1 per_page:3  success:^(NSInteger code, NSString *message, id data) {
        
        self.hotBrandData = data;
        
        [self.tableView reloadData];
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        completion(NO);
        
    }];
    
    


    
}




//-(void)loadData{
//    
//    
//    
//    
//    [ReloadHud showHUDAddedTo:self.tableView reloadBlock:^{
//        
//        
//        
//        [self doLoad:^(BOOL ret){
//            
//       
//        }];
//        
//        
//        
//        
//        
//    
//    }];
//    
//    [self doLoad:^(BOOL ret){
//        
//        
//    }];
//    
//    
//    
//    
//  //  [self doLoad];
//    
//    
//    
//    
//
//    
//    
//    
//    
//}

#pragma mark- 导航栏按钮

-(void)makeBarItem{
    
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    UIBarButtonItem *addressBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"location_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        SelectCityTableViewCtrl *vc = [SelectCityTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
    
    UIBarButtonItem *addressNameBarItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"广州" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        SelectCityTableViewCtrl *vc = [SelectCityTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    
    
    UIBarButtonItem *roomMapBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"roommap"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        MallMapViewCtrl *vc = [MallMapViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
       
    }];
    
    self.navigationItem.rightBarButtonItem = roomMapBarItem;
    
//    UIBarButtonItem *scanerBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"scanner_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
//        
//    }];
//    
//    
    
    self.navigationItem.leftBarButtonItems = @[addressBarItem,addressNameBarItem];
    
 //   self.navigationItem.rightBarButtonItem = scanerBarItem;
    
#pragma mark ----- 周边商城标题
    UIButton *headButton = [[UIButton alloc]init];;
    headButton.frame = CGRectMake(0, 0, 200, 44);
    
    [headButton setTitle:@"时尚天河" forState:UIControlStateNormal];
    headButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];

    [self.navigationItem setTitle:self.cityString];
    self.navigationItem.titleView = headButton;
    
    [headButton bk_addEventHandler:^(id sender) {
        
        SelectMallPopViewCtrl *vc = [SelectMallPopViewCtrl new];
        
        [Utils popTransparentViewCtrl:self childViewCtrl:vc];
        
        //        SelectMallTableCtrl *vc = [SelectMallTableCtrl new];
        //
        //        [self.navigationController pushViewController:vc animated:YES];
        //
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
}




-(void)makeHeaderSearchBar{
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(-30, 4, SCREEN_WIDTH-100, 28);
 
  //  searchBar.placeholder=@"搜索品牌，商家，优惠券";
    searchBar.backgroundImage =[UIImage new];

    searchBar.placeholder = self.navigationItem.title;
    // [titleView addSubview:searchBar];
    
    //Set to titleView
    //[self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = searchBar;
  
    // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    
}


-(void)makeSearchBar{
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    //self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    self.searchBar.barTintColor = [GUIConfig mainBackgroundColor];
    
    self.searchBar.backgroundImage =[UIImage new];
    
    self.searchBar.delegate= self;
    
    //self.searchBar.barStyle = UIBarStyleDefault;
    self.searchBar.backgroundColor = [UIColor whiteColor];
    
    self.searchBar.backgroundColor = [GUIConfig mainBackgroundColor];
    
    self.searchBar.placeholder=@"搜索品牌，商家，优惠券";
    
    UIView *bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    [bgView addSubview:self.searchBar];
    
    
    //  [self.searchBar becomeFirstResponder];
    
    
    self.tableView.tableHeaderView = bgView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UISearBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

#pragma mark ----- 商家搜索
    KeyWordSearchViewCtrl *vc = [KeyWordSearchViewCtrl new];
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [self presentViewController:nav animated:vc completion:^{
        
    }];
    
    return NO;


}


#pragma  mark ---- cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0 || indexPath.section==2) {
        
        return [ShopInfoTableViewCell height];

        
        
    }else{
        
        return [CouponInfoTableViewCell height];
    }
    
    
    
    
    
}


#pragma mark ------------ 设置cell的组头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section ==0) {
        
       return  [ShopInfoTableViewCell headerView:@"优选品牌" clickBlock:^{
           
           ShopListViewCtrl *vc = [ShopListViewCtrl new];
           
           vc.hidesBottomBarWhenPushed = YES;
           
           [self.navigationController pushViewController:vc animated:YES];
           
           
        }];
        
    }else if (section ==1) {
        
        return  [ShopInfoTableViewCell headerView:@"即时优惠" clickBlock:^{
            
            
            CouponListViewCtrl *vc = [CouponListViewCtrl new];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }];
        
        
    }else{
        return  [ShopInfoTableViewCell headerViewWithSort:@"品牌街" clickBlock:^{
            
            
            ShopListViewCtrl *vc = [ShopListViewCtrl new];
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }];
        
    }

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==2) {
        return 80;
    }
    
    return 30;
}

#pragma mark -------- 点击cell跳转 <---> 有转模型
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 0 || indexPath.section==2) {
        ShopInfoViewCtrl *vc =[[ShopInfoViewCtrl alloc] init];
        
        if (indexPath.section == 0) {
            
            NSDictionary *data =  self.hotShopData[indexPath.row];
            vc.data = self.hotShopData[indexPath.row];
            
            vc.OptimizingBrand = [OptimizingBrandModel yy_modelWithDictionary:data];
        
            self.bools = YES;
            
        }
        
        if (indexPath.section == 2) {
          
            
            NSDictionary *data =  self.hotBrandData[indexPath.row];
            
            vc.shopData = [Shop yy_modelWithDictionary:data];
            
            vc.data = self.hotBrandData[indexPath.row];

            
            self.bools = NO;
            
        }
        
        [vc boll:self.bools];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        
        CouponDetailViewCtrl *vc = [CouponDetailViewCtrl new];
        
        vc.datas =self.couponData[indexPath.row];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


#pragma mark - 创建cell的组数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

#pragma mark - 创建cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (section ==0 ) {
        
        return [self.hotShopData count];
        
    }else if (section ==1){
        
        return [self.couponData count];
        
    }else{
        
        return [self.hotBrandData count];
        
    }
    // Return the number of rows in the section.
    return 2;
}

#pragma mark ------- cell的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath section]==0) {
        
        ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
 
        cell.data = self.hotShopData[[indexPath row]];
        
        [cell updateData];
        
        return cell;
        
    }else   if ([indexPath section]==1) {
        
        
        CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        
        cell.data = self.couponData[indexPath.row];
        
        [cell updateData];
        
        
        
        cell.couponActionType = CouponTypeLimited;
        
        
        
        return cell;
        
    }else if([indexPath section]==2) {
        
        
        ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];

        cell.data = self.hotBrandData[[indexPath row]];
        
        [cell updateData];

        return cell;
        
    }else{

        
        return nil;
    }
    
    
    
    
    // Configure the cell...
    
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
