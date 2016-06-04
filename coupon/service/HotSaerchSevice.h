//
//  HotSaerchSevice.h
//  coupon
//
//  Created by ZZL on 16/6/3.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface HotSaerchSevice : BaseService

//http://192.168.6.97:8080/diamond-sis-web/v1/listHotSearch?shopMallId=11&pageIndex=1&pageItemCount=8&cityName=%E5%B9%BF%E5%B7%9E%E5%B8%82
-(void)hotSearchRequest:(NSString *)shopMallId withPage:(NSString *)page withPageCount:(NSString *)pageCount withCityName:(NSString *)cityName success:(void(^)(id data))success failure:(void(^)(id data))failure;

@end
