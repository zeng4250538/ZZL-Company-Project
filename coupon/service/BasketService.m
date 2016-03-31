//
//  BasketNotUseService.m
//  coupon
//
//  Created by chijr on 16/3/25.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BasketService.h"

@implementation BasketService



-(void)requestADDBasket:(NSDictionary*)parm count:(NSInteger)count
                success:(void(^)(NSInteger code,NSString *message,id data))success
                failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
   // http://120.25.66.110:9998/diamond-sis-web/v1/couponbasket/basketitem
    
//    {
//        "customerId":"35124123",
//        "couponId":"325431214",
//        "couponCount":1
//    }
//
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponbasket/basketitem"];
 
    NSDictionary *parms = parm;
    
    
    [req post:url param:parms success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    

    
    
    
    
    
    
}



-(void)requestUserid:(NSString *)userid NotUse:(void(^)(NSInteger code,NSString *message,id data))success
             failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    //http://120.25.66.110:9998/diamond-sis-web/v1/couponbasket/basketitem?userid=2347313464
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponbasket/basketitem"];
    
    
    
    
    NSDictionary *parm = @{@"userid":userid};
    
    
    //[AppShareData instance].customId
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
    
    
    
}
-(void)requestTimeOut:(void(^)(NSInteger code,NSString *message,id data))success
              failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    
}


@end
