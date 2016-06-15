//
//  VersionNumberSevice.h
//  coupon
//
//  Created by ZZL on 16/6/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface VersionNumberSevice : BaseService

-(void)versionNumber:(void(^)(id data))success failure:(void(^)(id data))failure;

@end
