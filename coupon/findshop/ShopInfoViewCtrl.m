//
//  ShopDetailViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopInfoViewCtrl.h"
#import "CouponInfoTableViewCell.h"
#import "CouponDetailViewCtrl.h"
#import "ShopCommentViewCtrl.h"
#import "CouponListViewCtrl.h"
#import "MallMapViewCtrl.h"
#import "CouponService.h"
#import "ReloadHud.h"
#import "UISubscribeSevice.h"
#import "MallShopCommentViewController.h"
#import "ShopService.h"
#import "ShopDetailViewCtrl.h"

#import "ReminderService.h"
@interface ShopInfoViewCtrl ()<UMSocialUIDelegate>

@property(nonatomic,strong)NSArray *realTimeCouponList;
@property(nonatomic,strong)NSArray *otherCouponList;
@property(nonatomic,strong)id idDaata;
@property(nonatomic,strong)UILabel *subLabel;
@property(nonatomic,assign)__block  NSInteger inets;
@property(nonatomic,strong)UIImage *titleImageView;
@property(nonatomic,strong)NSDictionary *data;





@end

@implementation ShopInfoViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.tableView = [GUIHelper makeTableView:self.view delegate:self];
    
    
    
    [self.tableView registerClass:[CouponInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self makeHeaderView];
    
    
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 48, 0);
    
    
    
    
        
   
        
        
    
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"arrow"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"分享" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        
        //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
        
        
        NSString *couponName= SafeString(self.data[@"name"]);
        
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:UmengKey
                                          shareText:couponName
                                         shareImage:_titleImageView
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToSina,nil]
                                           delegate:self];
        
        
        
        
        
    }];
    
    
    
    
}


-(void)loadShop{
    
    
    [ReloadHud showHUDAddedTo:self.view reloadBlock:^{
        
        
        [self doLoadShop:^(BOOL ret){
            
            if (ret) {
                [ReloadHud removeHud:self.view animated:YES];
                 [self makeHeaderView];
                [self doLoad:^(BOOL ret) {
                    
                    [self.tableView reloadData];
                    
                    
                }];
                
            }else{
                
                [ReloadHud showReloadMode:self.view];
            }
            
            
        }];
        
        
    }];
    
    
    [self doLoadShop:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.view animated:YES];
            
            [self doLoad:^(BOOL ret) {
                
                [self.tableView reloadData];
                
            }];
            
            
            //  [self makeHeaderView];
            
        }else{
            
            [ReloadHud showReloadMode:self.view];
        }
        
        
    }];
  
    
}




-(void)doLoadShop:(void(^)(BOOL ret))completion{
    
    
    ShopService *service = [ShopService new];
    
    NSString *shopId = _shopId;
    NSLog(@"aaaaaaaaaaaaaaaaa---->%@",shopId);
    [service requestShopInfo:shopId success:^(NSInteger code, NSString *message, id data) {
        self.data = data;
        
        [self.tableView reloadData];
        
        [self makeHeaderView];
        
        completion(YES);
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        [SVProgressHUD showErrorWithStatus:@"数据装载错误"];
        
        completion(NO);
        
        
    }];
    
    
}




-(void)doLoad:(void(^)(BOOL ret))completion{
    
    CouponService *couponService = [CouponService new];
    
    //http://192.168.6.97:8080/diamond-sis-web/v1/couponPromotion?shopid=11&type=即时优惠
    
    //查询实时优惠券信息
    
    //requestRealTimeCoupon
    
    NSString *shopId = SafeString(self.data[@"id"]);
    if (shopId.length == 0) {
         shopId = SafeString(self.data[@"shopId"]);
    }
    [couponService requestRealTimeCoupon:shopId page:1 pageCount:4 success:^(NSInteger code, NSString *message, id data) {
        
        
        self.realTimeCouponList = data;
        
        [self.tableView reloadData];
        
        [self makeHeaderView];
        
        
        completion(YES);
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        [SVProgressHUD showErrorWithStatus:@"网络请求错误！"];
        
        
        completion(NO);
        
        
        
        
        
    }];
  
    //http://192.168.6.97:8080/diamond-sis-web/v1/couponPromotion?shopid=11&type=普通优惠
 
    //查询其他优惠券
    
    [couponService requestNormalCoupon:shopId page:1 pageCount:1 success:^(NSInteger code, NSString *message, id data) {
        
        
        
        if (![data isKindOfClass:[NSArray class]]) {
            
            [SVProgressHUD showErrorWithStatus:@"优惠券数据格式错误"];
            return ;
        }
        
        self.otherCouponList = data;
        
        
        [self.tableView reloadData];
        
        
        
        completion(YES);
        
        
        
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        [SVProgressHUD showErrorWithStatus:@"网络请求错误！"];
        
        completion(NO);
        
        
        
        
    }];
    

    
}

