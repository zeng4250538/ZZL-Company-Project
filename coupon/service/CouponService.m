//
//  CouponService.m
//  coupon
//
//  Created by chijr on 16/2/7.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CouponService.h"
#import "BaseService.h"

@implementation CouponService



//couponrecommand?shopmallid=23645321432444&userid=13693284393&page=1&per_page=3&sort=endTime


-(void)requestRecommendCoupon:(NSString*)mallid
                       page:(NSInteger)page
                  pageCount:(NSInteger)pageCount
                       sort:(NSString*)sort
                    success:(void(^)(NSInteger code,NSString *message,id data))success
                    failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/realtimepromotion"];
    
    NSDictionary *parm = @{@"shopMallId":mallid,@"page":@(page),@"per_page":@(pageCount),@"sort":sort};
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
    }];
    

    
    
    
    
    
}

//查询商店里面的实时推荐的优惠券
//http://120.25.66.110:9998/diamond-sis-web/
//v1/couponpromotion?
//shopid=4532443&type=realtime

-(void)requestRealTimeCoupon:(NSString*)shopId
                        page:(NSInteger)page
                   pageCount:(NSInteger)pageCount
                     success:(void(^)(NSInteger code,NSString *message,id data))success
                     failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
  //  shopId = @"1";
    
    
   // shop/{shopid}/couponPromotion
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/shop/%@/couponPromotion",SafeString(shopId)];
    
    
    
   // NSString *promotionType = [@"即时优惠" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSDictionary *parm = @{@"type":@"即时优惠"};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
    }];

    
    
    
    
}


-(void)requestNormalCoupon:(NSString*)shopId
                      page:(NSInteger)page
                 pageCount:(NSInteger)pageCount
                   success:(void(^)(NSInteger code,NSString *message,id data))success
                   failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    //http://192.168.6.97:8080/diamond-sis-web/v1/couponPromotion?shopid=11&type=即时优惠
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    shopId=@"11";
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/shop/%@/couponPromotion",SafeString(shopId)];
    
   //   NSString *promotionType = [@"普通优惠" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *parm = @{@"shopid":shopId,@"type":@"普通优惠",@"page":@(page),@"per_page":@(pageCount)};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
    }];
    
    
    
    
    
}


-(void)requestCouponInfo:(NSString*)couponId
                 success:(void(^)(NSInteger code,NSString *message,id data))success
                 failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponInstance/"];
    
    url = [url stringByAppendingString:couponId];
    
    
    
    
    [req get:url param:nil success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
    }];

    
    
    
    
    
    
}





-(void)queryPortalCoupon:(NSDictionary*)params
                 success:(void(^)(int code,NSString *message,id data))success
                 failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    
    if (success) {
        
        
        NSArray *hotCoupon = [[MockData instance] orderCouponModel:10];
        
        
        success(0,@"",hotCoupon);
        
        
    }
    
    
    return ;
    
    

    
    
    
    
    
    
    
}

-(void)queryShopCoupon:(NSDictionary*)params
               success:(void(^)(int code,NSString *message,id data))success
               failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    if (success) {
        
        
        
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:10];
        
        
        
        
        
        NSArray *timeLimitCoupon = [[MockData instance] randomCouponModel:3];
        
        [data setObject:timeLimitCoupon forKey:@"limit"];
        
     
        
        NSArray *otherCoupon = [[MockData instance] randomCouponModel:5];
    
        data[@"other"] =otherCoupon;
        
        
        success(0,@"",data);
        
        
    }
    
    
    return ;

    
    
    
    
    
    
}

-(void)queryNoUseCoupon:(NSDictionary*)params
                success:(void(^)(int code,NSString *message,id data))success
                failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    

    if (success) {

        NSArray *data = [[MockData instance] randomCouponModel:5];
        
        
        
        success(0,@"",data);
    }
    
    
    
    
    
    
    
}

-(void)queryFinishCoupon:(NSDictionary*)params
                success:(void(^)(int code,NSString *message,id data))success
                failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    
    if (success) {
        
        NSArray *data = [[MockData instance] randomCouponModel:10];
        
        
        
        success(0,@"",data);
    }
    
    
    
    
    
    
    
}

-(void)queryByKeyword:(NSDictionary*)params
                 success:(void(^)(int code,NSString *message,id data))success
                 failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    if (success) {
        
        NSArray *data = [[MockData instance] randomCouponModel:15];
        
        
        
        success(0,@"",data);
    }

    
    
    
    
}

-(void)queryRemindCoupon:(NSDictionary*)params
                 success:(void(^)(int code,NSString *message,id data))success
                 failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    if (success) {
        
        NSArray *data = [[MockData instance] randomCouponModel:15];
        
        
        
        success(0,@"",data);
    }
    
    
    
    
    
}


-(void)queryDrawBackCoupon:(NSDictionary*)params
                 success:(void(^)(int code,NSString *message,id data))success
                 failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    
    if (success) {
        
        NSArray *data = [[MockData instance] randomCouponModel:10];
        
        
        
        success(0,@"",data);
    }
    
    
    
    
    
}







@end
