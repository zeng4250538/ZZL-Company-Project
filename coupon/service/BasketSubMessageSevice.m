//
//  BasketSubMessageSevice.m
//  coupon
//
//  Created by ZZL on 16/5/26.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BasketSubMessageSevice.h"

@implementation BasketSubMessageSevice

-(void)basketMessageRequestMessageId:(NSString *)message withSuccess:(void(^)(id data))success withFailure:(void (^)(id data))failure{

//http://192.168.6.97:8080/diamond-sis-web/v1/couponMessage/1258020558935693000 推送消息详情
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/couponMessage/%@",message];
//    NSString *customerId = [AppShareData instance].customId;
//    NSDictionary *param = @{@"messageId":message};
    
    [req get:url param:nil success:^(NSInteger code, id object) {
        success(object);
    } failure:^(NSInteger code, NSString *content) {
        failure(content);
    }];

}

-(void)removeMessageRequestMessageId:(NSString *)message withSuccess:(void(^)(id data))success withFailure:(void (^)(id data))failure{
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/couponMessage/%@",message];
    [req delete:url param:nil success:^(NSInteger code, id object) {
        
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(content);
        
    }];

}

@end
