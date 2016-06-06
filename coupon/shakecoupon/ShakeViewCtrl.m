//
//  ShakeViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShakeViewCtrl.h"
#import "ShakeCouponViewCtrl.h"
#import "SelectCityTableViewCtrl.h"
#import "SelectMallTableCtrl.h"
#import "SelectMallPopViewCtrl.h"
#import "SimpleAudioPlayer.h"
#import "MallService.h"
#import "ShakeService.h"
#import "AppShareData.h"
#import "ShoppingCartSevice.h"
@interface ShakeViewCtrl ()

@property(nonatomic,strong)UIScrollView *contentView;
@property(nonatomic,assign)BOOL audioOn;
@property(nonatomic,strong)UIButton *mallButton;

@property(nonatomic,assign)BOOL isShakeDataLoaded;
@property(nonatomic,strong)CLLocationManager *lcManager;



@end

@implementation ShakeViewCtrl

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    //每次重新打开软件的时候都定位一次
//    [self doRequestMall];
    
    self.isShakeDataLoaded = NO;
//
    [self makeContentView];
    
    [self makeBarItem];
//    
   [self makeShakeBody];
//
    [self makeAudioControl];
    
    
//    [self loadShakeData:^(BOOL ret){
//        
//        self.isShakeDataLoaded = ret;
//    }];
//    
//    
//    [[AppShareData instance] addMallIdKVO:self];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(positioningQWE) name:@"positioning" object:nil];
    
}



-(void)positioningQWE{

    //每次重新打开软件的时候都定位一次
    [self doRequestMall];
    
    [self makeContentView];
    
    [self makeBarItem];
    
    [self makeShakeBody];
    
//    [self makeAudioControl];
    
    
    [self loadShakeData:^(BOOL ret){
        
        self.isShakeDataLoaded = ret;
    }];
    
    
    [[AppShareData instance] addMallIdKVO:self];

}

-(void)viewWillAppear:(BOOL)animated{
    
    
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    
    [super viewWillAppear:animated];
    
    
    [self makeBarItem];
    
    ShoppingCartSevice *SCS = [ShoppingCartSevice new];
    NSString *cu = [NSString stringWithFormat:@"%@",[AppShareData instance].customId];
    [SCS soppingCartRequestUserId:cu withstatus:@"未消费" withSuccessful:^(id data) {
        [AppShareData instance].shoppingNumberl = [data[@"amount"] integerValue];
    } withFailure:^(id data) {
        
    }];
    
    if ([[AppShareData instance] isNeedLocationUpdate]) {
        
        [self requestLocation];

        
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCarNumber) name:@"refreshShopingCarNumber" object:nil];
    
}

-(void)refreshCarNumber{

    ShoppingCartSevice *SCS = [ShoppingCartSevice new];
    NSString *cu = [NSString stringWithFormat:@"%@",[AppShareData instance].customId];
    [SCS soppingCartRequestUserId:cu withstatus:@"未消费" withSuccessful:^(id data) {
        [AppShareData instance].shoppingNumberl = [data[@"amount"] integerValue];
    } withFailure:^(id data) {
        
    }];
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshShopingCarView" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"refreshShopingCarNumber" object:nil];

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
   
    
}


-(void)dealloc{
    
    
    [[AppShareData instance] removeMallIdKVO:self];

    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"mallId"]){//这里只处理balance属性
 
    
        NSLog(@"kvo ==== %@",object);
    
    }
}


#pragma mark -

#pragma mark - 请求定位数据
-(void)requestLocation{
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        // 创建位置管理者对象
        self.lcManager = [[CLLocationManager alloc] init];
        self.lcManager.delegate = self; // 设置代理
        // 设置定位距离过滤参数 (当本次定位和上次定位之间的距离大于或等于这个值时，调用代理方法)
        self.lcManager.distanceFilter = 100;
        self.lcManager.desiredAccuracy = kCLLocationAccuracyBest; // 设置定位精度(精度越高越耗电)
        [self.lcManager startUpdatingLocation]; // 开始更新位置
        
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        [self.lcManager requestWhenInUseAuthorization];//⓵只在前台开启定位
        //[self.lcManager requestAlwaysAuthorization];//⓶在后台也可定位
    }
    // 5.iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        //self.lcManager.allowsBackgroundLocationUpdates = YES;
    }
    
    
    
    //[self.lcManager startUpdatingLocation];
    
    

    
    
}


/**
 *  请求当前的商场
 *
 *  @param completion 完成回调
 
 */
-(void)requestCurrentMall:(void(^)(id data))completion{
    
#pragma mark ------ 周边商城网络请求
    MallService *services = [[MallService alloc] init];
    [services queryMallByNear:SafeString([AppShareData instance].city) lon:[AppShareData instance].lon
     lat:[AppShareData instance].lat success:^(NSInteger code, NSString *message, id data) {
        
        
    
        if (data ==nil) {
            completion(nil);
            return ;
        }
        
        if (![data isKindOfClass:[NSArray class]]) {
            completion(nil);
            return ;
            
        }
        
        
        if([data count]<1){
            
            completion(nil);
            return ;
        }
        
        //获取第一个默认的商城
        completion(data[0]);
       // completion();
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
    }];
    
    
    
}


