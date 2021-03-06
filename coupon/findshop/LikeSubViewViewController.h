//
//  LikeSubViewViewController.h
//  coupon
//
//  Created by ZZL on 16/6/2.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UMSocial.h"


typedef NS_ENUM(NSUInteger, CouponDetailTypes) {
    CouponDetailTypeHaveCarts=0,   //普通的商品详情，有购物车
    CouponDetailTypeNotHaveCarts
};
//
//
//typedef NS_ENUM(NSUInteger, CouponViewMode) {
//    CouponViewModeLocal,
//    CouponViewModeNetwork
//};
//
//
//typedef NS_ENUM(NSUInteger, CouponDetailPushMode) {  //优惠券显示
//    CouponDetailPushModePush,                       //显示购物车
//    CouponDetailPushModePresent                     //不显示购物车
//};


@interface LikeSubViewViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)NSString *couponId;

@property(nonatomic,assign)CouponDetailTypes couponDetailType;
//@property(nonatomic,assign)CouponViewMode couponViewMode;
//
//
//
//@property(nonatomic,assign)CouponDetailPushMode couponDetailPushMode;

@end
