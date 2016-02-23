//
//  CouponPaymentDetailViewCtrl.h
//  coupon
//
//  Created by chijr on 16/2/23.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, CouponPaymentType) {
    CouponPaymentTypeNoUsed=0,
    CouponPaymentTypeUsed=1
    
};

@interface CouponPaymentDetailViewCtrl : UITableViewController

@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,assign)CouponPaymentType couponPaymentType;



@end
