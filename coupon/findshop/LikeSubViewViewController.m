//
//  LikeSubViewViewController.m
//  coupon
//
//  Created by ZZL on 16/6/2.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "LikeSubViewViewController.h"
#import "CartViewCtrl.h"
#import "ToPayTableViewCtrl.h"

#import "UINavigationBar+Awesome.h"
#import "AppShareData.h"
#import "ThrowLineTool.h"
#import "BasketContainerViewCtrl.h"
#import "BasketService.h"
#import "CouponService.h"
#import "GoToMapViewCtrl.h"
#import "ShoppingCartSevice.h"
#import "BasketNotUseTableViewCell.h"
#import "ShakeService.h"
#import "CouponDetailViewCtrl.h"
@interface LikeSubViewViewController ()

@property(nonatomic,strong)UILabel   *cartNumLabel;
@property(nonatomic,strong)UIButton *cartButton;
@property(nonatomic,strong)UIImage *couponImage;

@property(nonatomic,strong)NSDictionary *bttonTabelViewDic;

@property(nonatomic,strong)CouponDetailViewCtrl *CDVC;
@end

@implementation LikeSubViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _CDVC = [CouponDetailViewCtrl new];
    NSLog(@"ahhahahhahahahahhahaha----------------------------------<>%@",_data);
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    //    [self likeButtonLoadData];
    self.tableView = [[UITableView alloc] init];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-64);
        make.width.equalTo(self.view);
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        // make.height.equalTo(@45);
        make.bottom.equalTo(self.view);
    }];
    
    
    
    
    
    [self.tableView registerClass:[BasketNotUseTableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationItem.title=@"优惠详情";
    
    
    
    
//    [self makeHeaderView];
    
    
    
    if (self.couponDetailType == CouponDetailTypeHaveCarts) {
        
        [self makeBottomView];
        
        [self makeCartView];
        
    }
    
    
//    if (self.couponDetailPushMode == CouponDetailPushModePresent) {
//        
//        
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"关闭" style:UIBarButtonItemStylePlain handler:^(id sender) {
//            
//            [self dismissViewControllerAnimated:YES completion:^{
//                
//            }];
//            
//        }];
//        
//    }
    
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[UIColor whiteColor]];
    
    
    //暂时注释
    //    if (self.couponViewMode == CouponViewModeNetwork) { //需要通过网络装载
    //
    //        [self loadData];
    //
    //    }
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"分享" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        
        //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
        
        
        NSString *couponName= SafeString(self.data[@"name"]);
        
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:UmengKey
                                          shareText:couponName
                                         shareImage:self.couponImage
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToSina,nil]
                                           delegate:self];
        
        
        
        
        
    }];
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    
    
    
}


//暂时注释
//-(void)loadData{
//
//
//    [ReloadHud showHUDAddedTo:self.tableView reloadBlock:^{
//
//
//        [self doLoad:^(BOOL ret){
//
//            if (ret) {
//                [ReloadHud removeHud:self.tableView animated:YES];
//            }else{
//
//                [ReloadHud showReloadMode:self.tableView];
//            }
//
//
//        }];
//
//
//    }];
//
//
//    [self doLoad:^(BOOL ret){
//
//        if (ret) {
//            [ReloadHud removeHud:self.tableView animated:YES];
//        }else{
//
//            [ReloadHud showReloadMode:self.tableView];
//        }
//
//
//    }];
//
//
//
//}

//暂时注释
//-(void)doLoad:(void(^)(BOOL ret))completion{
//
//
//    CouponService *service = [CouponService new];
//
//
//
//    [service requestCouponInfo:self.couponId success:^(NSInteger code, NSString *message, id data) {
//
//
//        self.data = data[@"coupon"];
//
//        [self makeHeaderView];
//
//        [self.tableView reloadData];
//
//        completion(YES);
//
//
//
//    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
//
//
//        [self makeHeaderView];
//
//
//
//
//        completion(NO);
//
//
//
//
//    }];
//
//
//
//
//
//
//}







