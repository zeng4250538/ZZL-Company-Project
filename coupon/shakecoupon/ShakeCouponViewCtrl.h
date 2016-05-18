//
//  ShakeCouponViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^shoppingCartBlock)(NSString *string);

@interface ShakeCouponViewCtrl : UIViewController

@property(nonatomic,copy)shoppingCartBlock shppingCartData;

@property(nonatomic,weak)UINavigationController *nav;

@end
