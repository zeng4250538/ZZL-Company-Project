//
//  ShopService.m
//  coupon
//
//  Created by chijr on 16/2/6.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopService.h"

@implementation ShopService



//http://120.25.66.110:9998/diamond-sis-web/v1/shoprecommand?shopmallid=53420473120&userid=13693284393&page=1&per_page=3




-(void)requestRecommendShop:(NSString*)mallid page:(NSInteger)page pageCount:(NSInteger)pageCount
                  success:(void(^)(NSInteger code,NSString *message,id data))success
                  failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{

    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shoprecommand"];
    
    NSDictionary *parm = @{@"shopmallid":mallid,@"userid":@"13693284393",
                           @"page":@(page),@"per_page":@(pageCount)};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
    
    
    
    
    
    
    
}





//http://120.25.66.110:9998/diamond-sis-web/v1/nearby?shopmallid=53420473120&customerid=13693284393&categoryid=34624363243&sort=default

-(void)requestNearbyShop:(NSString*)mallid categoryid:(NSString*)categoryid sort:(NSString*)sort
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/nearby"];
    
    NSDictionary *parm = @{@"shopmallid":mallid,@"customerid":@"13693284393",
                           @"categoryid":@34624363243,@"sort":@"default"};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
    
    
    
    
    
    
    
}


-(void)requestKeyword:(NSString*)mallid keyWord:(NSString*)keyWord
                    success:(void(^)(NSInteger code,NSString *message,id data))success
                    failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/search"];
    
    NSDictionary *parm = @{@"shopmallid":mallid,@"keyword":keyWord};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    

    
    
    
    
    
    
    
}





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
