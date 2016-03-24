//
//  PersonService.h
//  coupon
//
//  Created by chijr on 16/3/22.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface PersonService : BaseService

-(void)requestShakeCoupon:(NSString*)mallid
                  success:(void(^)(NSInteger code,NSString *message,id data))success
                  failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


@end
