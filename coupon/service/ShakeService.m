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
                  success:(void(^)(NSInteger code,NSString *message,id data))success
                  failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponrecommand"];
    
    NSDictionary *parm = @{@"shopmallid":mallid,@"userid":@"13693284393",
                           @"page":@1,@"per_page":@(10),@"sort":@""};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
    

    
    
    
    
     
    
}


@end
