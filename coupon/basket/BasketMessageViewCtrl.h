//
//  BasketMessageViewCtrl.h
//  coupon
//
//  Created by chijr on 16/2/24.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CouponMessageType) {
    CouponMessageTypeBasket,
    CouponMessageTypeCoupon,
    CouponMessageTypeShop
};

@interface BasketMessageViewCtrl : UITableViewController

@property(nonatomic,assign)CouponMessageType couponMessageType;

@end
