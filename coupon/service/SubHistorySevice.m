//
//  SubHistorySevice.m
//  coupon
//
//  Created by ZZL on 16/5/29.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "SubHistorySevice.h"

@implementation SubHistorySevice

-(void)subRequrestCouponInstanceId:(id)data withSuccess:(void (^)(id data))success withFailure:(void(^)(id data))failure{
 
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/couponInstance/%@",data];
    
    [req get:url param:nil success:^(NSInteger code, id object) {
        success(object);
    } failure:^(NSInteger code, NSString *content) {
        failure(content);
    }];


}

@end
