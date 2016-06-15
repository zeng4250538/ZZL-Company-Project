//
//  VersionNumberSevice.m
//  coupon
//
//  Created by ZZL on 16/6/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "VersionNumberSevice.h"

@implementation VersionNumberSevice


-(void)versionNumber:(void(^)(id data))success failure:(void(^)(id data))failure{

    //http://192.168.6.97:8080/diamond-sis-web/v1/versionInfo?system=ios&type=customer
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/versionInfo"];

    NSDictionary *param = @{@"system":@"ios",@"type":@"customer"};
    
    [req get:url param:param success:^(NSInteger code, id object) {
        
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure([NSString stringWithFormat:@"%ld",code]);
        
    }];

}


@end