-(void)makeCartView{
    
    
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cartButton setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
    
    cartButton.frame = CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-150, 60, 60);
    
    //    cartButton.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    //
    cartButton.clipsToBounds = YES;
    cartButton.layer.cornerRadius = 30;
    [self.view addSubview:cartButton];
    
    self.cartButton = cartButton;
    
    
    [cartButton bk_addEventHandler:^(id sender) {
        
        
        BasketContainerViewCtrl *vc =[[BasketContainerViewCtrl alloc] init];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
        
        
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    self.cartNumLabel = [UILabel new];
    
    
    [self.view addSubview:self.cartNumLabel];
    
    [self.cartNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cartButton.mas_right).offset(-15);
        make.top.equalTo(cartButton.mas_top).offset(9);
        make.width.equalTo(@14);
        make.height.equalTo(@14);
        
        
    }];
    
    self.cartNumLabel.layer.cornerRadius=7;
    self.cartNumLabel.font = [UIFont boldSystemFontOfSize:10];
    self.cartNumLabel.textColor = [UIColor whiteColor];
    self.cartNumLabel.clipsToBounds = YES;
    self.cartNumLabel.backgroundColor = [UIColor redColor];
    self.cartNumLabel.text=@"";
    self.cartNumLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    [self updateCartNum];
    
    
    
    
    
    
    
    
}

-(void)updateCartNum{
    
    
    NSUInteger count = [[AppShareData instance] getCartCount];
    
    if (count==0) {
        self.cartNumLabel.text=@"";
        self.cartNumLabel.hidden = YES;
    }else{
        
        self.cartNumLabel.text = [NSString stringWithFormat:@"%ld",count];
        self.cartNumLabel.hidden = NO;
    }
    
    
    
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)makeHeaderView{
    
    //    CGFloat rate = 416.0f/750.0f;
    
    //    NSLog(@"-------------------------hahhahahhahaha-------------------------------------%@",self.data);
    
    UIImageView *uv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    uv.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = SafeUrl(self.data[@"photoUrl"]);
    
    if (!url) {
        
        url =  SafeUrl(self.data[@"smallPhotoUrl"]);
        
    }
    
    
    
    
    SafeLoadUrlImage(uv, url, ^{
        
        [self.view setNeedsLayout];
        
        
    });
    
    
    self.tableView.tableHeaderView = uv;
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self otherButtonLoadData];
    
    ShoppingCartSevice *SCS = [ShoppingCartSevice new];
    NSString *cu = [NSString stringWithFormat:@"%@",[AppShareData instance].customId];
    [SCS soppingCartRequestUserId:cu withstatus:@"未消费" withSuccessful:^(id data) {
        [AppShareData instance].shoppingNumberl = [data[@"amount"] integerValue];
    } withFailure:^(id data) {
        
    }];
    [self makeHeaderView];
    [_tableView reloadData];
}

