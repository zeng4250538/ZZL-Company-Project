//
//  ShoppingCartSevice.h
//  coupon
//
//  Created by ZZL on 16/5/17.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartSevice : BaseService

//http://183.6.190.75:9780/diamond-sis-web/v1/couponbasket/basketitem/count?userid=15818865756&status=%E6%9C%AA%E6%B6%88%E8%B4%B9


-(void)soppingCartRequestUserId:(NSString *)userId withstatus:(NSString *)status withSuccessful:(void(^)(id data))succesful withFailure:(void(^)(id data))failure;

@end
