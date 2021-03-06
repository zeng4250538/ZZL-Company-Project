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

@property(nonatomic,strong)NSString *city;

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
@property(nonatomic,strong)UIButton *mallButton;
@property(nonatomic,assign)NSUInteger pageCount;    //当前总页



@end

@implementation ShopPortalViewCtrl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageCount = 1;
    
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
    
    
    [self makeSearchBar];
   
    [self makeBarItem];
    
    
    [[AppShareData instance] addMallIdKVO:self];
    
    
    
    [self makePullRefresh];
    
    [self loadData];
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];


    
    
    
    
    
}

#pragma mark - 下拉和上拉刷新
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


#pragma mark - 下拉装载
-(void)doLoadNextPage:(NSUInteger)page completion:(void (^)(BOOL))completion{
    
    ShopService *service = [ShopService new];
    
    NSString *mallId = [AppShareData instance].mallId;
    
    
    [service requestNearbyShop:mallId page:page per_page:10  success:^(NSInteger code, NSString *message, id data) {
        
        if ([data count]==0) {
            
            completion(NO);
            return ;
            
        }
        
        self.nearByShopData = [self.nearByShopData arrayByAddingObjectsFromArray:data];
        
        [self.tableView reloadData];
        
        completion(YES);
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
         completion(NO);
        
    }];
    
    
}


-(void)dealloc{
    
    [[AppShareData instance] removeMallIdKVO:self];
}


-(void)refreshTableView{

    NSLog(@"刷新了");
    
    [self loadData];
    [_tableView reloadData];

}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableView) name:@"refreshFindShopTableView" object:nil];
    
    [self makeBarItem];
    
}