#pragma mark - 装载摇一摇优惠券数据

-(void)loadShakeData:(void(^)(BOOL ret))completion{
    
    
    ShakeService *service = [ShakeService new];
    
    
    NSString *customId = [AppShareData instance].customId;
    
    NSString *mallId = [AppShareData instance].mallId;
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    [service requestShakeCoupon:customId shopMallId:mallId withCity:[AppShareData instance].mallCityName success:^(NSInteger code, NSString *message, id data) {
        
        self.isShakeDataLoaded = YES;
        
        [[AppShareData instance].shakeCouponQueue resetData:data];
        
        [SVProgressHUD dismiss];
        
        
        completion(YES);
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        [SVProgressHUD dismiss];
        
        
        completion(NO);
        
        
    }];
    
   
    
}

#pragma mark - 创建首页内容视图

-(void)makeContentView{
    
    
    self.view.backgroundColor = [GUIConfig grayFontColor];
    
    self.contentView = [UIScrollView new];
    
    [self.view addSubview:self.contentView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat FrameHeight = self.view.frame.size.height-[GUIConfig tabBarHeight];
    
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, FrameHeight);
    
    //暂时只用一个页面
    self.contentView.contentSize = CGSizeMake(self.view.frame.size.width, FrameHeight);
    
    self.contentView.pagingEnabled = YES;
    
    self.contentView.showsVerticalScrollIndicator = NO;
    
    
    
    
    
}


#pragma mark - 声音图标

-(void)makeAudioControl{
    
    
    self.audioOn = YES;
    
    UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:audioButton];
    [audioButton setImage:[UIImage imageNamed:@"soundon"] forState:UIControlStateNormal];
    
    [audioButton setImage:[UIImage imageNamed:@"soundoff"] forState:UIControlStateSelected];
    
    
    
    
    [audioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        
    }];
    
    
    [audioButton bk_addEventHandler:^(id sender) {
        
        
        
        audioButton.selected = !audioButton.selected;
        
        
        [[AppShareData instance] openAudio:!audioButton.selected];
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:audioButton];
    
    
    
    
}


#pragma mark - 动画小图标
-(void)makeAnimateView:(UIView*)shakeLogo parentView:(UIView*)parentView{
    
    
    NSArray *paths = @[[[NSBundle mainBundle] pathForResource:@"animation_01" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_02" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_03" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_04" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_05" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_06" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_07" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_08" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_09" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_10" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_11" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_12" ofType:@"png"]
                       
                       ];
    NSArray *times = @[@0.08, @0.08, @.08,@.08,@0.08,@0.08,@0.08, @0.08, @.08,@0.08,@0.08,@0.08];
    
    UIImage *image = [[YYFrameImage alloc] initWithImagePaths:paths frameDurations:times loopCount:0];
    
    
    UIImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    
    [parentView addSubview:imageView];
    
    [parentView addSubview:imageView];

    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(parentView).offset(100);
        make.centerY.equalTo(parentView).offset(130);
        make.width.equalTo(@(220/3));
        make.height.equalTo(@(370/3));

    }];
    
    
    
    
}

#pragma mark - 摇一摇主图片

/**
 *  摇换主界面，
 */
-(void)makeShakeBody{
    
    
    CGFloat FrameHeight = self.view.frame.size.height-[GUIConfig tabBarHeight];
    
    NSArray *ary = @[@"sampleImg010.png"];
   
    int pos=0;
    
    for (NSString *content in ary) {
       
        UIView *uv = [UIView new];
        uv.backgroundColor =[GUIConfig mainBackgroundColor];
        
        NSString *imgFile = content;
        
        uv.frame = CGRectMake(0, pos*FrameHeight, SCREEN_WIDTH,FrameHeight);
       
        UIImage *img = [UIImage imageNamed:imgFile];
       
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];

        CGFloat x = (uv.frame.size.width - imgView.frame.size.width)/2;
        CGFloat y = (uv.frame.size.height - imgView.frame.size.height)/2;

        imgView.userInteractionEnabled = YES;
       
        UITapGestureRecognizer *rg = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
           
           
            
        }];
        
        [imgView addGestureRecognizer:rg];

        CGRect r = imgView.frame;

        r.origin.x = x;
        r.origin.y = y;

        imgView.frame = r;
        
        [self.contentView addSubview:uv];
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,FrameHeight)];
        
        bgView.image = [UIImage imageNamed:@"mainpagebg"];
        
        [uv addSubview:bgView];
        
        UIImageView *ballView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guangzhoufood.png"]];
        
        [uv addSubview:ballView];
        
        [ballView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@200);
            make.width.equalTo(@200);
            make.centerX.equalTo(uv);
            make.centerY.equalTo(uv).offset(-30);
            
        }];
       
        [self makeAnimateView:imgView parentView:uv];
        
        
    }

}


