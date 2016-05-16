//
//  ConfigService.m
//  coupon
//
//  Created by chijr on 16/5/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ConfigService.h"

@implementation ConfigService



//PUT /v1/customer/{customerId}/deviceToken


-(void)putDeviceToken:(NSString*)deviceToken
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
    NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"customer/%@/deviceToken",SafeString(customerId)];
     
    
    NSDictionary *parm = @{@"deviceToken":deviceToken};
    
    
    [req put:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    
    
    
    
    
    
    
    
}





@end
