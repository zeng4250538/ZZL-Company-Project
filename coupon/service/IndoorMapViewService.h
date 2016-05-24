//
//  IndoorMapViewService.h
//  coupon
//
//  Created by ZZL on 16/5/22.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface IndoorMapViewService : BaseService


-(void)mapReqestSuccess:(void (^) (id data))success withFailure:(void (^) (id data))failure;

@end