#pragma mark- 导航栏按钮

-(void)makeBarItem{
    
    
    UIBarButtonItem *addressBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"location_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
     
        
        SelectCityTableViewCtrl *vc = [SelectCityTableViewCtrl new];
        
       // vc.hidesBottomBarWhenPushed = YES;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
        vc.selectBlock = ^(NSString *city){
            
            [[AppShareData instance] setCity:city];
            
            [self doRequestMall];
            
            
        };

        
        
        
        
    }];
    
    
    NSString *city = [AppShareData instance].city;
   
    UIBarButtonItem *addressNameBarItem = [[UIBarButtonItem alloc] bk_initWithTitle:city style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        SelectCityTableViewCtrl *vc = [SelectCityTableViewCtrl new];
        
        // vc.hidesBottomBarWhenPushed = YES;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
        
        
        vc.selectBlock = ^(NSString *city){
            
            [[AppShareData instance] setCity:city];
            
            [self doRequestMall];
            
            
        };
        
    }];
    
    
    self.navigationItem.leftBarButtonItems = @[addressBarItem,addressNameBarItem];
    
  //  self.navigationItem.rightBarButtonItem = scanerBarItem;
    
    
    UIButton *mallButton = [UIButton buttonWithType:UIButtonTypeSystem];
    mallButton.frame = CGRectMake(0, 0, 150, 44);
    [mallButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    mallButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    [mallButton setTitle:[AppShareData instance].mallName forState:UIControlStateNormal];
    
    
    
    
    self.mallButton =mallButton;
    
    
    self.navigationItem.titleView = mallButton;
    
    
    
    [mallButton bk_addEventHandler:^(id sender) {
        
        
        
        SelectMallPopViewCtrl *vc = [SelectMallPopViewCtrl new];
        
        [Utils popTransparentViewCtrl:self childViewCtrl:vc];
        
        vc.selectMallBlock = ^(BOOL ret ,NSDictionary *mall){
            
            
            NSString *name = [NSString stringWithFormat:@"%@",SafeString(mall[@"name"])
                              /*,SafeString(mall[@"distance"])*/];
            [[AppShareData instance] setMallCityNameKey:SafeString(mall[@"city"])];
            
            [[AppShareData instance] setMallName:SafeString(mall[@"name"])];
            
            [[AppShareData instance] saveMallId:SafeString(mall[@"id"])];
            
            NSLog(@"qweqweqweqweqweqwe>>>>>>>>>>>>>>>>>>>>>>>>>>>>%@---",[AppShareData instance].mallName);
            
            
            
            [self.mallButton setTitle:name forState:UIControlStateNormal];
        };
        vc.tabelViewRefresh = ^(id data){
        
        };
      
    } forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 装载商城
-(void)doRequestMall{
    
    [self requestCurrentMall:^(id data) {
        
        NSString *mallId = SafeString(data[@"id"]);
        
        NSString *mallName = SafeString(data[@"name"]);
        
        
        //存储为当前的mallid
        
        [[AppShareData instance] saveMallId:mallId];
        [[AppShareData instance] setMallName:mallName];
        
        [self makeBarItem];
        
    }];
    

    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向得出位置城市信息
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSString *city = placeMark.locality;
            
            CGFloat lat = placeMark.location.coordinate.latitude;
            
            CGFloat lon = placeMark.location.coordinate.longitude;
            
            
            //            SPVC.cityBlockView(self.city);
            
            [[AppShareData instance] setCity:city];
            
            [[AppShareData instance] setLat:lat];
            
            [[AppShareData instance] setLon:lon];
            
            [[AppShareData instance] setLastLocationDate:[NSDate date]];
            
            
            
            
        } else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error returned");
        } else if (error) {
            [iConsole error:@"定位出错 %@",error];
            
        }
    }];
    
    //[manager stopUpdatingLocation];
}




#pragma mark - 装载摇一摇控制器
-(void)doLoadShakeView{
    
    if ([AppShareData instance].isAudioOpen) {
        
            [SimpleAudioPlayer playFile:@"shake_sound_male1.mp3"  volume:1.0f loops:0 withCompletionBlock:^(BOOL finished) {
                // NSLog(@"Finished playing %");
                
            }];
        
    }
    
    ShakeCouponViewCtrl *vc = [ShakeCouponViewCtrl new];
    
    vc.nav = self.navigationController;
    
    self.definesPresentationContext = NO; //self is presenting view controller
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        
        vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }
    
    else{
        
        self.modalPresentationStyle=UIModalPresentationCurrentContext;
        
    }
   
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:^{
        
    }];
    
}



#pragma mark ------------------------------ 摇动感应器触发
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    [super motionEnded:motion withEvent:event];
    
        if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake){
            
            [self loadShakeData:^(BOOL ret){
                
                if (ret) {
                    
                    [self doLoadShakeView];
                    
                }else{
                    
                    [SVProgressHUD showErrorWithStatus:@"网络错误，请重试！"];
                    
                }
                
            }];
       
        }
 }



@end
