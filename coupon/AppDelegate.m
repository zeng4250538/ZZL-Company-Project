//
//  AppDelegate.m
//  coupon
//
//  Created by chijr on 15/12/19.
//  Copyright (c) 2015年 chijr. All rights reserved.
//

#import "AppDelegate.h"
#import "ShakeViewCtrl.h"
#import "ShopPortalViewCtrl.h"
#import "PersonInfoViewCtrl.h"
#import "CartViewCtrl.h"
#import "MallService.h"
#import "MobClick.h"
#import "UMessage.h"

#import "UMSocial.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
//#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"

#import <AlipaySDK/AlipaySDK.h>

//#import "UMSocialTencentWeiboHandler.h"

#import "WXApi.h"



#import <CoreLocation/CoreLocation.h>
@interface AppDelegate ()

@property (nonatomic, strong) CLLocationManager *lcManager;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)BMKMapManager* mapManager;


@end

@implementation AppDelegate


BOOL InLan = NO;

NSString *ALiPayNotice=@"alipaynotice";
NSString *WechatPayNotice=@"wechatpaynotice";

NSString *UmengKey=@"56e906e267e58e54f2000607";
NSString *WeChatAppId=@"wx77914cc659d2889c";
NSString *WeChatAppSecret=@"";

NSString *BaiduMapKey=@"nGyPKtwh9v9Q5GlsxvXml6lOosxdCWGI";  //对应的bundle id = com.richstone.coupontest3




#pragma mark - tab控制器创建
-(void)makeTabViewCtrl{
    
    
    NSArray *titleArray = @[@"摇一摇",@"找商家",@"我的"];
    NSArray *imageArray = @[[UIImage imageNamed:@"tab_shake_icon.png"],
                            [UIImage imageNamed:@"tab_brand_icon.png"],
                            [UIImage imageNamed:@"tab_person_icon.png"]
                            ];
    
    
    NSArray *vcList = @[[[ShakeViewCtrl alloc] init],
                        [[ShopPortalViewCtrl alloc] init],
                         [[PersonInfoViewCtrl alloc] init]
                        ];
    
    
    
    
    int pos=0;
    
    NSMutableArray *vcArray = [NSMutableArray arrayWithCapacity:3];
    for (NSString *title in titleArray) {
        
        UIViewController *vc = vcList[pos];
        vc.view.backgroundColor = [UIColor whiteColor];
        
        vc.navigationItem.title = title;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.image = imageArray[pos];
        nav.tabBarItem.title = title;
        
        [vcArray addObject:nav];
        
        if ([vc isKindOfClass:[CartViewCtrl class]]) {
            self.cartVc = nav;
            
        }
        
        //nav.tabBarItem.selectedImage
        

        
        pos++;
        
        
    }
    
    UITabBarController *tabViewCtrl = [[UITabBarController alloc] init];
    self.tabViewCtrl = tabViewCtrl;
    
    self.tabViewCtrl.viewControllers=vcArray;
    
    
    self.window.rootViewController = tabViewCtrl;
    
    [self.window makeKeyAndVisible];
    
    
    
    
}


#pragma mark 设置统一外观
-(void)setAppearance{
    
    
    
    //设置状态栏为白色
    //View controller-based status bar appearance，并将其值设置为NO。白色才有效
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //页式控件的主色
    
    [UITabBar appearance].tintColor = [GUIConfig mainColor];
    
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    
    // [UITabBar appearance].translucent = NO;
    
   // [[UITabBar appearance] setBarTintColor:[GUIConfig tabBackgroundColor]];
    
    
    
    //<返回   不显示标题
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
    
    //设置导航栏文字前景
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    
    
    //导航栏背景
    // [UINavigationBar appearance].barTintColor = [GUIConfig mainColor];
    
    
    [UINavigationBar appearance].barTintColor = [GUIConfig mainColor];
    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    
    
    [UITabBar appearance].tintColor = [GUIConfig mainColor];
    
   
    
    //背景反白，暂时屏蔽
    //[UITabBar appearance].selectionIndicatorImage = [Utils imageWithColor:[GUIConfig mainColor] rect:CGRectMake(0, 0, SCREEN_WIDTH/4, 50)];

    
    
    
    // [[UITabBar appearance]setBackgroundColor:[UIColor redColor]];
    
    
    
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    //微信
    [WXApi registerApp:WeChatAppId withDescription:@"摇折扣"];
    
    self.mapManager = [BMKMapManager new];
    [self.mapManager start:BaiduMapKey generalDelegate:self];
    
    
    
    
    
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
    
    
    
    
    [self setUmengParam:launchOptions];
    
    [self setAppearance];
    [self makeTabViewCtrl];
    
    
    
    
  
    
    
    
    return YES;
}

