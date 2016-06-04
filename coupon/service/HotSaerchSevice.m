//
//  HotSaerchSevice.m
//  coupon
//
//  Created by ZZL on 16/6/3.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "HotSaerchSevice.h"

@implementation HotSaerchSevice

-(void)hotSearchRequest:(NSString *)shopMallId withPage:(NSString *)page withPageCount:(NSString *)pageCount withCityName:(NSString *)cityName success:(void(^)(id data))success failure:(void(^)(id data))failure{

    //http://192.168.6.97:8080/diamond-sis-web/v1/listHotSearch?shopMallId=11&pageIndex=1&pageItemCount=8&cityName=%E5%B9%BF%E5%B7%9E%E5%B8%82

    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/listHotSearch"];

    NSDictionary *param = @{@"shopMallId":shopMallId,@"pageIndex":page,@"pageItemCount":pageCount,@"cityName":cityName};
    
    [req get:url param:param success:^(NSInteger code, id object) {
        success(object);
    } failure:^(NSInteger code, NSString *content) {
        failure(content);
    }];


}

@end
