//
//  UISubscribeSevice.m
//  coupon
//
//  Created by ZZL on 16/3/29.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "AFNetWorking.h"
#import "UISubscribeSevice.h"
#import "AppShareData.h"

@implementation UISubscribeSevice

-(void)string:(NSString *)string successful:(void(^)(id data))successful failure:(void(^)(id code))failure{
    
    
    BaseRequest *req = [BaseRequest new];
    
    AppShareData *app = [AppShareData instance];
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/customer/%@/shopfavorite",app.customId];
    
    NSDictionary *param = @{@"favoriteId":string,@"customerId":app.customId};
    
    NSLog(@"%@",param);
    
    
    [req post:url param:param success:^(NSInteger code, id object) {
        
        successful(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(content);
        
    }];
 // http://183.6.190.75:9780/diamond-sis-web/v1/customer/15818865756/shopfavorite/
 // http://183.6.190.75:9780/diamond-sis-web/v1/customer/15818865756/shopfavorite/
}

-(void)string:(NSString *)string cancelSuccessful:(void(^)(id data))successful failure:(void(^)(id code))failure{

    BaseRequest *req = [BaseRequest new];
    
    AppShareData *app = [AppShareData instance];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/shopfavorite"];
    
    NSDictionary *param = @{@"shopid":string,@"customerid":app.customId};
    
    [req delete:url param:param success:^(NSInteger code, id object) {
        
        successful(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(content);
        
    }];

}
//http://183.6.190.75:9780/diamond-sis-web/v1/shop/2/favorite?customerId=15818865756
//http://183.6.190.75:9780/diamond-sis-web/v1shop/2/favorite?customerId=15818865756
-(void)string:(NSString *)string judgeSuccessful:(void(^)(id data))successful failure:(void(^)(id code))failure{

    BaseRequest *req = [BaseRequest new];
    
    AppShareData *app = [AppShareData instance];

    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/shop/%@/favorite",string];
    
    NSDictionary *param = @{@"customerId":app.customId};
    
    [req get:url param:param success:^(NSInteger code, id object) {
        
        successful(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        successful(content);
        
    }];


}


@end
