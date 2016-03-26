//
//  OptimizingBrandModel.h
//  coupon
//
//  Created by ZZL on 16/3/26.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OptimizingBrandModel : NSObject

@property(nonatomic,copy)NSString *ids;
@property(nonatomic,copy)NSString *mallid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,assign)NSUInteger good;
@property(nonatomic,assign)NSUInteger bad;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,assign)CGFloat longitude;
@property(nonatomic,assign)CGFloat latitude;
@property(nonatomic,assign)CGFloat distance;
@property(nonatomic,copy)NSString * smallPhotoUrl;

@end
