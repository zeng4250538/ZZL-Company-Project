//
//  MyInformationSevice.m
//  coupon
//
//  Created by ZZL on 16/4/5.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "MyInformationSevice.h"

@implementation MyInformationSevice

-(void)requestMyInformationCustomerID:(NSString *)custpmerID success:(void (^)(id))success failure:(void (^)(id))failure{

    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/customer/%@",custpmerID];
    
    [req get:url param:nil success:^(NSInteger code, id object) {
        
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
//        NSLog(@"%d %@",code,content);
        success(content);
    }];


}

@end
