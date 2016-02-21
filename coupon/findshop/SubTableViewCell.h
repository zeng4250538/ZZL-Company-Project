//
//  ShopCouponTableViewCell.h
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CouponInfoTableViewCell.h"


typedef void(^PayBlock)(NSDictionary *data);

@interface SubTableViewCell : UITableViewCell


@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,assign)CouponType couponType;
@property(nonatomic,copy)PayBlock payBlock;



-(void)updateData;


+(UIView*)headerView:(NSString*)title;


+(CGFloat)height;


@end
