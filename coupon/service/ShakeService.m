//
//  ShakeService.m
//  coupon
//
//  Created by chijr on 16/2/8.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShakeService.h"

@implementation ShakeService


-(void)requestShakeCoupon:(NSDictionary*)params
                  success:(void(^)(int code,NSString *message,id data))success
                  failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    if (success) {
        
        NSArray *data = [[MockData instance] orderCouponModel:10];
        
        
        
        success(0,@"",data);
    }
    
    
    
}


@end
