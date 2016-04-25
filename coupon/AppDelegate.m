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

#import <CoreLocation/CoreLocation.h>
@interface AppDelegate ()

@property (nonatomic, strong) CLLocationManager *lcManager;

@end

@implementation AppDelegate


BOOL InLan = NO;



#pragma mark - tab控制器创建
-(void)makeTabViewCtrl{
    
    
    NSArray *titleArray = @[@"摇一摇",@"找商家",/*@"篮子",*/@"我的"];
    NSArray *imageArray = @[[UIImage imageNamed:@"tab_shake_icon.png"],
                            [UIImage imageNamed:@"tab_brand_icon.png"],
                           /* [UIImage imageNamed:@"gocart.png"],*/
                            [UIImage imageNamed:@"tab_person_icon.png"]
                            ];
    
    
    NSArray *vcList = @[[[ShakeViewCtrl alloc] init],
                        [[ShopPortalViewCtrl alloc] init],
                       /* [[CartViewCtrl alloc] init],*/
                        
                        [[PersonInfoViewCtrl alloc] init]
                        ];
    
    
  //  self.cartVc = vcList[2];
    
    
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
    
    
    
   // UITabBarItem *tabBarItem1 = self.tabViewCtrl.tabBar.items[0];
    
    
    
    

    
    
    
    
    
    
    
    
    
    
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
    
     [[UITabBar appearance]setSelectedImageTintColor:[UIColor redColor]];
    
    
    [UITabBar appearance].selectedImageTintColor = [GUIConfig mainColor];
    
   
    
    //背景反白，暂时屏蔽
    //[UITabBar appearance].selectionIndicatorImage = [Utils imageWithColor:[GUIConfig mainColor] rect:CGRectMake(0, 0, SCREEN_WIDTH/4, 50)];

    
    
    
    // [[UITabBar appearance]setBackgroundColor:[UIColor redColor]];
    
    
    
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [MobClick startWithAppkey:@"56e906e267e58e54f2000607" reportPolicy:REALTIME   channelId:nil];
    
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        // 创建位置管理者对象
        self.lcManager = [[CLLocationManager alloc] init];
        self.lcManager.delegate = self; // 设置代理
        // 设置定位距离过滤参数 (当本次定位和上次定位之间的距离大于或等于这个值时，调用代理方法)
        self.lcManager.distanceFilter = 100;
        self.lcManager.desiredAccuracy = kCLLocationAccuracyBest; // 设置定位精度(精度越高越耗电)
        [self.lcManager startUpdatingLocation]; // 开始更新位置
    }
    
    
//    56e906e267e58e54f2000607  复制
//    App Master Secret：eex4ihtajreb2ca4t8mdsd0plwivb9vx
    
    
    
//    
    
    [self setAppearance];
    [self makeTabViewCtrl];
    [self setUmengMessage:launchOptions];
    
    
    
    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
//        //由于IOS8中定位的授权机制改变 需要进行手动授权
//        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
//        //获取授权认证
//        [locationManager requestAlwaysAuthorization];
//        [locationManager requestWhenInUseAuthorization];
//    }
//    
    
    
    
    
    return YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"定位到了");
}
/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"获取定位失败");
}


-(void)setUmengMessage:(NSDictionary*)launchOptions{
    
    
    [UMessage startWithAppkey:@"56e906e267e58e54f2000607" launchOptions:launchOptions];
    
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

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
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

@end