/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"获取定位失败");
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向得出位置城市信息
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.city = placeMark.locality;
            
            [[AppShareData instance] setCity:self.city];
            // ? placeMark.locality : placeMark.administrativeArea;
            if (!self.city) {
                self.city = NSLocalizedString(@"home_cannot_locate_city", comment:@"无法定位当前城市");
            }
            // 获取城市信息后, 异步更新界面信息.      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    } else if (error == nil && placemarks.count == 0) {
        NSLog(@"No location and error returned");
    } else if (error) {
        NSLog(@"Location error: %@", error);
    }
     }];
    
    [manager stopUpdatingLocation];
}



#pragma mark - 设置友盟相关参数
-(void)setUmengParam:(NSDictionary*)launchOptions{
    
    
    
    //统计
    [MobClick startWithAppkey:UmengKey reportPolicy:REALTIME   channelId:nil];
    
    //社交分享
    [UMSocialData setAppKey:UmengKey];
    
    [UMSocialData openLog:YES];
    
    //微信分享接口
    [UMSocialWechatHandler setWXAppId:WeChatAppId appSecret:@"d9ea274d9e5e60d83a462dc60d27d382" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    
    //QQ分享接口
    [UMSocialQQHandler setQQWithAppId:@"1105243920" appKey:@"qwXUdQcP6OtqHMBU" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    //新浪分享接口
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"643547533"
                                              secret:@"e4509cf7d0480042690de0553e283609"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    

    
    
    //推送消息
    
    [UMessage startWithAppkey:UmengKey launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];
    
    
    
    
    
    
    
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    
   [UMSocialSnsService handleOpenURL:url];
    
    
    
    
    return  [WXApi handleOpenURL:url delegate:self];
}






- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation{
    
    
    [iConsole log:@"openURL %@",url];
    
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result) {
        
        return result;
        
        //调用其他SDK，例如支付宝SDK等
    }
    
    
    
    
    BOOL ret = [WXApi handleOpenURL:url delegate:self] ;
    
    
    
    
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        
        
        [iConsole log:@" AlipaySDK result  %@",resultDic];
        
        NSLog(@"result = %@",resultDic);
    }];
    
    
    return ret;
    
    
    
    
    
    
    
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"<-------我就是deviceToken--------->%@",deviceToken);
    [UMessage registerDeviceToken:deviceToken];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 微信回调接口


-(void) onResp:(BaseResp*)resp{
    
    
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        
        switch (resp.errCode) {
                //微信支付成功
            case WXSuccess:{
                strMsg = @"支付结果：成功！";
                
                [iConsole log:@"支付成功－PaySuccess，retcode = %@", resp];
                
                SafePostMessage(WechatPayNotice, @"1");
                break;
            }
            default:{
                
                //微信支付失败
                
                
                [iConsole log:@"支付失败－PaySuccess，retcode = %@", resp];
                SafePostMessage(WechatPayNotice, @"0");
                
                
                
                break;
            }
        }
    }
    
    
    
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"百度地图联网成功");
    }
    else{
        NSLog(@"百度地图 联网错误 onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"百度地图 联网错误 onGetPermissionState %d",iError);
    }
}






@end
