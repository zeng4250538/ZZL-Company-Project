//
//  CustomerService.h
//  coupon
//
//  Created by chijr on 16/4/14.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"


typedef NS_ENUM(NSUInteger, CustomerFieldType) {
    CustomerFieldTypeName,
    CustomerFieldTypeCity,
    CustomerFieldTypeSex,
    CustomerFieldTypePhoto
};

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





-(void)updateCustomer:(CustomerFieldType)fieldType
                value:(NSString*)value
              success:(void(^)(NSInteger code,NSString *message,id data))success
              failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;








/**
 *  获取消费信息
 *
 *  @param customerId <#customerId description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */

-(void)requestCuponHistoryWithPage:(NSUInteger)page per_page:(NSUInteger)per_page
                           success:(void(^)(NSInteger code,NSString *message,id data))success
                           failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;





@end
