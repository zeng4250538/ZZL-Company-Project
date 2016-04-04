//
//  BrandStreetButtonService.h
//  coupon
//
//  Created by ZZL on 16/4/1.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BrandStreetButtonService : BaseService

-(void)requestButtonString:(NSString *)string shopMallId:(NSString *)shopMallId success:(void(^)(id data))success failure:(void(^)(id code))failure;

@end
