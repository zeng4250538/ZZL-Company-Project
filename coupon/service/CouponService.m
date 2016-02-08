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

-(void)queryShopCoupon:(NSDictionary*)params
               success:(void(^)(int code,NSString *message,id data))success
               failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    if (success) {
        
        
        
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:10];
        
        
        
        
        
        NSArray *timeLimitCoupon = [[MockData instance] randomCouponModel:3];
        
        [data setObject:timeLimitCoupon forKey:@"limit"];
        
     
        
        NSArray *otherCoupon = [[MockData instance] randomCouponModel:5];
    
        data[@"other"] =otherCoupon;
        
        
        success(0,@"",data);
        
        
    }
    
    
    return ;

    
    
    
    
    
    
}

-(void)queryNoUseCoupon:(NSDictionary*)params
                success:(void(^)(int code,NSString *message,id data))success
                failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    

    if (success) {

        NSArray *data = [[MockData instance] randomCouponModel:5];
        
        
        
        success(0,@"",data);
    }
    
    
    
    
    
    
    
}

-(void)queryFinishCoupon:(NSDictionary*)params
                success:(void(^)(int code,NSString *message,id data))success
                failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    
    if (success) {
        
        NSArray *data = [[MockData instance] randomCouponModel:10];
        
        
        
        success(0,@"",data);
    }
    
    
    
    
    
    
    
}

-(void)queryByKeyword:(NSDictionary*)params
                 success:(void(^)(int code,NSString *message,id data))success
                 failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    if (success) {
        
        NSArray *data = [[MockData instance] randomCouponModel:15];
        
        
        
        success(0,@"",data);
    }

    
    
    
    
}





@end
