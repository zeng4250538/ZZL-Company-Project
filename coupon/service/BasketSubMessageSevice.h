//
//  BasketSubMessageSevice.h
//  coupon
//
//  Created by ZZL on 16/5/26.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface BasketSubMessageSevice : BaseService

-(void)basketMessageRequestMessageId:(NSString *)message withSuccess:(void(^)(id data))success withFailure:(void (^)(id data))failure;

-(void)removeMessageRequestMessageId:(NSString *)message withSuccess:(void(^)(id data))success withFailure:(void (^)(id data))failure;

@end
