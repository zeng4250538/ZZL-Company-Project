//
//  HistoryOfConsumptionService.m
//  coupon
//
//  Created by ZZL on 16/3/24.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "HistoryOfConsumptionService.h"

@implementation HistoryOfConsumptionService

-(void)requestHistoryOfConsumptionSuccess:(void(^)(id data))success failure:(void(^)(NSInteger code))failure{

    BaseRequest *req = [BaseRequest new];
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/nearby"];
    NSDictionary *parm =@{};
    [req get:url param:parm success:^(NSInteger code, id object) {
        
    } failure:^(NSInteger code, NSString *content) {
        
    }];
//
}

@end
