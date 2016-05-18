//
//  ReviewService.m
//  coupon
//
//  Created by chijr on 16/4/17.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ReviewService.h"

@implementation ReviewService


-(void)postReview:(NSString*)shopId
          comment:(NSString*)comment
          couponInstanceId:(NSString*)couponInstanceId
           isLike:(NSUInteger)isLike
          success:(void(^)(NSInteger code,NSString *message,id data))success
          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    


    
    
    BaseRequest *req = [BaseRequest new];
    
    
    NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/review"];
    
    
    
    NSDictionary *parm = @{@"id":couponInstanceId,@"customerId":customerId,
                           @"shopId":shopId,
                           @"comment":comment,
                           @"isLike":@(isLike)};
    
    
    [req post:url param:parm success:^(NSInteger code, id object,AFHTTPRequestOperation *operation) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];

    
    
    
    
    
    
    
    
    
    
    
}


@end
