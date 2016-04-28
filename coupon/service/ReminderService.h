//
//  ReminderService.h
//  coupon
//
//  Created by chijr on 16/4/28.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface ReminderService : BaseService


-(void)requestReminder:(NSUInteger)page per_page:(NSUInteger)page
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


-(void)deleteReminder:(NSUInteger)reminderId
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;


@end
