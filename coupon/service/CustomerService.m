//
//  CustomerService.m
//  coupon
//
//  Created by chijr on 16/4/14.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "CustomerService.h"

@implementation CustomerService

-(void)requestCustomer:(NSString*)customerId
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
  //  GET /v1/customer/{customerId} [摇折扣]查询个人资料

    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/"];
    url = [url stringByAppendingString:customerId];
    
    
    
    [req get:url param:nil success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
    }];
    
    
    
    
    
}

/**
 *  获取消费信息
 *
 *  @param customerId <#customerId description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */


-(void)requestCuponHistoryWithPage:(NSUInteger)page per_page:(NSUInteger)per_page
                   success:(void(^)(NSInteger code,NSString *message,id data))success
                   failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
  //  GET /v1/customer/{customerid}/couponinstances [摇折扣]消费历史
    
    
    NSString *custormId = [AppShareData instance].customId;

    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/"];
    url = [url stringByAppendingString:custormId];
    url = [url stringByAppendingString:@"/couponinstances"];
    
    NSDictionary *param =@{@"status":@"已消费",@"page":@(page),@"per_page":@(per_page)};
    
    
    
    [req get:url param:param success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
    }];

    
    
    
    
    
    
    
}


-(void)updateCustomer:(NSString*)customerId
            fieldType:(CustomerFieldType)fieldType
                value:(NSString*)value
              success:(void(^)(NSInteger code,NSString *message,id data))success
              failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
    NSString *custormId = [AppShareData instance].customId;
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/"];
    url = [url stringByAppendingString:custormId];
    
   
    NSDictionary *param;
   
    if (fieldType == CustomerFieldTypeName) {
        
        param =@{@"nickname":value};
       
    }
    
    if (fieldType == CustomerFieldTypeSex) {
        
        param =@{@"gender":value};
        
    }
 
    if (fieldType == CustomerFieldTypeCity) {
        
        param =@{@"cityName":value};
        
    }

    if (fieldType == CustomerFieldTypePhoto) {
        
        param =@{@"photoUrl":value};
        
    }
    

    
    
    [req put:url param:param success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
    }];

    
    
    
    
    
    
    
    
}




@end
