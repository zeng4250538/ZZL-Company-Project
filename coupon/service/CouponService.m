//
//  CouponService.m
//  coupon
//
//  Created by chijr on 16/2/7.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CouponService.h"

@implementation CouponService

-(void)queryPortalCoupon:(NSDictionary*)params
                 success:(void(^)(int code,NSString *message,id data))success
                 failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    
    if (success) {
        
        
        NSArray *hotCoupon = [[MockData instance] randomCouponModel:10];
        
        
        success(0,@"",hotCoupon);
        
        
    }
    
    
    return ;
    
    

    
    
    
    
    
    
    
}


@end
