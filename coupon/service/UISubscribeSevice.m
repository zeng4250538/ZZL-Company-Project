//
//  UISubscribeSevice.m
//  coupon
//
//  Created by ZZL on 16/3/29.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "AFNetWorking.h"
#import "UISubscribeSevice.h"

@implementation UISubscribeSevice

-(void)successful:(void(^)(id data))successful failure:(void(^)(id code))failure{
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/15818865756/shopfavorite/"];
    
    NSDictionary *param = @{@"favoriteId":@"12",@"customerId":@"12"};
    
    NSLog(@"%@",param);
    
    
    [req post:url param:param success:^(NSInteger code, id object) {
        
        successful(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(content);
        
    }];
 // http://183.6.190.75:9780/diamond-sis-web/v1/customer/15818865756/shopfavorite/
 // http://183.6.190.75:9780/diamond-sis-web/v1/customer/15818865756/shopfavorite/
}

-(void)cancelSuccessful:(void(^)(id data))successful failure:(void(^)(id code))failure{

    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/15818865756/shopfavorite/"];
    
    NSDictionary *param = @{@"shopid":@"12",@"customerid":@"12"};
    
    [req delete:url param:param success:^(NSInteger code, id object) {
        
        successful(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(content);
        
    }];

}


-(void)judgeSuccessful:(void(^)(id data))successful failure:(void(^)(id code))failure{

    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/15818865756/shopfavorite"];
    
    NSDictionary *param = @{@"shopid":@"12"};
    
    [req get:url param:param success:^(NSInteger code, id object) {
        
        successful(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        successful(content);
        
    }];


}


@end
