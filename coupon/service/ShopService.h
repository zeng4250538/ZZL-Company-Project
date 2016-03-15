//
//  ShopService.h
//  coupon
//
//  Created by chijr on 16/2/6.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopService : BaseService

/**
 *  优选商店查询接口
 *
 *  @param mallid    商场id
 *  @param page      当前页
 *  @param pageCount 每页数量
 *  @param success   成功回调
 *  @param failure   失败回调
 *http://120.25.66.110:9998/diamond-sis-web/v1/shoprecommand?shopmallid=53420473120&userid=13693284393&page=1&per_page=3
  */

-(void)queryRecommandShop:(NSString*)mallid page:(NSInteger)page pageCount:(NSInteger)pageCount
                  success:(void(^)(NSInteger code,NSString *message,id data))success
                  failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;




//http://120.25.66.110:9998/diamond-sis-web/v1/nearby?shopmallid=53420473120&customerid=13693284393&categoryid=34624363243&sort=default

/**
 *  品牌街查询接口
 *
 *  @param mallid 商场id
 *  @param categoryid  分类id
 *  @param success             成功回调函数
 *  @param failure             失败回调函数
 */


-(void)queryNearbyShop:(NSString*)mallid categoryid:(NSString*)categoryid sort:(NSString*)sort
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;




-(void)queryShopPortalData:(NSDictionary*)params
            success:(void(^)(int code,NSString *message,id data))success
            failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;




-(void)queryMoreHotShop:(NSDictionary*)params
            success:(void(^)(int code,NSString *message,id data))success
            failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;




@end
