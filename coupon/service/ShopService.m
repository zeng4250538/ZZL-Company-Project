//
//  ShopService.m
//  coupon
//
//  Created by chijr on 16/2/6.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopService.h"
#import "AppShareData.h"
@implementation ShopService



//http://120.25.66.110:9998/diamond-sis-web/v1/shoprecommand?shopmallid=53420473120&userid=13693284393&page=1&per_page=3




-(void)requestRecommendShop:(NSString*)mallid  page:(NSInteger)page pageCount:(NSInteger)pageCount
                  success:(void(^)(NSInteger code,NSString *message,id data))success
                  failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{

    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shoprecommend?"];
    
    NSString *customerId = [AppShareData instance].customId;
    
    NSDictionary *parm = @{@"shopMallId":mallid,
                           @"customerId":customerId,
                           @"page":@(page),
                           @"per_page":@(pageCount)};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
   
    
}





//http://120.25.66.110:9998/diamond-sis-web/v1/nearby?shopmallid=53420473120&customerid=13693284393&categoryid=34624363243&sort=default

-(void)requestNearbyShop:(NSString*)mallid page:(NSInteger)page per_page:(NSInteger)per_page
                 success:(void(^)(NSInteger code,NSString *message,id data))success
                 failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/nearby?"];
    
    NSDictionary *parm = @{@"shopMallId":mallid,@"page":@(page),@"per_page":@(per_page)};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
   
    
}

-(void)requestNearbyShopWithFilter:(NSString*)mallid page:(NSInteger)page per_page:(NSInteger)per_page
                               cat:(NSString*)cat sort:(NSString*)sort
                 success:(void(^)(NSInteger code,NSString *message,id data))success
                 failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/nearby?"];
    
    NSDictionary *param =nil;
    
  
    
    if ([sort length]==0) {
        sort=@"default";
    }
    
    if ([cat length]>0) {
        
        
        param= @{@"shopMallId":mallid,
            @"sort":sort,
            @"categoryId":cat,
            @"page":@(page),@"per_page":@(per_page)};
        
        

    }else{
        
        param= @{@"shopMallId":mallid,
                 @"sort":sort,
                 @"page":@(page),@"per_page":@(per_page)};
        
        
        
    }
    
    
    [req get:url param:param success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
}



-(void)requestKeyword:(NSString*)mallid keyWord:(NSString*)keyWord
                    success:(void(^)(NSInteger code,NSString *message,id data))success
                    failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/search?"];
    
    NSDictionary *parm = @{@"shopMallId":mallid,@"keyword":keyWord};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
       
    }];
    
}


-(void)requestDoGood:(NSString*)shopid
                mode:(BOOL)mode
             success:(void(^)(NSInteger code,NSString *message,id data))success
             failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
   // shop/514344/good
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shop"];
    
    url = [url stringByAppendingString:shopid];
    url = [url stringByAppendingString:@"/good"];
    
    
    
    
    NSDictionary *parm = @{@"customerId":@"xxxx",
                           @"shopId":shopid,
                           @"isLike":@(YES)};
    
    if (mode==YES) {
        
        [req post:url param:parm success:^(NSInteger code, id object) {
            
            success(code,@"",object);
            
        } failure:^(NSInteger code, NSString *content) {
            
            failure(code,NO,content,nil);
            
            
        }];
        
        

        
    }else{
        
        
        [req delete:url param:parm success:^(NSInteger code, id object) {
            
            success(code,@"",object);
            
        } failure:^(NSInteger code, NSString *content) {
            
            failure(code,NO,content,nil);
            
            
        }];
       
    }
   
}


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
            failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    
}


-(void)requestFav:(NSString*)shopid
          success:(void(^)(NSInteger code,NSString *message,id data))success
          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
   // http://120.25.66.110:9998/diamond-sis-web/v1/customer/13693284393/shopfavorite/
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    // shop/514344/good
    
    
    NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shop/"];
    
    url = [url stringByAppendingString:shopid];
    
    url = [url stringByAppendingString:@"/favorite"];
    
    
    
   
    NSDictionary *parm = @{@"customerId":customerId};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
         
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
        
        
        
    
}




