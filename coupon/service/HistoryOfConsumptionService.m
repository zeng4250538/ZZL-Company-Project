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

    BaseRequest *req = [BaseRequest new];
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/nearby/"];
    NSString *urls = [NSString stringWithFormat:@"%@15818865760",url];
    NSDictionary *parm =@{@"status":@""};
    [req get:urls param:parm success:^(NSInteger code, id object) {
        
    } failure:^(NSInteger code, NSString *content) {
        
    }];
//
}

@end
