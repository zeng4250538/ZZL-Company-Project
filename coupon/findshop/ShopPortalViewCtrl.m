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
#import "BrandStreetButtonService.h"
#import "ReminderService.h"

@interface ShopPortalViewCtrl ()

@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)NSArray *recommendShopData;        
@property(nonatomic,strong)NSArray *couponData;
@property(nonatomic,strong)NSArray *nearByShopData;
@property(nonatomic,strong)NSArray *otherData;
@property(nonatomic,strong)NSDictionary *portalData;
@property(nonatomic,assign)BOOL bools;
@property(nonatomic,strong)SelectMallPopViewCtrl *selectTitle;
@property(nonatomic,strong)NSString *cityString;
@property(nonatomic,strong)NSArray *mallArray;
@property(nonatomic,strong)UIButton *headButton;

@property(nonatomic,strong)NSString *filterString;  //分类过滤数据
@property(nonatomic,strong)NSString *sortString;    //排序数据

@property(nonatomic,strong)NSString *filterTitle;  //分类过滤数据
@property(nonatomic,strong)NSString *sortTitle;    //排序数据



@end

@implementation ShopPortalViewCtrl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title=@"找商家";
    
    
    self.selectTitle = [[SelectMallPopViewCtrl alloc]init];
    
    //table view
    
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.width.bottom.equalTo(self.view);
        
    }];
    
    [self.tableView registerClass:[ShopInfoTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    [self.tableView registerClass:[CouponInfoTableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self doLoad:^(BOOL ret) {
            
            
            [self.tableView.mj_header endRefreshing];
            
        }];
        
    }];
    
    
    [self makeSearchBar];

    
    [self makeBarItem];
    
    
    [self loadData];

    
}

-(void)titleItenLabel:(void(^)(id data))cityLabel{

#pragma mark ------ 周边商城网络请求
    MallService *services = [[MallService alloc] init];
    [services queryMallByNear:@"北京市" lon:113.333655 lat:23.138651 success:^(NSInteger code, NSString *message, id data) {
        
        self.mallArray = data;
    
//        NSLog(@"%@",self.mallArray[0][@"name"]);
        
        cityLabel(data);
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
    }];



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
    
    
    NSString *mallId = [AppShareData instance].mallId;

    
    ShopService *service = [ShopService new];
    
    CouponService *couponService = [CouponService new];
    
    
#pragma mark ---- 优选品牌网络请求
    
    
    [service requestRecommendShop:mallId page:1 pageCount:3 success:^(NSInteger code, NSString *message, id data) {
        
        self.recommendShopData = data;
        [self.tableView reloadData];
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        
        
        completion(NO);
        
    }];
    
    
    
    
#pragma mark ---- 即时优惠网络请求
    [couponService requestRecommendCoupon:mallId page:1 pageCount:3 sort:@"endTime" success:^(NSInteger code, NSString *message, id data) {
        
        self.couponData=data;
        
        [self.tableView reloadData];
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
       
        completion(NO);
       
        
    }];

    
    
#pragma mark ---- 品牌街网络请求
    
    
    [service requestNearbyShop:mallId page:1 per_page:10  success:^(NSInteger code, NSString *message, id data) {
        
        self.nearByShopData = data;
        [self.tableView reloadData];
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        
        
        
        
        completion(NO);
        
    }];
    
    


    
}


#pragma mark- 导航栏按钮

-(void)makeBarItem{
    
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    UIBarButtonItem *addressBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"location_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        SelectCityTableViewCtrl *vc = [SelectCityTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
    
    UIBarButtonItem *addressNameBarItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"北京市" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        SelectCityTableViewCtrl *vc = [SelectCityTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    
    
    UIBarButtonItem *roomMapBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"roommap"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        MallMapViewCtrl *vc = [MallMapViewCtrl new];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
       
    }];
    
    self.navigationItem.rightBarButtonItem = roomMapBarItem;
    
    
    self.navigationItem.leftBarButtonItems = @[addressBarItem,addressNameBarItem];
    
    
