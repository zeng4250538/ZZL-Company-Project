//
//  BasketNotUseService.m
//  coupon
//
//  Created by chijr on 16/3/25.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BasketService.h"

@implementation BasketService


-(void)requestADDBasket:(NSString *)couponId count:(NSInteger)count
                success:(void(^)(NSInteger code,NSString *message,id data))success
                failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    BaseRequest *req = [BaseRequest new];
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponbasket/basketitem"];
    AppShareData *app = [AppShareData instance];
    NSDictionary *parms =@{@"userId":app.customId,@"couponPromotionId":couponId};
    
    
    
    [req post:url param:parms success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        NSLog(@"%@",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
}



-(void)requestNotUseStatus:(NSString *)status success:(void(^)(NSInteger code,NSString *message,id data))success
             failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponbasket/basketitem"];
    
    
    NSDictionary *parm = @{@"userid":[AppShareData instance].customId,@"status":status};
    
    
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

//http://120.25.66.110:9998/diamond-sis-web/v1/couponbasket/basketitem/5441324523/


-(void)requestDeleteBasket:(NSString*)couponId
                   success:(void(^)(NSInteger code,NSString *message,id data))success
                   failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponbasket/basketitem/"];
    url = [url stringByAppendingString:couponId];
    url = [url stringByAppendingString:@"/"];
    
    
    //NSDictionary *parm = @{@"userid":@"15818865760"};
    
    
    //[AppShareData instance].customId
    
    
    [req delete:url param:nil success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
    
    
    
}



@end
