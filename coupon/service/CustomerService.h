//
//  CustomerService.h
//  coupon
//
//  Created by chijr on 16/4/14.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface CustomerService : BaseService

/**
 *  获取用户信息
 *
 *  @param coustomId <#coustomId description#>
 *  @param success   <#success description#>
 *  @param failure   <#failure description#>
 */
-(void)requestCustomer:(NSString*)customerId
                success:(void(^)(NSInteger code,NSString *message,id data))success
                failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


@end