-(void)loadData{
    
    
    [ReloadHud showHUDAddedTo:self.view reloadBlock:^{
        
        
        [self doLoad:^(BOOL ret){
            
            if (ret) {
                [ReloadHud removeHud:self.view animated:YES];
               // [self makeHeaderView];
            }else{
                
                [ReloadHud showReloadMode:self.view];
            }
            
            
        }];
        
        
    }];
    
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.view animated:YES];
            
          //  [self makeHeaderView];
            
        }else{
            
            [ReloadHud showReloadMode:self.view];
        }
        
        
    }];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    static int NAVBAR_CHANGE_POINT = 50;
    
    UIColor * color = [GUIConfig mainColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

#pragma mark - viewWillAppear


-(void)viewWillAppear:(BOOL)animated{
    
    [self loadShop];
    
    [self.tableView reloadData];
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.tableView.delegate = self;
    
    [self scrollViewDidScroll:self.tableView];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationController.navigationBar.translucent = YES;
    
}



-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    self.navigationController.automaticallyAdjustsScrollViewInsets=YES;
    
    
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    
    
  //  self.navigationController.navigationBar.translucent = NO;

   
    
}




#pragma mark - 头部信息
-(void)makeHeaderView{
    
    UIButton *shopBgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat rate = 416.0f/750.0f;
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*rate+30)];
    uv.backgroundColor = [UIColor whiteColor];
    
    [uv addSubview:shopBgButton];
    
