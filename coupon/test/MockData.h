//
//  MockData.h
//  coupon
//
//  Created by chijr on 16/2/6.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MockData : NSObject

+ (instancetype)instance;

-(NSArray*)randomShopModel:(NSUInteger)count;

-(NSArray*)randomCouponModel:(NSUInteger)count;



@end
