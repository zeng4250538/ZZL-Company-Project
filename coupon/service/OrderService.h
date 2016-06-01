//
//  OrderService.h
//  coupon
//
//  Created by chijr on 16/5/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface OrderService : BaseService


-(void)requestPrepayId:(NSString*)couponInstanceId originalPrice:(CGFloat)originalPrice
          sellingPrice:(CGFloat)sellingPrice
          paymentPrice:(CGFloat)paymentPrice
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


-(void)requestAliPaySign:(NSString*)couponInstanceId originalPrice:(CGFloat)originalPrice
          sellingPrice:(CGFloat)sellingPrice
          paymentPrice:(CGFloat)paymentPrice
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


@end
