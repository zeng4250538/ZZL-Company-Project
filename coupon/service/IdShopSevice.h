//
//  IdShopSevice.h
//  coupon
//
//  Created by ZZL on 16/5/30.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface IdShopSevice : BaseService

-(void)shopIdRequrestString:(NSString *)data withSuccess:(void(^)(id data))success withFailure:(void(^)(id data))failure;

@end
