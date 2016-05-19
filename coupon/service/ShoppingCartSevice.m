//
//  ShoppingCartSevice.m
//  coupon
//
//  Created by ZZL on 16/5/17.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ShoppingCartSevice.h"

@implementation ShoppingCartSevice

-(void)soppingCartRequestUserId:(NSString *)userId withstatus:(NSString *)status withSuccessful:(void (^)(id))succesful withFailure:(void(^)(id))failure{

    //http://183.6.190.75:9780/diamond-sis-web/v1/couponbasket/basketitem/count?userid=15818865756&status=%E6%9C%AA%E6%B6%88%E8%B4%B9
//    v1/couponbasket/basketitem/count
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/couponbasket/basketitem/count"];
    NSDictionary *param = @{@"userid":userId,@"status":status};
    [req get:url param:param success:^(NSInteger code, id object){
        
        succesful(object);
        
    } failure:^(NSInteger code, NSString *content) {
        failure(content);
    }];

}

@end
