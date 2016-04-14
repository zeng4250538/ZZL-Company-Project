//
//  CouponMessageService.m
//  coupon
//
//  Created by chijr on 16/4/14.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "CouponMessageService.h"

@implementation CouponMessageService


-(void)requestCouponMessageWithPage:(NSInteger)page
                   per_page:(NSInteger)per_page
                     isRead:(BOOL)isRead
                       sort:(NSString*)sort
                    success:(void(^)(NSInteger code,NSString *message,id data))success
                    failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    //GET /v1/couponMessage [摇折扣]列出客户的优惠券消息

    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
     NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponMessage"];
    
    
    
    NSDictionary *parm = @{@"customerId":customerId,@"page":@(page),@"perPage":@(per_page),@"isRead":@(NO)};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    
    
    
    

    
    
    
    
    
    
    
    
    
    
}


@end
