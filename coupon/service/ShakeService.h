//
//  ShakeService.h
//  coupon
//
//  Created by chijr on 16/2/8.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShakeService : NSObject


-(void)requestShakeCoupon:(NSDictionary*)params
                 success:(void(^)(int code,NSString *message,id data))success
                 failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;

@end
