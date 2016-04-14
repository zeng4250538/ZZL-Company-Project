//
//  ShopCommentSevice.m
//  coupon
//
//  Created by ZZL on 16/4/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ShopCommentSevice.h"
#import "AppShareData.h"
@implementation ShopCommentSevice

-(void)requestParam:(NSDictionary *)param success:(void(^)(id data))success failure:(void(^)(id coad))failure{
//http://183.6.190.75:9780/diamond-sis-web/v1/customer/15818865756/review?page=1&per_page=10&sort=-time

    BaseRequest *req = [BaseRequest new];
    AppShareData *app = [AppShareData instance];
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/customer/%@/review",app.customId];
    [req get:url param:param success:^(NSInteger code, id object) {
        
//        NSLog(@"-----------我的评价数据------------%@",object);
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(content);
    }];


}

@end
