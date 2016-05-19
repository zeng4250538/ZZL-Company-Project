//
//  ShakeService.m
//  coupon
//
//  Created by chijr on 16/2/8.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShakeService.h"

@implementation ShakeService


-(void)requestShakeCoupon:(NSString*)mallid
               shopMallId:(NSString *)shopMallId success:(void(^)(NSInteger code,NSString *message,id data))success
                  failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    BaseRequest *req = [BaseRequest new];
    //http://192.168.6.97:8080/diamond-sis-web/v1/couponrecommend?shopMallId=2&customerId=15818865756&page=1&per_page=10
    //http://183.6.190.75:9780/diamond-sis-web/v1/couponrecommend?customerId=15818865760&shopMallId=2
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponrecommend"];
    
    if (mallid==nil) {
        mallid=@"";
    }
    
    NSString *customerId = SafeString([AppShareData instance].customId);
    
    NSDictionary *parm = @{@"customerId":SafeString(customerId),@"shopMallId":SafeString(shopMallId)};
  
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
//        NSLog(@"-------->%@",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
    

    
    
    
    
     
    
}


@end
