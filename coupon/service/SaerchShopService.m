//
//  SaerchShopService.m
//  coupon
//
//  Created by ZZL on 16/3/26.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "SaerchShopService.h"

@implementation SaerchShopService


-(void)requestSaerchShopKeyWord:(NSString *)keyWord success:(void(^)(id data))success failure:(void(^)(id data))failure{

     BaseRequest *req = [BaseRequest new];

     NSString *url = [[self getBaseUrl] stringByAppendingString:@"/search?"];
    
    NSDictionary *parm = @{@"shopmall":@2,@"keyWord":keyWord};
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
    }];
    

}


@end
