//
//  ShopMessageService.h
//  coupon
//
//  Created by chijr on 16/4/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

/**
 *  [摇折扣]订阅商家消息相关接口
 */

@interface ShopMessageService : BaseService


-(void)requestShopMessageWithPage:(NSUInteger)page
                         per_page:(NSUInteger)per_page
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;



-(void)deleteShopMessage:(NSString*)messageId
                          success:(void(^)(NSInteger code,NSString *message,id data))success
                          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;





@end
