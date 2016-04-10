//
//  SaerchShopService.h
//  coupon
//
//  Created by ZZL on 16/3/26.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchShopService : BaseService

-(void)requestSearchShopKeyWord:(NSString *)keyWord success:(void(^)(id data))success failure:(void(^)(id data))failure;

@end
