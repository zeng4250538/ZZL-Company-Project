//
//  FeedbackSevice.m
//  coupon
//
//  Created by ZZL on 16/5/25.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "FeedbackSevice.h"

@implementation FeedbackSevice

-(void)feedbackString:(NSString *)string withSuccess:(void (^)(id data))success withFailure:(void (^)(id data))failure{
//    NSLog(@"---------------------->%@",string);
    //http://192.168.6.97:8080/diamond-sis-web/v1/feedback 意见反馈
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/feedback"];
    NSString *customerId = [AppShareData instance].customId;
    NSDictionary *param = @{@"content":string , @"customerId":customerId};
    
    [req post:url param:param success:^(NSInteger code, id object, AFHTTPRequestOperation *operation) {
        
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(content);
        
    }];




}

@end
