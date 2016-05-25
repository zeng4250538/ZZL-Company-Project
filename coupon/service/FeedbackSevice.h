//
//  FeedbackSevice.h
//  coupon
//
//  Created by ZZL on 16/5/25.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface FeedbackSevice : BaseService

-(void)feedbackString:(NSString *)string withSuccess:(void (^)(id data))success withFailure:(void (^)(id data))failure;

@end