#pragma mark ----- 周边商城标题
    _headButton = [[UIButton alloc]init];;
    _headButton.frame = CGRectMake(0, 0, 100, 44);

    [_headButton setTitle:@"选择商城" forState:UIControlStateNormal];
    _headButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];

    [self.navigationItem setTitle:self.cityString];
    self.navigationItem.titleView = _headButton;
    
    [self titleItenLabel:^(id data) {
        
        [_headButton setTitle:data[0][@"name"] forState:UIControlStateNormal];
        SelectMallPopViewCtrl *vc = [SelectMallPopViewCtrl new];
        vc.mallList = data;

    }];
    
    [_headButton bk_addEventHandler:^(id sender) {

        SelectMallPopViewCtrl *vc = [SelectMallPopViewCtrl new];
        
        [Utils popTransparentViewCtrl:self childViewCtrl:vc];
        
        vc.selectMallBlock = ^(BOOL ret ,NSDictionary *mall){
            
            
            NSString *name = [NSString stringWithFormat:@"%@(%@)",SafeString(mall[@"name"]),SafeString(mall[@"distance"])];
            
            
            
            [_headButton setTitle:name forState:UIControlStateNormal];
        };
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
}




-(void)makeHeaderSearchBar{
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(-30, 4, SCREEN_WIDTH-100, 28);
 
    searchBar.backgroundImage =[UIImage new];

    searchBar.placeholder = self.navigationItem.title;
    
    self.navigationItem.titleView = searchBar;
  
    
}


-(void)makeSearchBar{
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    self.searchBar.barTintColor = [GUIConfig mainBackgroundColor];
    
    self.searchBar.backgroundImage =[UIImage new];
    
    self.searchBar.delegate= self;
    
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
           
           vc.navigationItem.title=@"优选品牌";
           
           vc.shopQueryType = ShopQueryTypeRecommend;
           
           [self.navigationController pushViewController:vc animated:YES];
           
           
        }];
        
    }else if (section ==1) {
        
        return  [ShopInfoTableViewCell headerView:@"即时优惠" clickBlock:^{
            
            CouponListViewCtrl *vc = [CouponListViewCtrl new];
            
            vc.couponListType = CouponListTypeReminder;
            vc.hidesBottomBarWhenPushed = YES;
            
            
            
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        
        
    }else{
        return  [self headerViewWithSort:@"品牌街" clickBlock:^{
            
            ShopListViewCtrl *vc = [ShopListViewCtrl new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.navigationItem.title=@"品牌街";
            vc.shopQueryType = ShopQueryTypeNearBy;
            
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
            
            NSDictionary *data =  self.recommendShopData[indexPath.row];
            vc.data = self.recommendShopData[indexPath.row];
            
            vc.shopId = SafeString(data[@"id"]);
        
            vc.OptimizingBrand = [OptimizingBrandModel yy_modelWithDictionary:data];
        
            self.bools = YES;
            
        }
        
        if (indexPath.section == 2) {
          
            
            NSDictionary *data =  self.nearByShopData[indexPath.row];
            
            vc.shopData = [Shop yy_modelWithDictionary:data];
            
            vc.data = self.nearByShopData[indexPath.row];
            
            vc.shopId = SafeString(data[@"id"]);
            

            
            self.bools = NO;
            
        }
        
       // [vc boll:self.bools];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        
#pragma mark - 点击进入即时优惠
        CouponDetailViewCtrl *vc = [CouponDetailViewCtrl new];
        
       // vc.couponViewMode = CouponViewModeNetwork;
        vc.data = self.couponData[indexPath.row];
       // NSString *couponId = SafeString(self.couponData[indexPath.row][@"couponId"]);
        //vc.couponId = couponId;
        
        
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
        
        return [self.recommendShopData count];
        
    }else if (section ==1){
        
        return [self.couponData count];
        
    }else{
        
        return [self.nearByShopData count];
        
    }
    // Return the number of rows in the section.
    return 2;
}

#pragma mark ------- cell的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath section]==0) {
        
        ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
 
        cell.data = self.recommendShopData[[indexPath row]];
        
        [cell updateData];
        
        return cell;
        
    }else   if ([indexPath section]==1) {
        
        
        CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        
        
        NSMutableDictionary *d   = [self.couponData[indexPath.row] mutableCopy];
        
        cell.data = d;
        
        NSString *isRemider  = SafeString(d[@"setReminder"]);
        
        if ([isRemider isEqualToString:@"1"]) {
            
            cell.couponActionType = CouponTypeUnLimited;
        }else{
            
            cell.couponActionType = CouponTypeLimited;
            
        }
        
        
        
        //setReminder
        
        
        cell.doActionBlock = ^(id sender){
            
            
            NSString *isReminder = SafeString(d[@"setReminder"]);
            
            if ([ isReminder isEqualToString:@"0"]) {
                
                NSString *promotionId = SafeString(d[@"couponPromotionId"]);
                ReminderService *service = [ReminderService new];
                [service addReminder:promotionId success:^(NSInteger code, NSString *message, id data) {
                    UIButton *button = (UIButton*)sender;
                    [button setTitle:@"取消提醒" forState:UIControlStateNormal];
                    d[@"setReminder"]=@1;
                    NSString * reminderId = data[@"reminderId"];
                    
                    d[@"reminderId"]=SafeString(reminderId);
                    [SVProgressHUD showSuccessWithStatus:@"提醒成功"];
                    
                } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                    
                    
                    [SVProgressHUD showErrorWithStatus:@"提醒失败"];
                    
                    
                }];
                
                
                
            }else{
                
                
                
                NSString *reminderId = SafeString(d[@"reminderId"]);
                
                
                ReminderService *service = [ReminderService new];
                
                
                [service deleteReminder:reminderId success:^(NSInteger code, NSString *message, id data) {
                    
                    
                    UIButton *button = (UIButton*)sender;
                    
                    [button setTitle:@"提醒" forState:UIControlStateNormal];
                    
                    d[@"setReminder"]=@0;
                    
                    
                    [SVProgressHUD showSuccessWithStatus:@"取消提醒成功"];
                    
                    
                } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                    
                    
                    [SVProgressHUD showErrorWithStatus:@"取消提醒失败"];
                    
                    
                }];
                
                
                
                
                
                
                
                
            }
            
            
        
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        };
        
        
        
        
        [cell updateData];
        
        
        
        
        
        
      //  cell.couponActionType = CouponTypeLimited;
        
        
        
        return cell;
        
    }else if([indexPath section]==2) {
        
        
        ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];

        cell.data = self.nearByShopData[[indexPath row]];
        
        [cell updateData];
        
        BrandStreetButtonService *brandStreetButton = [BrandStreetButtonService new];
        
         __weak ShopPortalViewCtrl *weakSelf = self;
        
        self.block = ^(NSString *data){
            
            [brandStreetButton requestButtonString:data shopMallId:@"2" success:^(id data) {
                
                
                cell.data = data[indexPath.row];
                
                [cell updateData];
                
//                __weak ShopPortalViewCtrl *weakSelf = self;
                
                [weakSelf.tableView reloadData];
                
                
            } failure:^(id code) {
                
            }];
            
            NSLog(@"刷新了");
            
        };

        return cell;
        
    }else{

        
        return nil;
    }
    
    
    
    
    // Configure the cell...
    
}
-(void)doFilterSortData:(NSString*)filter sort:(NSString*)sort{
    
    
    
    self.filterString = filter;
    self.sortString = sort;

    if ([filter isEqualToString:@"全部"]) {
        self.filterTitle=@"全部";
        self.filterString=@"";
        
    }

    
    
    if ([filter isEqualToString:@"美食"]) {
        self.filterTitle=@"美食";
        self.filterString=@"00001";
        
    }
    if ([filter isEqualToString:@"电影"]) {
        self.filterTitle=@"电影";
        self.filterString=@"00002";
        
    }

    if ([filter isEqualToString:@"休闲娱乐"]) {
        self.filterTitle=@"休闲娱乐";
        self.filterString=@"00003";
    }

    if ([sort isEqualToString:@"默认排序"]) {
        self.sortTitle=@"默认排序";
        self.sortString=@"default";
    }
    
    if ([sort isEqualToString:@"点赞升序"]) {
        self.sortTitle=@"点赞升序";
        self.sortString=@"good";
        
        
    }
    
    if ([sort isEqualToString:@"点赞降序"]) {
        self.sortTitle=@"点赞降序";
        self.sortString=@"-good";
        
        
    }
    
    
    if ([sort isEqualToString:@"收藏降序"]) {
        self.sortTitle=@"收藏降序";
        self.sortString=@"-favor_count";
        
        
    }

    if ([sort isEqualToString:@"领取降序"]) {
        self.sortTitle=@"领取降序";
        self.sortString=@"-ordered_coupon_count";
        
        
    }

    
    
    
    
    
    
    
    
    
    ShopService *service = [ShopService new];
    
    NSString *mallId = [AppShareData instance].mallId;

    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [service requestNearbyShopWithFilter:mallId page:1 per_page:10 cat:self.filterString sort:self.sortString success:^(NSInteger code, NSString *message, id data) {
        
        [SVProgressHUD dismiss];
        
        
        self.nearByShopData = data;
        
        [self.tableView reloadData];
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        [SVProgressHUD dismiss];
        
        
        if (code==404) {
            
            self.nearByShopData = nil;
            [self.tableView reloadData];
            
        }
        
        
        
    }];
    
    
    
    
    
    
    
}


