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

-(void)requestRecommendShop:(NSString*)mallid  page:(NSInteger)page pageCount:(NSInteger)pageCount
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


-(void)requestNearbyShop:(NSString*)mallid page:(NSInteger)page per_page:(NSInteger)per_page
                 success:(void(^)(NSInteger code,NSString *message,id data))success
                 failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;




/**
 *  查询关键字
 *
 *  @param mallid  商城id
 *  @param keyWord 输入的关键字
 *  @param success 成功回调
 *  @param failure 失败回调
 */

-(void)requestKeyword:(NSString*)mallid keyWord:(NSString*)keyWord
                 success:(void(^)(NSInteger code,NSString *message,id data))success
                 failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;



-(void)requestNearbyShopWithFilter:(NSString*)mallid page:(NSInteger)page per_page:(NSInteger)per_page
                               cat:(NSString*)cat sort:(NSString*)sort
                           success:(void(^)(NSInteger code,NSString *message,id data))success
                           failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;






/**
 *  对商店点赞
 *
 *  @param shopid  商店id
 *  @param mode  mode == YES 点赞，model == NO，取消点赞
 *  @param success 商店成功回调
 *  @param failure 商店失败回调
 */


-(void)requestDoGood:(NSString*)shopid
                mode:(BOOL)mode
             success:(void(^)(NSInteger code,NSString *message,id data))success
             failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


/**
 *  对商店点差评
 *
 *  @param shopid  商店id
 *  @param mode  mode == YES 点赞，model == NO，取消点赞
 *  @param success 成功回调
 *  @param failure 失败回调
 */

-(void)requestDoBad:(NSString*)shopid
               mode:(BOOL)mode
             success:(void(^)(NSInteger code,NSString *message,id data))success
             failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;

/**
 *  对商店订阅
 *
 *  @param shopid  商店id
 *  @param success 成功回调
 *  @param failure 失败回调
 */



-(void)requestFav:(NSString*)shopid
            success:(void(^)(NSInteger code,NSString *message,id data))success
            failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


/**
 *  订阅该商店
 *
 *  @param shopid  商店id
 *  @param success 成功回调
 *  @param failure 失败回调
 */

-(void)doFav:(NSString*)shopid
          success:(void(^)(NSInteger code,NSString *message,id data))success
          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


/**
 *  取消商店订阅
 *
 *  @param shopid  商店id
 *  @param success 成功回调
 *  @param failure 失败回调
 */



-(void)doUnFav:(NSString*)shopid
     success:(void(^)(NSInteger code,NSString *message,id data))success
     failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


/**
 *  获取我订阅的商家信息
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */

-(void)requestMyFavList:(void(^)(NSInteger code,NSString *message,id data))success
          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;



/**
 *  查询商家的评论
 *
 *  @param shopid  商店id
 *  @param success
 *  @param failure
 */

-(void)requestShopComment:(NSString*)shopid
                     page:(NSInteger)page
                pageCount:(NSInteger)pageCount
                     sort:(NSString*)sort
                  success:(void(^)(NSInteger code,NSString *message,id data))success
                  failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;




-(void)requestShopInfo:(NSString* )shopId
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;



-(void)queryShopPortalData:(NSDictionary*)params
            success:(void(^)(int code,NSString *message,id data))success
            failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;




-(void)queryMoreHotShop:(NSDictionary*)params
            success:(void(^)(int code,NSString *message,id data))success
            failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;




@end
