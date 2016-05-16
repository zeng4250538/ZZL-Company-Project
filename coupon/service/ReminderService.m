//
//  ReminderService.m
//  coupon
//
//  Created by chijr on 16/4/28.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ReminderService.h"

@implementation ReminderService

-(void)requestReminder:(NSUInteger)page per_page:(NSUInteger)per_page
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
    NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/reminder"];
    
    
    
    NSDictionary *parm = @{@"customerId":customerId,@"page":@(page),@"per_page":@(per_page),@"sort":@"-id"};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    
    
    
    
    
    
    
    
}

-(void)deleteReminder:(NSUInteger)reminderId
              success:(void(^)(NSInteger code,NSString *message,id data))success
              failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    
}


-(void)addReminder:(NSString*)couponPromotionId
           success:(void(^)(NSInteger code,NSString *message,id data))success
           failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
    NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/reminder"];
    
    
    
    NSDictionary *parm = @{@"customerId":customerId,
                           @"couponPromotion":@{
                                   @"id":couponPromotionId
                                   }
                           };
    
              
    
    [req post:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    
    
    
    

    
    
    
    
    
    
    
}




@end
