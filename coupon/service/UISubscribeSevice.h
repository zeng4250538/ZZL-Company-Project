//
//  UISubscribeSevice.h
//  coupon
//
//  Created by ZZL on 16/3/29.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UISubscribeSevice : BaseService

-(void)successful:(void(^)(id data))successful failure:(void(^)(id code))failure;

-(void)cancelSuccessful:(void(^)(id data))successful failure:(void(^)(id code))failure;

-(void)judgeSuccessful:(void(^)(id data))successful failure:(void(^)(id code))failure;

@end