-(void)titleItenLabelString:(NSString *)city andcityLabel:(void(^)(id data))cityLabel{

#pragma mark ------ 周边商城网络请求
    MallService *services = [[MallService alloc] init];

    NSString *cityName = [AppShareData instance].city;
    
    
    [services queryMallByNear:cityName lon:[AppShareData instance].lon lat:[AppShareData instance].lat success:^(NSInteger code, NSString *message, id data) {
        
        self.mallArray = data;
    
        
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
    
    
    self.pageCount=1;

    
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
        
    }];
    
    
    NSString *city = [AppShareData instance].city;
    
    UIBarButtonItem *addressNameBarItem = [[UIBarButtonItem alloc] bk_initWithTitle:city style:UIBarButtonItemStylePlain handler:^(id sender) {
        
    }];
    
    
    self.navigationItem.leftBarButtonItems = @[addressBarItem,addressNameBarItem];
    
    
    UIButton *mallButton = [UIButton buttonWithType:UIButtonTypeSystem];
    mallButton.frame = CGRectMake(0, 0, 150, 44);
    [mallButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    mallButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    
    [mallButton setTitle:[AppShareData instance].mallName forState:UIControlStateNormal];
    
    
    
    self.mallButton =mallButton;
    
    
    self.navigationItem.titleView = mallButton;
    
    
    
    [mallButton bk_addEventHandler:^(id sender) {
       
        SelectMallPopViewCtrl *vc = [SelectMallPopViewCtrl new];
        
        vc.tabelViewRefresh = ^(id data){
            
            [self loadData];
            [_tableView reloadData];
        
        };
        
        
        
        [Utils popTransparentViewCtrl:self childViewCtrl:vc];
        
        vc.selectMallBlock = ^(BOOL ret ,NSDictionary *mall){
            
            
            NSString *name = [NSString stringWithFormat:@"%@",SafeString(mall[@"name"])
                              /*,SafeString(mall[@"distance"])*/];
            
            
            [[AppShareData instance] setMallName:SafeString(mall[@"name"])];
            
            [[AppShareData instance] saveMallId:SafeString(mall[@"id"])];
            
            
            
            
            
            [self.mallButton setTitle:name forState:UIControlStateNormal];
        };
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem *roomMapBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"roommap"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        MallMapViewCtrl *vc = [MallMapViewCtrl new];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    self.navigationItem.rightBarButtonItem = roomMapBarItem;
    
    
  //  self.navigationItem.leftBarButtonItems = @[addressBarItem,addressNameBarItem];

    
}




//未知是否有用，暂时屏蔽
//-(void)makeHeaderSearchBar{
//    
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
//    
//    searchBar.delegate = self;
//    searchBar.frame = CGRectMake(-30, 4, SCREEN_WIDTH-100, 28);
// 
//    searchBar.backgroundImage =[UIImage new];
//
//    searchBar.placeholder = self.navigationItem.title;
//    
//    self.navigationItem.titleView = searchBar;
//  
//    
//}


-(void)makeSearchBar{
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    self.searchBar.barTintColor = [GUIConfig mainBackgroundColor];
    
    self.searchBar.backgroundImage =[UIImage new];
    
    self.searchBar.delegate= self;
    
    self.searchBar.backgroundColor = [UIColor whiteColor];
    
    self.searchBar.backgroundColor = [GUIConfig mainBackgroundColor];
    
    self.searchBar.placeholder=@"搜索品牌商家";
    
    UIView *bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    [bgView addSubview:self.searchBar];
    
    
    self.tableView.tableHeaderView = bgView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    return 100;
  
}


#pragma mark ------------ 设置cell的组头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //self.recommendShopData 优选品牌
    //self.couponData  即时优惠
    //self.nearByShopData 品牌街
    if ([self.recommendShopData count]>0 && [self.couponData count]>0 && [self.nearByShopData count]>0) {
        
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
    
    //self.recommendShopData 优选品牌
    //self.couponData  即时优惠
    //self.nearByShopData 品牌街
    
    if ([self.recommendShopData count] == 0 && [self.couponData count]>0 && [self.nearByShopData count]>0) {
        
        if (section == 0) {
            return  [ShopInfoTableViewCell headerView:@"即时优惠" clickBlock:^{
                
                CouponListViewCtrl *vc = [CouponListViewCtrl new];
                
                vc.couponListType = CouponListTypeReminder;
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }];

        }
        else{
        
            return  [self headerViewWithSort:@"品牌街" clickBlock:^{
                
                ShopListViewCtrl *vc = [ShopListViewCtrl new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.navigationItem.title=@"品牌街";
                vc.shopQueryType = ShopQueryTypeNearBy;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
        
        }
    }
    
    //self.recommendShopData 优选品牌
    //self.couponData  即时优惠
    //self.nearByShopData 品牌街
    if ([self.couponData count] == 0 && [self.recommendShopData count]>0 && [self.nearByShopData count]>0) {
        
        if (section == 0) {
            return  [ShopInfoTableViewCell headerView:@"优选品牌" clickBlock:^{
                
                ShopListViewCtrl *vc = [ShopListViewCtrl new];
                
                vc.hidesBottomBarWhenPushed = YES;
                
                vc.navigationItem.title=@"优选品牌";
                
                vc.shopQueryType = ShopQueryTypeRecommend;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            
        }
        else{
            
            return  [self headerViewWithSort:@"品牌街" clickBlock:^{
                
                ShopListViewCtrl *vc = [ShopListViewCtrl new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.navigationItem.title=@"品牌街";
                vc.shopQueryType = ShopQueryTypeNearBy;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            
        }
        
    }
    
    
    //self.recommendShopData 优选品牌
    //self.couponData  即时优惠
    //self.nearByShopData 品牌街
    if ([self.nearByShopData count] == 0 && [self.recommendShopData count]>0 && [self.couponData count]>0) {
        
        if (section == 0) {
            return  [ShopInfoTableViewCell headerView:@"优选品牌" clickBlock:^{
                
                ShopListViewCtrl *vc = [ShopListViewCtrl new];
                
                vc.hidesBottomBarWhenPushed = YES;
                
                vc.navigationItem.title=@"优选品牌";
                
                vc.shopQueryType = ShopQueryTypeRecommend;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            
        }
        else{
            
            return  [ShopInfoTableViewCell headerView:@"即时优惠" clickBlock:^{
                
                CouponListViewCtrl *vc = [CouponListViewCtrl new];
                
                vc.couponListType = CouponListTypeReminder;
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            
        }
        
    }
    
    
    
    if ([self.recommendShopData count] == 0 && [self.couponData count] == 0 && [self.nearByShopData count]>0) {
        
        return  [self headerViewWithSort:@"品牌街" clickBlock:^{
            
            ShopListViewCtrl *vc = [ShopListViewCtrl new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.navigationItem.title=@"品牌街";
            vc.shopQueryType = ShopQueryTypeNearBy;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }
    
    if ([self.recommendShopData count] == 0 && [self.nearByShopData count] == 0 && [self.couponData count]>0) {
        return  [ShopInfoTableViewCell headerView:@"即时优惠" clickBlock:^{
            
            CouponListViewCtrl *vc = [CouponListViewCtrl new];
            
            vc.couponListType = CouponListTypeReminder;
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }
    
    if ([self.couponData count] == 0 && [self.nearByShopData count] == 0 && [self.recommendShopData count]>0) {
        return  [ShopInfoTableViewCell headerView:@"优选品牌" clickBlock:^{
            
            ShopListViewCtrl *vc = [ShopListViewCtrl new];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            vc.navigationItem.title=@"优选品牌";
            
            vc.shopQueryType = ShopQueryTypeRecommend;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }];

    }

    
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    //self.recommendShopData 优选品牌
    //self.couponData  即时优惠
    //self.nearByShopData 品牌街
    
    if ([self.recommendShopData count]>0 && [self.couponData count]>0 && [self.nearByShopData count]>0) {
         if (section==2) {
             return 80;
        };
        return 30;
    }
    
    
    if ([self.recommendShopData count] == 0 && [self.couponData count]>0 && [self.nearByShopData count]>0) {
        if (section==1) {
            return 80;
        };
        return 30;
    }
    if ([self.couponData count] == 0 && [self.recommendShopData count]>0 && [self.nearByShopData count]>0) {
        if (section==1) {
            return 80;
        };
        return 30;
    }
    if ([self.nearByShopData count] == 0 && [self.recommendShopData count]>0 && [self.couponData count]>0) {
        return 30;
    }
    
    
    if ([self.recommendShopData count] == 0 && [self.couponData count] == 0 && [self.nearByShopData count]>0) {
        return 80;
    }
    
    if ([self.recommendShopData count] == 0 && [self.nearByShopData count] == 0 && [self.couponData count]>0) {
        return 30;
    }
    
    if ([self.couponData count] == 0 && [self.nearByShopData count] == 0 && [self.recommendShopData count]>0) {
        return 30;
    }

    return 0;
}

#pragma mark -------- 点击cell跳转 <---> 有转模型
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //self.recommendShopData 优选品牌
    //self.couponData  即时优惠
    //self.nearByShopData 品牌街
    
    if ([self.recommendShopData count]>0 && [self.couponData count]>0 && [self.nearByShopData count]>0) {
        
        if (indexPath.section == 0 || indexPath.section==2) {
            ShopInfoViewCtrl *vc =[[ShopInfoViewCtrl alloc] init];
            
            if (indexPath.section == 0) {
                
                NSDictionary *data =  self.recommendShopData[indexPath.row];
                
                vc.shopId = SafeString(data[@"id"]);
                
                vc.OptimizingBrand = [OptimizingBrandModel yy_modelWithDictionary:data];
                
                self.bools = YES;
                
            }
            
            if (indexPath.section == 2) {
                
                
                NSDictionary *data =  self.nearByShopData[indexPath.row];
                
                // vc.shopData = [Shop yy_modelWithDictionary:data];
                
                //vc.data = self.nearByShopData[indexPath.row];
                
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
    
    
    
    if ([self.recommendShopData count] == 0 && [self.couponData count]>0 && [self.nearByShopData count]>0) {
        if (indexPath.section == 0) {
#pragma mark - 点击进入即时优惠
            CouponDetailViewCtrl *vc = [CouponDetailViewCtrl new];
            
            // vc.couponViewMode = CouponViewModeNetwork;
            vc.data = self.couponData[indexPath.row];
            // NSString *couponId = SafeString(self.couponData[indexPath.row][@"couponId"]);
            //vc.couponId = couponId;
            
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            }
        
        if (indexPath.section == 1) {
            ShopInfoViewCtrl *vc =[[ShopInfoViewCtrl alloc] init];
            NSDictionary *data =  self.nearByShopData[indexPath.row];
            
            // vc.shopData = [Shop yy_modelWithDictionary:data];
            
            //vc.data = self.nearByShopData[indexPath.row];
            
            vc.shopId = SafeString(data[@"id"]);
            
            self.bools = NO;
            
            
            
            // [vc boll:self.bools];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        
        }
    
    

    if ([self.couponData count] == 0 && [self.recommendShopData count]>0 && [self.nearByShopData count]>0) {
            ShopInfoViewCtrl *vc =[[ShopInfoViewCtrl alloc] init];
            
            if (indexPath.section == 0) {
                
                NSDictionary *data =  self.recommendShopData[indexPath.row];
                
                vc.shopId = SafeString(data[@"id"]);
                
//                vc.OptimizingBrand = [OptimizingBrandModel yy_modelWithDictionary:data];
                
                self.bools = YES;
                
            }
            
            if (indexPath.section == 1) {
                
                
                NSDictionary *data =  self.nearByShopData[indexPath.row];
                
                // vc.shopData = [Shop yy_modelWithDictionary:data];
                
                //vc.data = self.nearByShopData[indexPath.row];
                
                vc.shopId = SafeString(data[@"id"]);
                
                self.bools = NO;
                
            }
            
            // [vc boll:self.bools];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    
    
    
    if ([self.nearByShopData count] == 0 && [self.recommendShopData count]>0 && [self.couponData count]>0) {
        ShopInfoViewCtrl *vc =[[ShopInfoViewCtrl alloc] init];
        if (indexPath.section == 0) {
            
            NSDictionary *data =  self.recommendShopData[indexPath.row];
            
            vc.shopId = SafeString(data[@"id"]);
            
            vc.OptimizingBrand = [OptimizingBrandModel yy_modelWithDictionary:data];
            
            self.bools = YES;
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];

            
        }
        
        if (indexPath.section == 1) {
        
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
    
    
    
    if ([self.recommendShopData count] == 0 && [self.couponData count] == 0 && [self.nearByShopData count]>0) {
        ShopInfoViewCtrl *vc =[[ShopInfoViewCtrl alloc] init];
        NSDictionary *data =  self.nearByShopData[indexPath.row];
        
        // vc.shopData = [Shop yy_modelWithDictionary:data];
        
        //vc.data = self.nearByShopData[indexPath.row];
        
        vc.shopId = SafeString(data[@"id"]);
        
        self.bools = NO;
        
    
    // [vc boll:self.bools];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];

    }

    
    
    if ([self.recommendShopData count] == 0 && [self.nearByShopData count] == 0 && [self.couponData count]>0) {
#pragma mark - 点击进入即时优惠
        CouponDetailViewCtrl *vc = [CouponDetailViewCtrl new];
        
        // vc.couponViewMode = CouponViewModeNetwork;
        vc.data = self.couponData[indexPath.row];
        // NSString *couponId = SafeString(self.couponData[indexPath.row][@"couponId"]);
        //vc.couponId = couponId;
        
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    
    
    if ([self.couponData count] == 0 && [self.nearByShopData count] == 0 && [self.recommendShopData count]>0) {
        
        ShopInfoViewCtrl *vc =[[ShopInfoViewCtrl alloc] init];
        
//        if (indexPath.section == 0) {
        
            NSDictionary *data =  self.recommendShopData[indexPath.row];
            
            vc.shopId = SafeString(data[@"id"]);
            
            vc.OptimizingBrand = [OptimizingBrandModel yy_modelWithDictionary:data];
            
            self.bools = YES;
            
//        }
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];


        
    }
    
    
}


#pragma mark - 创建cell的组数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //self.recommendShopData 优选品牌
    //self.couponData  即时优惠
    //self.nearByShopData 品牌街

    if ([self.recommendShopData count]>0 && [self.couponData count]>0 && [self.nearByShopData count]>0) {
        
        return 3;
    }
    
    
    if ([self.recommendShopData count] == 0 && [self.couponData count]>0 && [self.nearByShopData count]>0) {
        return 2;
    }
    if ([self.couponData count] == 0 && [self.recommendShopData count]>0 && [self.nearByShopData count]>0) {
        return 2;
    }
    if ([self.nearByShopData count] == 0 && [self.recommendShopData count]>0 && [self.couponData count]>0) {
        return 2;
    }
    
    
    if ([self.recommendShopData count] == 0 && [self.couponData count] == 0 && [self.nearByShopData count]>0) {
        return 1;
    }
    
    if ([self.recommendShopData count] == 0 && [self.nearByShopData count] == 0 && [self.couponData count]>0) {
        return 1;
    }
    
    if ([self.couponData count] == 0 && [self.nearByShopData count] == 0 && [self.recommendShopData count]>0) {
        return 1;
    }

    
    return 0;
}

#pragma mark - 创建cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //self.recommendShopData 优选品牌
    //self.couponData  即时优惠
    //self.nearByShopData 品牌街
    
    if ([self.recommendShopData count]>0 && [self.couponData count]>0 && [self.nearByShopData count]>0) {
        if (section ==0 ) {
            
            return [self.recommendShopData count];
            
        }
        if (section ==1){
            
            return [self.couponData count];
            
        }else{
            
            return [self.nearByShopData count];
            
        }

    }
    
    if ([self.recommendShopData count]==0 && [self.couponData count]>0 && [self.nearByShopData count]>0) {
        if (section ==0 ) {
            
            return [self.couponData count];
            
        }
        if (section ==1){
            
            return [self.nearByShopData count];

     }
        
  }
    if ([self.couponData count]==0 && [self.recommendShopData count]>0 && [self.nearByShopData count]>0) {
        if (section ==0 ) {
            
            return [self.recommendShopData count];
            
        }
        if (section ==1){
            
            return [self.nearByShopData count];
            
        }
        
    }

    if ([self.nearByShopData count]==0 && [self.recommendShopData count]>0 && [self.couponData count]>0) {
        if (section ==0 ) {
            
            return [self.recommendShopData count];
            
        }
        if (section ==1){
            
            return [self.couponData count];
            
        }
        
    }
    
    if ([self.recommendShopData count] == 0 && [self.couponData count] == 0) {
        return [self.nearByShopData count];
    }
    
    if ([self.recommendShopData count] == 0 && [self.nearByShopData count] == 0) {
        return [self.couponData count];
    }
    
    if ([self.couponData count] == 0 && [self.nearByShopData count] == 0) {
        return [self.recommendShopData count];
    }
    
    
    
        // Return the number of rows in the section.
    return 0;
}

#pragma mark ------- cell的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //self.recommendShopData 优选品牌
    //self.couponData  即时优惠
    //self.nearByShopData 品牌街
    
    if ([self.recommendShopData count]>0 &&[self.couponData count]>0 &&[self.nearByShopData count]>0) {
    
    if ([indexPath section]==0) {
        
        ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        if (([self.recommendShopData count]>0)) {
            cell.data = self.recommendShopData[[indexPath row]];
            
            [cell updateData];
        }
        
        return cell;
        
    }
        
    else   if ([indexPath section]==1) {
        
        CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        if ([self.couponData count]>0) {
            
        
        NSMutableDictionary *d  = [self.couponData[indexPath.row] mutableCopy];
        
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
            
        }
        return cell;
        
    }
        
    else if([indexPath section]==2) {
        
        
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
        
    }
        
    }
    
    if ([self.recommendShopData count] == 0 &&[self.couponData count]>0 &&[self.nearByShopData count]>0) {
        
        if ([indexPath section]==0) {
            
            CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            
            if ([self.couponData count]>0) {
                
                
                NSMutableDictionary *d  = [self.couponData[indexPath.row] mutableCopy];
                
                cell.data = d;
                
                NSString *isRemider  = SafeString(d[@"setReminder"]);
                
                if ([isRemider isEqualToString:@"1"]) {
                    
                    cell.couponActionType = CouponTypeUnLimited;
                }else{
                    
                    cell.couponActionType = CouponTypeLimited;
                    
                }
     
                
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
                
            }
            return cell;
            
        }
        
        else if([indexPath section]==1) {
            
            
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
            
        }
    }
    
    if ([self.couponData count] == 0 &&[self.recommendShopData count]>0 &&[self.nearByShopData count]>0) {
        
        if ([indexPath section]==0) {
            
            ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            if (([self.recommendShopData count]>0)) {
                cell.data = self.recommendShopData[[indexPath row]];
                
                [cell updateData];
            }
            
            return cell;
            
        }
        else if([indexPath section]==1) {
            
            
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
            
        }
    }
    
    if ([self.nearByShopData count] == 0&&[self.recommendShopData count]>0 &&[self.couponData count]>0) {
        
        if ([indexPath section]==0) {
            
            ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            if (([self.recommendShopData count]>0)) {
                cell.data = self.recommendShopData[[indexPath row]];
                
                [cell updateData];
            }
            
            return cell;
            
        }
        else   if ([indexPath section]==1) {
            
            CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            
            if ([self.couponData count]>0) {
                
                
                NSMutableDictionary *d  = [self.couponData[indexPath.row] mutableCopy];
                
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
                
            }
            
            return cell;
            
        }

    }
    
    
    
    if ([self.recommendShopData count] == 0 && [self.couponData count] == 0) {
        
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
    }
    
    if ([self.recommendShopData count] == 0 && [self.nearByShopData count] == 0) {
        CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        if ([self.couponData count]>0) {
            
            
            NSMutableDictionary *d  = [self.couponData[indexPath.row] mutableCopy];
            
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
            
        }
        return cell;
    }
    
    if ([self.couponData count] == 0 && [self.nearByShopData count] == 0) {
        ShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        if (([self.recommendShopData count]>0)) {
            cell.data = self.recommendShopData[[indexPath row]];
            
            [cell updateData];
        }
        
        return cell;
    }
    
    return nil;
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
        self.sortString=@"";
    }
    
    if ([sort isEqualToString:@"领取最多"]) {
        self.sortTitle=@"领取最多";
        self.sortString=@"-taken_coupon_count";
        
        
    }
    
    if ([sort isEqualToString:@"点赞最多"]) {
        self.sortTitle=@"点赞最多";
        self.sortString=@"-good";
        
        
    }
    
    
    if ([sort isEqualToString:@"订阅最多"]) {
        self.sortTitle=@"订阅最多";
        self.sortString=@"-favor_count";
        
        
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
//    [uv addSubview:moreButton];
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
    
//    NSString *mallId = [AppShareData instance].mallId;
    
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
    
    ShopService *service = [ShopService new];
    
    [sortButton bk_addEventHandler:^(id sender) {
        
        UIActionSheet *as = [[UIActionSheet alloc]init];
        
        
        [as bk_addButtonWithTitle:@"默认排序" handler:^{
            
            [self doFilterSortData:self.filterString sort:@"默认排序"];
            
        }];
        
        [as bk_addButtonWithTitle:@"领取最多" handler:^{
            
            
            [self doFilterSortData:self.filterString sort:@"领取最多"];
            
        }];
        
        
        [as bk_addButtonWithTitle:@"点赞最多" handler:^{
            
            [self doFilterSortData:self.filterString sort:@"点赞最多"];
            
        }];
        
        
        [as bk_addButtonWithTitle:@"订阅最多" handler:^{
            
            [self doFilterSortData:self.filterString sort:@"订阅最多"];

        }];
 
        
        [as bk_setDestructiveButtonWithTitle:@"取消" handler:^{
            
        }];
       
        
        [as showInView:[UIApplication sharedApplication].keyWindow];
       
    } forControlEvents:UIControlEventTouchUpInside];
    
    return uv;
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"mallId"]){//这里只处理balance属性
        
        
        
        [self loadData];
        
        
        NSLog(@"kvo ==== %@",object);
        
    }
}


@end
