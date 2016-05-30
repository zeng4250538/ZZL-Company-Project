//
//  IdShopSevice.m
//  coupon
//
//  Created by ZZL on 16/5/30.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "IdShopSevice.h"

@implementation IdShopSevice

-(void)shopIdRequrestString:(NSString *)data withSuccess:(void(^)(id data))success withFailure:(void(^)(id data))failure{

    //http://192.168.6.97:8080/diamond-sis-web/v1/shop/11?fields
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/shop/%@",data];
    NSDictionary *param = @{@"fields":@"id,name,mallId,categoryId,addressId,city,distance,good,bad,longitude,latitude,favorcount,reviewcount,photoUrl,smallPhotoUrl,address,transport,description,phone,settlementDate,takenCouponCount"};
    
    [req get:url param:param success:^(NSInteger code, id object) {
        success(object);
    } failure:^(NSInteger code, NSString *content) {
        failure(content);
    }];


}

@end
