//
//  ShopMessageService.m
//  coupon
//
//  Created by chijr on 16/4/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ShopMessageService.h"

@implementation ShopMessageService


-(void)requestShopMessageWithPage:(NSUInteger)page
                         per_page:(NSUInteger)per_page
                          success:(void(^)(NSInteger code,NSString *message,id data))success
                          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
   // GET /v1/shopMessage
    
    
    
    NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shopMessage"];
    
    
    
    NSDictionary *parm = @{@"customerId":customerId,@"page":@(page),@"perPage":@(per_page),@"isRead":@(NO)};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    
    
    
    
}


-(void)deleteShopMessage:(NSString*)messageId
                 success:(void(^)(NSInteger code,NSString *message,id data))success
                 failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
   // NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shopMessage/"];
    
    url = [url stringByAppendingString:messageId];
    
    
    
    NSDictionary *parm = @{@"id":messageId};
    
    
    [req delete:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    
  
    
    
}


@end
