//
//  CustomerService.m
//  coupon
//
//  Created by chijr on 16/4/14.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "CustomerService.h"

@implementation CustomerService

-(void)requestCustomer:(NSString*)customerId
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
  //  GET /v1/customer/{customerId} [摇折扣]查询个人资料

    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/"];
    url = [url stringByAppendingString:customerId];
    
    
    
    [req get:url param:nil success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
    }];
    
    
    
    
    
}


@end