-(void)makeBottomView{
    
    UIView *uv = [UIView new];
    
    uv.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:uv];
    
    [uv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.height.equalTo(@60);
        make.left.right.equalTo(self.view);
        
    }];
    
    
    UIView *hLine = [UIView new];
    [uv addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.width.equalTo(uv);
        make.left.equalTo(uv);
        make.top.equalTo(uv);
        
        
    }];
    
    hLine.backgroundColor = [GUIConfig mainBackgroundColor];
    
    
    
    UIButton *addCartButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addCartButton.backgroundColor = UIColorFromRGB(249, 191, 66);
    
    [uv addSubview:addCartButton];
    
    [addCartButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(uv).offset(-40);
        make.left.equalTo(uv).offset(40);
        make.top.equalTo(uv).offset(10);
        make.bottom.equalTo(uv).offset(-10);
    }];
    
    int bools = [self.data[@"addedToBasket"] intValue];
    
    if (bools == 1) {
        addCartButton.layer.cornerRadius = 7;
        addCartButton.backgroundColor = [UIColor grayColor];
        [addCartButton setTitle:@"已领取过了，明天再来吧" forState:UIControlStateNormal];
        [addCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addCartButton setUserInteractionEnabled:NO];
        
    }
    else{
        [addCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addCartButton setTitle:@"加入篮子" forState:UIControlStateNormal];
        addCartButton.layer.cornerRadius = 7;
        [addCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [addCartButton bk_addEventHandler:^(id sender) {
            
            //判断是否已经登陆
            if (![AppShareData instance].isLogin) {
                
                SafePostMessage(NoLoginNotice, @"");
                
                return ;
                
            }
            
            // [self loadData];
            
            ThrowLineTool *tool = [[ThrowLineTool alloc] init];
            
            UIView *ballView = [[UIView alloc] initWithFrame:CGRectMake(addCartButton.frame.origin.x+SCREEN_WIDTH/8, SCREEN_HEIGHT-60,20, 20)];
            
            ballView.backgroundColor = [UIColor redColor];
            
            ballView.layer.cornerRadius =ballView.frame.size.width;
            
            [self.view addSubview:ballView];
            
            CGFloat startX = ballView.frame.origin.x;//arc4random() % (NSInteger)CGRectGetWidth(self.frame);
            CGFloat startY = ballView.frame.origin.y;//CGRectGetHeight(self.frame);
            CGFloat endX = CGRectGetMidX(self.cartButton.frame)+25;
            CGFloat endY = CGRectGetMidY(self.cartButton.frame)-15;
            CGFloat height = -100;
            [tool throwBall:ballView
                       from:CGPointMake(startX, startY)
                         to:CGPointMake(endX, endY)
                     height:height duration:0.5];
            
            __weak id weakSelf =self;
            
            tool.didFinishBlock = ^(){
                
                [ballView removeFromSuperview];
                
                [self addCouponToBasket:^(BOOL ret){
                    
                    if (ret) {
                        [weakSelf updateCartNum];
                        
                        [addCartButton setTitle:@"已领取" forState:UIControlStateNormal];
                        [addCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        addCartButton.backgroundColor = [UIColor grayColor];
                        [addCartButton setUserInteractionEnabled:NO];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshFindShopTableView" object:nil];
                        
                    }
                    
                }];
                
            };
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addCouponToBasket:(void(^)(BOOL ret))completion{
    
    
    BasketService * service  = [BasketService new];
    
    
    NSString *couponId = self.data[@"id"];
    
    [service requestADDBasket:couponId count:1 success:^(NSInteger code, NSString *message, id data) {
        
        
        
        [[AppShareData instance] addCouponToCart:self.data];
        
        
        completion(YES);
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        completion(NO);
        
        
        [SVProgressHUD showErrorWithStatus:@"加入篮子失败"];
        
        
        
    }];
    
}



#pragma mark - TableViewCell
-(void)makeCell1:(UITableViewCell*)cell{
    
    
    
    //    UILabel *shopNameLabel = [UILabel new];
    //
    //    [cell.contentView addSubview:shopNameLabel];
    //
    //    shopNameLabel.font = [UIFont boldSystemFontOfSize:16];
    //    shopNameLabel.textColor = [GUIConfig grayFontColorDeep];
    //    [shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
    //        make.top.equalTo(cell.contentView.mas_top).with.offset(20);
    //        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
    //        make.height.equalTo(@20);
    //
    //    }];
    
    //    shopNameLabel.text=SafeString(self.data[@"shopName"]);
    
    
    UILabel *couponNameLabel = [UILabel new];
    [cell.contentView addSubview:couponNameLabel];
    couponNameLabel.font = [UIFont systemFontOfSize:18];
    couponNameLabel.textColor = [GUIConfig mainColor];
    
    [couponNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(cell.contentView).offset(20);
        
        make.centerY.equalTo(cell.contentView);
        make.height.equalTo(@20);
        
    }];
    couponNameLabel.text=[NSString stringWithFormat:@"%@",SafeString(self.data[@"name"])];
    
    
}

-(void)makeCell2:(UITableViewCell*)cell{
    
    
    UILabel *addressLabel = [UILabel new];
    
    [cell.contentView addSubview:addressLabel];
    
    addressLabel.font = [UIFont boldSystemFontOfSize:16];
    addressLabel.textColor = [GUIConfig grayFontColorDeep];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(cell.contentView.mas_top).with.offset(10);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@30);
        
    }];
    
    
    addressLabel.text=SafeString(self.data[@"shopName"]);
    
    UIView *line = [GUIConfig line];
    
    [cell.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.top.equalTo(addressLabel.mas_bottom).offset(10);
        make.right.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(10);
        
        
    }];
    
    
    UIButton *callPhoneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [cell.contentView addSubview:callPhoneButton];
    
    [callPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.left.and.bottom.equalTo(cell.contentView);
        make.top.equalTo(line);
    }];
    
    [callPhoneButton setTitle:@"拨打电话" forState:UIControlStateNormal];
    
    [callPhoneButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    
    [callPhoneButton bk_addEventHandler:^(id sender) {
        
        //phone
        
        NSString *phone = SafeString(self.data[@"shopPhone"]);
        
        NSString *phoneString=[NSString stringWithFormat:@"telprompt://%@",phone];
        NSLog(@"phoneString电话-----》 %@",phoneString);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *gotoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [cell.contentView addSubview:gotoButton];
    
    [gotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH/2);
        
        make.right.and.bottom.equalTo(cell.contentView);
        make.top.equalTo(line);
    }];
    
    [gotoButton setTitle:@"去到这里" forState:UIControlStateNormal];
    
    [gotoButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    
    
    [gotoButton bk_addEventHandler:^(id sender) {
        
        GoToMapViewCtrl *vc = [GoToMapViewCtrl new];
        vc.hidesBottomBarWhenPushed = YES;
        
        
        CLLocationCoordinate2D loc;
        loc.latitude = [self.data[@"latitude"] floatValue];
        loc.longitude = [self.data[@"longitude"] floatValue];
        vc.endLocation = loc;
        
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *line2 = [GUIConfig line];
    
    [cell.contentView addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@1);
        make.top.equalTo(gotoButton).offset(10);
        make.bottom.equalTo(gotoButton).offset(-10);
        make.left.equalTo(gotoButton);
        
    }];
    
    
}

-(void)makeCell3:(UITableViewCell*)cell{
    
    
    UILabel *nameLabel = [UILabel new];
    
    [cell.contentView addSubview:nameLabel];
    
    nameLabel.font = [UIFont boldSystemFontOfSize:14];
    nameLabel.textColor = [GUIConfig grayFontColorDeep];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.centerY.equalTo(cell.contentView);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        
    }];
    
    nameLabel.text=@"有效时间:";
    
    UILabel *limitTimeLabel = [UILabel new];
    
    [cell.contentView addSubview:limitTimeLabel];
    
    limitTimeLabel.font = [UIFont systemFontOfSize:14];
    limitTimeLabel.textColor = [GUIConfig grayFontColor];
    [limitTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).with.offset(20);
        make.centerY.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView).offset(-20);
        make.height.equalTo(@20);
    }];
    
    limitTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    limitTimeLabel.text = [NSString stringWithFormat:@"%@ ~ %@", SafeString(self.data[@"startTime"]),SafeString(self.data[@"endTime"])];
    
    
}




