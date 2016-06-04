//
//  ShakeService.h
//  coupon
//
//  Created by chijr on 16/2/8.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShakeService : BaseService


-(void)requestShakeCoupon:(NSString*)mallid
                 shopMallId:(NSString *)shopMallId withCity:(NSString *)city success:(void(^)(NSInteger code,NSString *message,id data))success
                 failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;

@end
