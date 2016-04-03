//
//  BasketNotUseService.h
//  coupon
//
//  Created by chijr on 16/3/29.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface BasketService : BaseService

/**
 *  增加商品到购物篮子
 *
 *  @param couponId <#couponId description#>
 *  @param count    <#count description#>
 *  @param success  <#success description#>
 *  @param failure  <#failure description#>
 */
-(void)requestADDBasket:(NSDictionary*)parm count:(NSInteger)count
                success:(void(^)(NSInteger code,NSString *message,id data))success
                failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;




/**
 *  获取没有使用的优惠券信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)requestNotUse:(void(^)(NSInteger code,NSString *message,id data))success
                     failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


/**
 *  获取已经过期优惠券信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */



-(void)requestTimeOut:(void(^)(NSInteger code,NSString *message,id data))success
             failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;

/**
 *  删除篮子里面的优惠券
 *
 *  @param couponId 优惠券id
 *  @param success  成功回调
 *  @param failure  失败回调
 */

-(void)requestDeleteBasket:(NSString*)couponId
                   success:(void(^)(NSInteger code,NSString *message,id data))success
                   failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;



@end
