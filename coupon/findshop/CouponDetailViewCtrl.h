//
//  CouponDetailViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UMSocial.h"


typedef NS_ENUM(NSUInteger, CouponDetailType) {
    CouponDetailTypeHaveCart=0,   //普通的商品详情，有购物车
    CouponDetailTypeNotHaveCart
};


typedef NS_ENUM(NSUInteger, CouponViewMode) {
    CouponViewModeLocal,
    CouponViewModeNetwork
};


typedef NS_ENUM(NSUInteger, CouponDetailPushMode) {  //优惠券显示
    CouponDetailPushModePush,                       //显示购物车
    CouponDetailPushModePresent                     //不显示购物车
};




@class UMSocialUIDelegate;
@interface CouponDetailViewCtrl : UIViewController<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)NSString *couponId;

@property(nonatomic,assign)CouponDetailType couponDetailType;
@property(nonatomic,assign)CouponViewMode couponViewMode;
@property(nonatomic,assign)BOOL shopingCarPush;


@property(nonatomic,assign)CouponDetailPushMode couponDetailPushMode;








@end
