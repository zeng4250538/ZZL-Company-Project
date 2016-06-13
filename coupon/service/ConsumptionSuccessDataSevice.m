//
//  ConsumptionSuccessDataSevice.m
//  coupon
//
//  Created by ZZL on 16/6/8.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ConsumptionSuccessDataSevice.h"

@implementation ConsumptionSuccessDataSevice

-(void)consumptionDataRequestCouponInstanceId:(NSString *)idData success:(void(^)(id data))success failure:(void(^)(id data))failure{
    
      //http://192.168.6.97:8080/diamond-sis-web/v1/couponInstance/1267966448534295603

    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/couponInstance/%@",idData];

    [req get:url param:nil success:^(NSInteger code, id object) {
        success(object);
    } failure:^(NSInteger code, NSString *content) {
        failure(content);
    }];
}

@end
