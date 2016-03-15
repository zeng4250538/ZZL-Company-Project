//
//  CouponService.h
//  coupon
//
//  Created by chijr on 16/2/7.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponService : BaseService


//http://120.25.66.110:9998/diamond-sis-web/v1/couponrecommand?shopmallid=23645321432444&userid=13693284393&page=1&per_page=3&sort=endTime



/**
 *  查询推荐的优惠券
 *
 *  @param mallid    商场id
 *  @param page      当前页
 *  @param pageCount 每页数量
 *  @param sort      排序风格
 *  @param success   成功回调
 *  @param failure   失败回调
 */
-(void)queryRecommandCoupon:(NSString*)mallid
                       page:(NSInteger)page
                  pageCount:(NSInteger)pageCount
                       sort:(NSString*)sort
                 success:(void(^)(NSInteger code,NSString *message,id data))success
                 failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;



-(void)queryPortalCoupon:(NSDictionary*)params
                success:(void(^)(int code,NSString *message,id data))success
                failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;




-(void)queryShopCoupon:(NSDictionary*)params
                 success:(void(^)(int code,NSString *message,id data))success
                 failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;



-(void)queryNoUseCoupon:(NSDictionary*)params
               success:(void(^)(int code,NSString *message,id data))success
               failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;



-(void)queryFinishCoupon:(NSDictionary*)params
                success:(void(^)(int code,NSString *message,id data))success
                failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;



-(void)queryByKeyword:(NSDictionary*)params
              success:(void(^)(int code,NSString *message,id data))success
              failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;



-(void)queryRemindCoupon:(NSDictionary*)params
                 success:(void(^)(int code,NSString *message,id data))success
                 failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;

-(void)queryDrawBackCoupon:(NSDictionary*)params
                   success:(void(^)(int code,NSString *message,id data))success
                   failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;








@end
