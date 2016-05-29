//
//  SubHistorySevice.h
//  coupon
//
//  Created by ZZL on 16/5/29.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface SubHistorySevice : BaseService

-(void)subRequrestCouponInstanceId:(id)data withSuccess:(void (^)(id data))success withFailure:(void(^)(id data))failure;

@end
