//
//  ConsumptionSuccessDataSevice.h
//  coupon
//
//  Created by ZZL on 16/6/8.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface ConsumptionSuccessDataSevice : BaseService

-(void)consumptionDataRequestCouponInstanceId:(NSString *)idData success:(void(^)(id data))success failure:(void(^)(id data))failure;

@end
