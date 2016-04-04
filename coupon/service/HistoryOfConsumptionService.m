//
//  HistoryOfConsumptionService.m
//  coupon
//
//  Created by ZZL on 16/3/24.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "HistoryOfConsumptionService.h"

@implementation HistoryOfConsumptionService

-(void)requestCustomerid:(NSString *)customerid HistoryOfConsumptionSuccess:(void(^)(id data))success failure:(void(^)(NSInteger code))failure{
    
    //http://183.6.190.75:9780/diamond-sis-web/v1/shop/11/couponInstance?status=%E5%B7%B2%E6%B6%88%E8%B4%B9&page=1&per_page=10  ———消费历史
    
    BaseRequest *req = [BaseRequest new];
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/customer/%@/couponinstances",customerid];
//    NSLog(@"-------?>>>%@",url);
//    NSString *urls = [NSString stringWithFormat:@"%@15818865756",url];
    NSDictionary *parm =@{@"status":@""};
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
//        failure(content);
        
    }];
//
}

@end
