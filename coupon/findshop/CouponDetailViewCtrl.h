//
//  CouponDetailViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CouponDetailType) {
    CouponDetailTypeHaveCart=0,   //普通的商品详情，有购物车
    CouponDetailTypeNotHaveCart
};


@interface CouponDetailViewCtrl : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,assign)CouponDetailType couponDetailType;


@end
