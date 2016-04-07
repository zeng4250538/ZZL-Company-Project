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
@interface AppDelegate ()

@end

@implementation AppDelegate


BOOL InLan = YES;



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
    
    
    [self setAppearance];
    [self makeTabViewCtrl];
    return YES;
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
