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

-(void)subBoolShopCart:(NSString *)couponPromotionId customerId:(NSString *)customerId withSuccess:(void (^)(id cartData))success withFailure:(void(^)(id cartData))failure{
    
    
    //http://192.168.6.98:8080/diamond-sis-web/v1/couponPromotionDetails/1232395701170738719?customerId=15818865756
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/couponPromotionDetails/%@",couponPromotionId];
    NSDictionary *param = @{@"customerId":customerId};
    [req get:url param:param success:^(NSInteger code, id object) {
        success(object);
    } failure:^(NSInteger code, NSString *content) {
        failure(content);
    }];
    

}


@end