//     __block  NSInteger inets = 0;
    
    [shopBgButton bk_addEventHandler:^(id sender) {
        
        ShopDetailViewCtrl *vc = [ShopDetailViewCtrl new];
        
        vc.shopId =SafeString(self.data[@"id"]);
        
        
         
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    {
        //按iphone6 的尺寸设置比率
        
        
        self.navigationItem.title = SafeString(self.data[@"name"]);
        
        NSURL *url = SafeUrl(self.data[@"smallPhotoUrl"]);
        
        if (url==nil) {
            
            url = SafeUrl(self.data[@"photoUrl"]);
            
        }
        
        if (url==nil) {
            
            url = SafeUrl(self.data[@"shopPhotoUrl"]);
            
        }
        
        shopBgButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*rate);
        
        UIImageView *image = [[UIImageView alloc]init];
        [image sd_setImageWithURL:url];
        _titleImageView = image.image;
        
        SafeLoadUrlImage(shopBgButton, url, ^{
            
        });
        
        //[shopBgButton sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
        
        
        
        
        
    }

    UIButton *subButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [shopBgButton addSubview:subButton];
    
    subButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(shopBgButton).offset(-10);
        make.bottom.equalTo(shopBgButton).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@60);
        
    }];
    
    
    subButton.layer.cornerRadius=4;
    subButton.clipsToBounds = YES;
    
    
    [subButton setTitle:@"订阅" forState:UIControlStateNormal];
    

    
    [subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    ShopService *service = [ShopService new];
    
    
    NSString *shopId=@"";
    
    if (!SafeEmpty(self.shopId)) {
        shopId = self.shopId;
    }else{
        
        shopId = SafeString(self.data[@"id"]);
        
    }
    
    [service requestFav:shopId success:^(NSInteger code, NSString *message, id data) {
        
        
        if ([data isKindOfClass:[NSArray class]]) {
            if ([data count]>0) {  //数组有参数才能算订阅成功
                
                _inets = 1;
                
                [subButton setTitle:@"取消订阅" forState:UIControlStateNormal];
                subButton.selected = YES;
                [subButton setUserInteractionEnabled:NO];
                return ;
                
                
            }
            
        }
        
        _inets = 0;
        [subButton setTitle:@"订阅" forState:UIControlStateNormal];
        
        subButton.selected = NO;
            
            
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
       // [subButton setTitle:@"订阅" forState:UIControlStateNormal];
        
        
    }];
    
    NSString *asdasd = SafeString(self.data[@"favorcount"]);
    int inter = [asdasd intValue];
    __block int i = inter;
#pragma mark ----- 点击订阅时的事件
    [subButton bk_addEventHandler:^(id sender) {
        
        
//         _subButtonHandle();
        
       
        
        //拿到按钮的状态
        UIButton *btn = (UIButton*)sender;
        
        //如果按钮为未选中状态（未选中就是taitel为订阅 否则选中状态taitel为未订阅）
        if (!btn.selected) {
            
            ShopService *service = [ShopService new];
            
            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            
            
            [service doFav:shopId success:^(NSInteger code, NSString *message, id data) {
                
                [btn setTitle:@"取消订阅" forState:UIControlStateNormal];
                btn.selected = YES;
                
                [btn setUserInteractionEnabled:NO];
                
                /**
                 *  逻辑有待修改
                 */
//                if (inter>0) {
//                    i = inter;
//                }
//                else{
                i = inter+1;
//                }
                _subLabel.text=[NSString stringWithFormat:@"订阅数 %d",i];

               
                [SVProgressHUD dismiss];
                
                
            } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                
                
                [SVProgressHUD dismiss];
                
                
                
                
            }];

           
        }else{
            
            
            ShopService *service = [ShopService new];
            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            
            
            [service doUnFav:shopId success:^(NSInteger code, NSString *message, id data) {
                
                [btn setTitle:@"订阅" forState:UIControlStateNormal];
                
                btn.selected = NO;
                
                _subLabel.text=[NSString stringWithFormat:@"订阅数 %d",i-1];
                
                
                

                [SVProgressHUD dismiss];
                
                
            } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                
                
                [SVProgressHUD dismiss];
                
                
                
                
            }];
            

            
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    
    
//    UISubscribeSevice *sevice = [UISubscribeSevice new];
//    
//    [sevice string:SafeString(self.data[@"id"]) judgeSuccessful:^(id data) {
//        
//        
//        
//        if (SafeEmpty(data)) {
//            [subButton setTitle:@"取消订阅" forState:UIControlStateNormal];
//            [subButton addTarget:self action:@selector(cancelSubcrideClick:) forControlEvents:UIControlEventTouchUpInside];
//        }
//        
//        else{
//            
//            [subButton setTitle:@"订阅" forState:UIControlStateNormal];
//            [subButton addTarget:self action:@selector(subcrideClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        }
//        
//        
//    } failure:^(id code) {
//        
//    }];
//    
    
    subButton.backgroundColor =[GUIConfig orangeColor];
    
    //[GUIConfig greenBackgroundColor];

    _subLabel = [UILabel new];
    [shopBgButton addSubview:_subLabel];
    _subLabel.font = [UIFont boldSystemFontOfSize:10];
    _subLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _subLabel.numberOfLines = 2;
    _subLabel.textColor = [UIColor whiteColor];
    _subLabel.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.7f];
    //[subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _subLabel.text=[NSString stringWithFormat:@"订阅数 %@",SafeString(self.data[@"favorcount"])];
    
    _subLabel.layer.cornerRadius=4;
    _subLabel.clipsToBounds = YES;
    [_subLabel sizeToFit];
    
//    self.subLabel = _subLabel;
    
    _subLabel.textAlignment = NSTextAlignmentCenter;
    
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(subButton.mas_left).offset(-5);
        make.bottom.equalTo(subButton);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    
    UIView *bottomBar = [[UIView alloc] init];
    [uv addSubview:bottomBar];

    [bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(uv.mas_left);
        make.right.equalTo(uv.mas_right);
        make.top.equalTo(shopBgButton.mas_bottom);
        
    }];
    
    bottomBar.backgroundColor = [UIColor colorWithWhite:0.985 alpha:1.0];
    UIButton *likeButton = [GUIConfig iconGood];

    
    [bottomBar addSubview:likeButton];
    
    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bottomBar.mas_left).with.offset(20);
        make.centerY.equalTo(bottomBar);
    }];
    
    //喜欢按钮
    
    [likeButton bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    //喜欢和不喜欢按钮
    
    {
        UILabel *likeLabel = [UILabel new];
        [bottomBar addSubview:likeLabel];

        
        likeLabel.textColor=[GUIConfig grayFontColor];
        likeLabel.font = [UIFont systemFontOfSize:12];
        likeLabel.text=[NSString stringWithFormat:@"%@",SafeString(self.data[@"good"])];
        
        [likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //make.width.equalTo(@40);
            make.left.equalTo(likeButton.mas_right).with.offset(10);
            make.centerY.equalTo(bottomBar.mas_centerY);
            
        }];
            
        
      
        
        UIButton *unlikeButton = [GUIConfig iconBad];
        
        
        [bottomBar addSubview:unlikeButton];
        
        
        //不喜欢按钮
        [unlikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(likeLabel.mas_right).with.offset(20);
            make.centerY.equalTo(bottomBar);
        }];
        
        
        [unlikeButton bk_addEventHandler:^(id sender) {
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *unlikeLabel = [UILabel new];
        [bottomBar addSubview:unlikeLabel];
        
        
        unlikeLabel.textColor=[GUIConfig grayFontColor];
        unlikeLabel.font = [UIFont systemFontOfSize:12];
        
        unlikeLabel.text=[NSString stringWithFormat:@"%@",SafeString(self.data[@"bad"])];
        
        [unlikeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@40);
            make.left.equalTo(unlikeButton.mas_right).with.offset(10);
            make.centerY.equalTo(bottomBar);
            
        }];
    }
    
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [commentButton setTitleColor:[GUIConfig mainColor] forState:UIControlStateNormal];
    
    NSString *commentString = [NSString stringWithFormat:@"评论(%@)",SafeString(self.data[@"reviewcount"])];
    
    
    [commentButton setTitle:commentString forState:UIControlStateNormal];
    
    commentButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    [bottomBar addSubview:commentButton];
    
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bottomBar.mas_centerX);
        make.centerY.equalTo(bottomBar);

    }];
    
    [commentButton bk_addEventHandler:^(id sender) {
        
        ShopCommentViewCtrl *vc = [ShopCommentViewCtrl new];
        
        vc.hidesBottomBarWhenPushed = YES;
        
//        ShopCommentViewCtrl *vc = [ShopCommentViewCtrl new];
//        
        vc.shopId = SafeString(self.data[@"id"]);
//        
       [self.navigationController pushViewController:vc animated:YES];
//        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.tableView.tableHeaderView = uv;
   
    
}



#pragma mark - 生成


#pragma mark - Table View Config
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CouponDetailViewCtrl *vc = [[CouponDetailViewCtrl alloc] init];
    
    if ([indexPath section]==0) {        
        
        vc.data = self.realTimeCouponList[indexPath.row];
        
    }else{
        
        vc.data = self.otherCouponList[indexPath.row];
        
    }
    
    
    
    
  //  NSDictionary *d = s
    
    
    
    vc.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section==0) {
        
        if ([self.realTimeCouponList count] > 0) {
            return [CouponInfoTableViewCell headerView:@"即时优惠" clickBlock:^{
                
                
                CouponListViewCtrl *vc =[CouponListViewCtrl new];
                
                vc.couponListType = CouponListTypeReminder;
                
                
                //            NSString *shopId = SafeString(self.data[@"id"]);
                //
                //            vc.shopId = shopId;
                //
                
                [self.navigationController pushViewController:vc animated:YES];
                
                
                
                //            NSLog(@"click 即时优惠 ");
                
            }];
        }
        
        

        
        
    }else{
        
        if ([self.otherCouponList count] > 0) {
            return [CouponInfoTableViewCell headerView:@"其他优惠" clickBlock:^{
                
                CouponListViewCtrl *vc =[CouponListViewCtrl new];
                
                
                
                vc.couponListType = CouponListTypeNormal;
                
                //vc.shopId = shopId;
                
                
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }];
        }
        
        
   
        
    }
    
    return [UIView new];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
}

#pragma mark ------ cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    return [CouponInfoTableViewCell height];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if ([self.realTimeCouponList count] == 0 || [self.otherCouponList count] == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        
        if ([self.realTimeCouponList count] == 0) {
            return 0;
        }
        
        return [self.realTimeCouponList count];
        
    }
    else{
        
        if ([self.otherCouponList count] == 0) {
            return 0;
        }
        
        return [self.otherCouponList count];
        
        
    }
    
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
    if ([indexPath section]==0) {
        
        cell.couponActionType = CouponTypeLimited;
        
        
        
        
        
        
        NSMutableDictionary *d = [self.realTimeCouponList[indexPath.row] mutableCopy];
        
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
        
        
        

        
         
        
        
        
        
        
        
    }else{
        
        cell.couponActionType = CouponTypeNormal;
        
        NSDictionary *d = self.otherCouponList[indexPath.row];
        
        cell.data =d;
        
        [cell updateData];
        
    }
    
    
    
    // Configure the cell...
    
    return cell;
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
