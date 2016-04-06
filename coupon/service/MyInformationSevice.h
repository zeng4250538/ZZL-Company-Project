//
//  MyInformationSevice.h
//  coupon
//
//  Created by ZZL on 16/4/5.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInformationSevice : BaseService

-(void)requestMyInformationCustomerID:(NSString *)custpmerID success:(void(^)(id data))success failure:(void(^)(id code))failure;

@end
