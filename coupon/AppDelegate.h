//
//  AppDelegate.h
//  coupon
//
//  Created by chijr on 15/12/19.
//  Copyright (c) 2015年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,CLLocationManagerDelegate,BMKGeneralDelegate>     

@property (strong, nonatomic)UIWindow *window;
@property (strong,nonatomic)UITabBarController *tabViewCtrl;

@property (strong, nonatomic) UIViewController *cartVc;

@property(nonatomic,strong)NSString *city;

@end

