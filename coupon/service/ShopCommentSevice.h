//
//  ShopCommentSevice.h
//  coupon
//
//  Created by ZZL on 16/4/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCommentSevice : BaseService

-(void)requestParam:(NSDictionary *)param success:(void(^)(id data))success failure:(void(^)(id coad))failure;

@end