-(void)requestShopComment:(NSString*)shopid
                     page:(NSInteger)page
                pageCount:(NSInteger)pageCount
                     sort:(NSString*)sort
                  success:(void(^)(NSInteger code,NSString *message,id data))success
                  failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/review"];
    
    NSDictionary *parm = @{@"shopid":shopid,@"page":@(page),@"per_page":@(pageCount)};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
}

-(void)requestShopInfo:(NSString* )shopId
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shop/"];
    url = [url stringByAppendingString:shopId];
 
    
    [req get:url param:nil success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
         
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];

    
    
    
    
    
}



-(void)queryShopPortalData:(NSDictionary*)params
                  success:(void(^)(int code,NSString *message,id data))success
                  failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    
    if (success) {
        
        
        NSArray *hotshop = [[MockData instance] randomShopModel:3];
        
        NSArray *hotbrand = [[MockData instance] randomShopModel:3];
        
        
        NSArray *hotcoupon = [[MockData instance] orderCouponModel:3];
        
        NSDictionary *data = @{@"hotshop":hotshop,@"hotcoupon":hotcoupon,@"hotbrand":hotbrand};
        
        success(0,@"",data);
        
        
    }
    
    
    return ;
    
}


-(void)queryMoreHotShop:(NSDictionary*)params
               success:(void(^)(int code,NSString *message,id data))success
               failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure{
    AppShareData *app = [AppShareData new];
    BaseRequest *req = [BaseRequest new];
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/customer/%@/favorite",app.customId];
//    NSDictionary *parm = @{@"shopmallid":@"2",@"categoryid":@"00001"};
    [req get:url param:nil success:^(NSInteger code, id object) {
        
        
        success(1,@"",object);
//        NSLog(@"%@------->",object);
    } failure:^(NSInteger code, NSString *content) {
        
        failure(0,NO,@"",content);
        
    }];
   
}

-(void)doFav:(NSString*)shopid
     success:(void(^)(NSInteger code,NSString *message,id data))success
     failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
//    POST /v1/customer/{customerid}/shopfavorite [摇折扣]订阅商家
//    Implementation Notes
//    用户订阅商家
//    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
    NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/"];
    
    url = [url stringByAppendingString:customerId];
    
    url = [url stringByAppendingString:@"/shopfavorite"];
    
    
    NSDictionary *parm = @{@"favoriteId":shopid,@"customerId":customerId};
    
    
    [req post:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    

    
    
    
    
    
}





-(void)doUnFav:(NSString*)shopid
       success:(void(^)(NSInteger code,NSString *message,id data))success
       failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
  //  DELETE /v1/customer/shopfavorite [摇折扣]取消订阅商家

    
    
    
    
    NSString *customerId=[AppShareData instance].customId;
    
    
  //  NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/shopfavorite"];
    
  ///  NSDictionary *param = @{@"shopid":@"2",@"customerid":@"15818865756"};
    
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/shopfavorite/"];
    
    
     
    
    NSDictionary *parm = @{@"customerId":customerId,@"shopId":shopid};
    
    
    [req delete:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    
    

    
    
    
    
    
    
    
}


-(void)requestMyFavList:(void(^)(NSInteger code,NSString *message,id data))success
                failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    // GET /v1/customer/{customerId}/favorite [摇折扣]获取用户订阅的商家

    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
    NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/"];
    
    
    
    url = [url stringByAppendingString:customerId];
    
    url = [url stringByAppendingString:@"/favorite"];
    
    
   // NSDictionary *parm = @{@"customerId":customerId};
    
    
    [req get:url param:nil success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    
    

    
    
    
    
    
    
    
    
}






@end