-(void)makeCell4:(UITableViewCell*)cell{
    
    
    UILabel *commentTitleLabel = [UILabel new];
    
    [cell.contentView addSubview:commentTitleLabel];
    
    commentTitleLabel.font = [UIFont boldSystemFontOfSize:16];
    commentTitleLabel.textColor = [GUIConfig grayFontColorDeep];
    [commentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(cell.contentView.mas_top).with.offset(10);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@20);
        
    }];
    
    commentTitleLabel.text=@"使用须知:";
    
    UIView *line = [GUIConfig line];
    
    [cell.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.top.equalTo(commentTitleLabel.mas_bottom).offset(10);
        make.right.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(10);
        
        
    }];
    
    
    UILabel *commentLabel = [UILabel new];
    
    [cell.contentView addSubview:commentLabel];
    
    commentLabel.font = [UIFont boldSystemFontOfSize:16];
    commentLabel.textColor = [GUIConfig grayFontColorDeep];
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(line.mas_top).with.offset(5);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@80);
        
    }];
    
    
    commentLabel.textColor = [GUIConfig grayFontColor];
    commentLabel.font = [UIFont systemFontOfSize:14];
    commentLabel.numberOfLines=0;
    commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    commentLabel.text=@"1、商品说明：一次消费只能使用一张优惠券\n2、预约：免预约，消费高峰期可能";
    
    
    
}


