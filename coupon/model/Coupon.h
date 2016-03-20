//
//  Coupon.h
//  coupon
//
//  Created by chijr on 16/3/20.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coupon : NSObject

@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *shopId;

@property(nonatomic,copy)NSString *couponSmallPhotoUrl;

@property(nonatomic,assign)CGFloat originalPrice;
@property(nonatomic,assign)CGFloat sellingPrice;

@property(nonatomic,copy)NSString *endTime;

@end
