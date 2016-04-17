//
//  CommentService.m
//  coupon
//
//  Created by chijr on 16/4/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "CommentService.h"

@implementation CommentService


-(void)requestCommentWithShop:(NSString*)shopId page:(NSInteger)page
                     per_page:(NSInteger)per_page
                         sort:(NSString*)sort
                      success:(void(^)(NSInteger code,NSString *message,id data))success
                      failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
//    GET /v1/shop/{shopId}/review [摇折扣]查看商店的评论
//    Implementation Notes
//    获取某商店的所有评论
//    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
   // NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shop/"];
    
    url = [url stringByAppendingString:shopId];
    
    url = [url stringByAppendingString:@"/review"];
    
    
    NSDictionary *parm = @{@"shopId":shopId,@"page":@(page),@"per_page":@(per_page),@"sort":@"-time"};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];

    
    
    
    
}

-(void)requestCommentWithCustomer:(NSString*)shopId page:(NSInteger)page
                         per_page:(NSInteger)per_page
                             sort:(NSString*)sort
                          success:(void(^)(NSInteger code,NSString *message,id data))success
                          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
   // GET /v1/customer/{customerId}/review
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
     NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/"];
    
    url = [url stringByAppendingString:customerId];
    
    url = [url stringByAppendingString:@"/review"];
    
    
    NSDictionary *parm = @{@"customerId":customerId,@"page":@(page),@"per_page":@(per_page),@"sort":@"-time"};
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    

    
    
    
    
    
    
    
    
    
}


-(void)postReview:(NSString*)shopId
          comment:(NSString*)comment
           isLike:(NSUInteger)isLike
          success:(void(^)(NSInteger code,NSString *message,id data))success
          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
     
    BaseRequest *req = [BaseRequest new];
    
    
    NSString *customerId=[AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/review"];
    
    
    
    NSDictionary *parm = @{@"id":@(1),@"customerId":customerId,
                           @"shopId":shopId,
                           @"comment":comment,
                           @"isLike":@(isLike)};
    
    
    [req post:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
}



@end
