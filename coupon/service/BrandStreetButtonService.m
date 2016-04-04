//
//  BrandStreetButtonService.m
//  coupon
//
//  Created by ZZL on 16/4/1.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BrandStreetButtonService.h"

@implementation BrandStreetButtonService

-(void)requestButtonString:(NSString *)string shopMallId:(NSString *)shopMallId success:(void(^)(id data))success failure:(void(^)(id code))failure{

    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/nearby"];
    
    NSDictionary *parm = @{@"shopMallId":shopMallId,@"categoryId":string,@"page":@(1),@"per_page":@(3),@"fields":@"id,name,mallId,categoryId,addressId,city,distance,good,bad,longitude,latitude,favorcount,reviewcount,photoUrl,smallPhotoUrl,address,transport,description,phone,settlementDate,orderedCouponCount"};
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
    
        failure(content);
        
    }];

    


}

@end
