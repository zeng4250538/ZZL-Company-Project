//
//  HistoryOfConsumptionService.h
//  coupon
//
//  Created by ZZL on 16/3/24.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryOfConsumptionService : BaseService

@property(nonatomic,strong)id customerid;

-(void)requestCustomerid:(NSString *)customerid HistoryOfConsumptionSuccess:(void(^)(id data))success failure:(void(^)(NSInteger code))failure;

@end
