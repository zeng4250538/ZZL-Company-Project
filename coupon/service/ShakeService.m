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
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponrecommend"];
    
    NSDictionary *parm = @{@"customerId":@"15818865756",@"shopMallId":mallid};
  
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
//        NSLog(@"-------->%@",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
    

    
    
    
    
     
    
}


@end
