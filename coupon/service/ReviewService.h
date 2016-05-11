//
//  ReviewService.h
//  coupon
//
//  Created by chijr on 16/4/17.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface ReviewService : BaseService


-(void)postReview:(NSString*)shopId
          comment:(NSString*)comment
 couponInstanceId:(NSString*)couponInstanceId
           isLike:(NSUInteger)isLike
          success:(void(^)(NSInteger code,NSString *message,id data))success
          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;
    


@end
