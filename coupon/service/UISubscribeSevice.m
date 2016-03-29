//
//  UISubscribeSevice.m
//  coupon
//
//  Created by ZZL on 16/3/29.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "UISubscribeSevice.h"

@implementation UISubscribeSevice

-(void)successful:(void(^)(id data))successful failure:(void(^)(id code))failure{

    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/15818865760/shopfavorite"];
    
    NSDictionary *param = @{@"favoriteId":@"11",@"customerId":@"15818865760"};
    
    [req post:url param:param success:^(NSInteger code, id object) {
        successful(object);
    } failure:^(NSInteger code, NSString *content) {
        failure(content);
    }];
    

    
}

-(void)cancelSuccessful:(void(^)(id data))successful failure:(void(^)(id code))failure{

    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/shopfavorite"];
    
     NSDictionary *param = @{@"customerid":@"15818865760"};
    
    [req delete:url param:param success:^(NSInteger code, id object) {
        
        successful(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(content);
        
    }];



}


@end
