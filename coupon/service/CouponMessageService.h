//
//  CouponMessageService.h
//  coupon
//
//  Created by chijr on 16/4/14.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface CouponMessageService : BaseService




-(void)requestCouponMessageWithPage:(NSInteger)page
                           per_page:(NSInteger)per_page
                             isRead:(BOOL)isRead
                               sort:(NSString*)sort
                            success:(void(^)(NSInteger code,NSString *message,id data))success
                            failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;






@end
