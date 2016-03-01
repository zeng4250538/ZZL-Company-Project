//
//  ShopService.m
//  coupon
//
//  Created by chijr on 16/2/6.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopService.h"

@implementation ShopService


-(void)queryShopPortalData:(NSDictionary*)params
                  success:(void(^)(int code,NSString *message,id data))success
                  failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    if (success) {
        
        
        NSArray *hotshop = [[MockData instance] randomShopModel:3];
                            
                            
        NSArray *hotbrand = [[MockData instance] randomShopModel:3];
        
        
        NSArray *hotcoupon = [[MockData instance] orderCouponModel:3];
            
                             
                             
        
        NSDictionary *data = @{@"hotshop":hotshop,@"hotcoupon":hotcoupon,@"hotbrand":hotbrand};
        
        success(0,@"",data);
        
        
    }
    
    
    return ;
    
    
    
    
    
    
}




-(void)queryMoreHotShop:(NSDictionary*)params
               success:(void(^)(int code,NSString *message,id data))success
               failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    
    if (success) {
        
        
        NSArray *hotshop = [[MockData instance] randomShopModel:8];
        
        
        success(0,@"",hotshop);
        
        
    }
    
    
    return ;
    

    
    
    
    
}















@end