#pragma mark - Table view config


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([indexPath section]==0) {
        return 50;
    }
    
    
    if ([indexPath section]==2) {
        return 50;
    }
    
    if ([indexPath section]==3) {
        return 130;
    }
    
    if ([indexPath section]== 4) {
        return 100;
    }
    
    return 100;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }else if(section==4){
        
        return 60;
    }else{
        
        return 20;
    }
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section == 4) {
        
        UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20+40)];
        
        uv.userInteractionEnabled = YES;
        
        uv.backgroundColor = [GUIConfig mainBackgroundColor];
        
        
        UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [otherButton setTitle:@"其他优惠" forState:UIControlStateNormal];
        [uv addSubview:otherButton];
        [otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(uv);
            make.top.equalTo(uv).offset(20);
            make.bottom.equalTo(uv);
            make.width.equalTo(@(SCREEN_WIDTH/2));
        }];
        
        [otherButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
        
        otherButton.backgroundColor = [UIColor whiteColor];
        
        
        UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [likeButton setTitle:@"猜你喜欢" forState:UIControlStateNormal];
        [uv addSubview:likeButton];
        [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(otherButton.mas_right);
            make.top.equalTo(uv).offset(20);
            make.bottom.equalTo(uv);
            make.width.equalTo(@(SCREEN_WIDTH/2));
        }];
        
        likeButton.backgroundColor = [UIColor whiteColor];
        
        [likeButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
        
        
        UIView *vLine = [UIView new];
        [uv addSubview:vLine];
        [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@1);
            make.height.equalTo(@30);
            make.centerX.equalTo(uv);
            make.top.equalTo(uv).offset(25);
            
            
        }];
        
        vLine.backgroundColor = [GUIConfig mainBackgroundColor];
        
        UIView *hLine = [UIView new];
        [uv addSubview:hLine];
        [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@1);
            make.width.equalTo(uv);
            make.left.equalTo(uv);
            make.bottom.equalTo(uv);
            
            
        }];
        
        hLine.backgroundColor = [GUIConfig mainBackgroundColor];
        
        [otherButton bk_addEventHandler:^(id sender) {
            
            [self otherButtonLoadData];
            
            
            
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        [likeButton bk_addEventHandler:^(id sender) {
            
            [self likeButtonLoadData];
            
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        
        // btn1.layer.borderWidth=1;
        
        return uv;
        
    }
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    uv.backgroundColor = [GUIConfig mainBackgroundColor];
    
    return uv;
    
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    for (UIView *uv in [cell.contentView subviews]) {
        [uv removeFromSuperview];
    }
    
    if ([indexPath section]==0) {
        
        [self makeCell1:cell];
        
        
        
    }
    
    if ([indexPath section]==1) {
        
        
        [self makeCell2:cell];
        
        
        
        
    }
    
    if ([indexPath section]==2) {
        
        [self makeCell3:cell];
        
    }
    
    
    if ([indexPath section]==3) {
        
        [self makeCell4:cell];
        
    }
    
    if ([indexPath section]==4) {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [self makeCell5:cell];
        
    }
    
    return cell;
}

-(void)makeCell5:(UITableViewCell *)cell{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(cell.contentView).offset(10);
        make.bottom.equalTo(cell.contentView).offset(-10);
        make.left.equalTo(cell.contentView).offset(10);
        make.width.equalTo(@100);
        
    }];
    
    NSURL *url = SafeUrl(_bttonTabelViewDic[@"smallPhotoUrl"]);
    SafeLoadUrlImage(imageView, url, ^{
        
        [cell setNeedsLayout];
        
        
    });
    
    
    UILabel *titleLable = [[UILabel alloc]init];
    [cell.contentView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).offset(10);
        make.left.equalTo(cell.contentView).offset(120);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
    titleLable.text = SafeString(_bttonTabelViewDic[@"shopName"]);
    titleLable.textColor = UIColorFromRGB(160, 160, 160);
    titleLable.font = [UIFont systemFontOfSize:14];
    
    UILabel *subTitleLable = [[UILabel alloc]init];
    [cell.contentView addSubview:subTitleLable];
    [subTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).offset(50);
        make.left.equalTo(cell.contentView).offset(120);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
    subTitleLable.text = SafeString(_bttonTabelViewDic[@"name"]);
    subTitleLable.font = [UIFont systemFontOfSize:12];
    subTitleLable.textColor = UIColorFromRGB(200, 200, 200);
    
};

