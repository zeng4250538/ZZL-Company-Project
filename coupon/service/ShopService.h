//
//  ShopService.h
//  coupon
//
//  Created by chijr on 16/2/6.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopService : BaseService




-(void)queryShopPortalData:(NSDictionary*)params
            success:(void(^)(int code,NSString *message,id data))success
            failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;




-(void)queryMoreHotShop:(NSDictionary*)params
            success:(void(^)(int code,NSString *message,id data))success
            failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;




@end