-(UIView*)headerViewWithSort:(NSString*)title clickBlock:(void(^)())clickBlock{
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30+50)];
    uv.backgroundColor = [GUIConfig mainBackgroundColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH/2, 30)];
    lab.textColor = [GUIConfig grayFontColorDeep];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = title;
    [uv addSubview:lab];
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [moreButton setTitle:@"更多 >>" forState:UIControlStateNormal];
    moreButton.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 30);
    moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [moreButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    [uv addSubview:moreButton];
    [moreButton bk_addEventHandler:^(id sender) {
        if (clickBlock) {
            clickBlock();
            
            
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIView *sortBarView = [UIView new];
    sortBarView.backgroundColor = [UIColor whiteColor];
    
    sortBarView.frame = CGRectMake(0, 30, SCREEN_WIDTH, 50);
    [uv addSubview:sortBarView];
    
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, 79, SCREEN_WIDTH, 1);
    
    line.backgroundColor = [GUIConfig mainBackgroundColor];
    
    [uv addSubview:line];
    
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    filterButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 50);
    [filterButton setTitle:@"全部" forState:UIControlStateNormal];
    
    if ([self.filterTitle length]==0) {
        [filterButton setTitle:@"全部" forState:UIControlStateNormal];

    }else{
        [filterButton setTitle:self.filterTitle forState:UIControlStateNormal];
        
        
    }
    [sortBarView addSubview:filterButton];
    
    [filterButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
    
    
    
    UIButton *sortButton = [UIButton buttonWithType:UIButtonTypeSystem];
    sortButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 50);
    
    if ([self.sortTitle length]==0) {
        [sortButton setTitle:@"排序" forState:UIControlStateNormal];

    }else{
        
        [sortButton setTitle:self.sortTitle forState:UIControlStateNormal];
       
    }
    
    [sortBarView addSubview:sortButton];
    
    [sortButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = [GUIConfig mainBackgroundColor];
    
    line2.frame = CGRectMake(SCREEN_WIDTH/2, 10, 1, 30);
    
    [sortBarView addSubview:line2];
    
    
    NSString *mallId = [AppShareData instance].mallId;
    
    
    [filterButton bk_addEventHandler:^(id sender) {
        
        UIActionSheet *as = [[UIActionSheet alloc] bk_initWithTitle:@""];
        
        
          
        
        
        [as bk_addButtonWithTitle:@"全部" handler:^{
            
            [filterButton setTitle:@"全部" forState:UIControlStateNormal];
            
            
            
            [self doFilterSortData:@"全部" sort:self.sortString];
            
            
            
            
        }];
        
        [as bk_addButtonWithTitle:@"美食" handler:^{
            
            
            [self doFilterSortData:@"美食" sort:self.sortString];
            
            
        }];
        
        [as bk_addButtonWithTitle:@"电影" handler:^{
            
            
            [self doFilterSortData:@"电影" sort:self.sortString];
            
            
            
        }];
        
        [as bk_addButtonWithTitle:@"休闲娱乐" handler:^{
            
            [self doFilterSortData:@"休闲娱乐" sort:self.sortString];
            
            
            
        }];
        
        
        
        
        [as bk_setDestructiveButtonWithTitle:@"取消" handler:^{
            
        }];
        
        
        [as showInView:[UIApplication sharedApplication].keyWindow];
        
        
        UITapGestureRecognizer *tap =[UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            
            
            [as dismissWithClickedButtonIndex:0 animated:YES];
            
            
            
            
        }];
        
        
        [as.window addGestureRecognizer:tap];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //    [tan release];
    
    
    ShopService *service = [ShopService new];
    
    
    [sortButton bk_addEventHandler:^(id sender) {
        
        
        UIActionSheet *as = [[UIActionSheet alloc] bk_initWithTitle:@""];
        
        [as bk_addButtonWithTitle:@"默认排序" handler:^{
            
            
            
            [self doFilterSortData:self.filterString sort:@"默认排序"];
            
            
            
           
        

            
        }];
        
        [as bk_addButtonWithTitle:@"点赞降序" handler:^{
            
            
            [self doFilterSortData:self.filterString sort:@"点赞降序"];
            
 
            
        }];
        
        [as bk_addButtonWithTitle:@"点赞升序" handler:^{
            
            [self doFilterSortData:self.filterString sort:@"点赞升序"];

            
            
            
 
            
        }];
        
        [as bk_addButtonWithTitle:@"收藏降序" handler:^{
            
            
            [self doFilterSortData:self.filterString sort:@"收藏降序"];

            
    
            
        }];
 
        [as bk_addButtonWithTitle:@"领取降序" handler:^{
            
            [sortButton setTitle:@"领取降序" forState:UIControlStateNormal];
            
        }];

        
        [as bk_setDestructiveButtonWithTitle:@"取消" handler:^{
            
        }];
       
        [as showInView:[UIApplication sharedApplication].keyWindow];
       
    } forControlEvents:UIControlEventTouchUpInside];
    
    return uv;
    
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