-(void)loadShakeData:(void(^)(BOOL ret))completion{
    
    
    ShakeService *service = [ShakeService new];
    
    
    NSString *customId = [AppShareData instance].customId;
    
    NSString *mallId = [AppShareData instance].mallId;
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    [service requestShakeCoupon:customId shopMallId:mallId withCity:@"" success:^(NSInteger code, NSString *message, id data) {
        
        
        [SVProgressHUD dismiss];
        self.bttonTabelViewDic = data[0];
        //        self.data = data;
        _CDVC.data = data[0];
        [_tableView reloadData];
        completion(YES);
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        [SVProgressHUD dismiss];
        
        
        completion(NO);
        
        
    }];
    
    
    
}

-(void)doLoad:(void(^)(BOOL ret))completion{
    
    //http://192.168.6.97:8080/diamond-sis-web/v1/couponPromotion?shopid=11&type=普通优惠
    
    //查询其他优惠券
    
    CouponService *couponService = [CouponService new];
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [couponService requestNormalCoupon:@"11" page:1 pageCount:1 success:^(NSInteger code, NSString *message, id data) {
        
        [SVProgressHUD dismiss];
        NSArray *arr = [data mutableCopy];
        if (arr.count != 0) {
            _CDVC.data = data[0];
            _bttonTabelViewDic = data[0];
        }
        
        [_tableView reloadData];
        
        completion(YES);
        
        
        
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        [SVProgressHUD showErrorWithStatus:@"网络请求错误！"];
        
        completion(NO);
        
        
        
        
    }];
    
    
}

//猜你喜欢
-(void)likeButtonLoadData{
    
    [self loadShakeData:^(BOOL ret){
        
        if (ret) {
            
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"网络错误，请重试！"];
            
        }
        
    }];
    
}


//其他优惠
-(void)otherButtonLoadData{
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.view animated:YES];
            // [self makeHeaderView];
        }else{
            
            [ReloadHud showReloadMode:self.view];
        }
        
        
    }];
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    if ([indexPath section]==4) {
        
        //        self.LSVVC.data = _bttonTabelViewDic;
        [self.navigationController pushViewController:self.CDVC animated:YES];
    };
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
