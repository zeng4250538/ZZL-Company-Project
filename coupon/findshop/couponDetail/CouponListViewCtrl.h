//
//  CouponListViewCtrl.h
//  coupon
//
//  Created by chijr on 16/2/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CouponListType) {
    
    CouponListTypeNormal,
    CouponListTypeReminder
 };

@interface CouponListViewCtrl : UITableViewController


@property(nonatomic,assign)CouponListType couponListType;


@end
