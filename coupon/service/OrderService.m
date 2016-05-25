//
//  OrderService.m
//  coupon
//
//  Created by chijr on 16/5/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "OrderService.h"

@implementation OrderService


-(void)requestPrepayId:(NSString*)couponInstanceId originalPrice:(CGFloat)originalPrice
          sellingPrice:(CGFloat)sellingPrice
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
//    NSString *customerId=[AppShareData instance].customId;
    
    
   // POST /v1/payment/wechat/order
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/payment/wechat/order"];
    
//    {
//        "couponInstanceId": "string",
//        "originalPrice": 0,
//        "sellingPrice": 0
//    }
    
    NSString *originalPriceStr = [NSString stringWithFormat:@"%.2f",originalPrice];

    NSString *sellPriceStr = [NSString stringWithFormat:@"%.2f",sellingPrice];
    
    
 
    NSDictionary *parm = @{@"couponInstanceId":couponInstanceId,@"originalPrice":originalPriceStr,@"sellingPrice":sellPriceStr};
    
    
    [req post:url param:parm success:^(NSInteger code, id object,AFHTTPRequestOperation *operation) {
        
         NSLog(@"<----点击支付后的信息----object----》%@",object);
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    
    
    
    
    
    
    
    
    
    
}

-(void)requestAliPaySign:(NSString*)couponInstanceId originalPrice:(CGFloat)originalPrice
           sellingPrice:(CGFloat)sellingPrice
                success:(void(^)(NSInteger code,NSString *message,id data))success
                failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    
    
    //    NSString *customerId=[AppShareData instance].customId;
    
    
    // POST /v1/payment/wechat/order
    
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/payment/ali/order"];
    
    //    {
    //        "couponInstanceId": "string",
    //        "originalPrice": 0,
    //        "sellingPrice": 0
    //    }
    
    NSString *originalPriceStr = [NSString stringWithFormat:@"%.2f",originalPrice];
    
    NSString *sellPriceStr = [NSString stringWithFormat:@"%.2f",sellingPrice];
    
    
    
    NSDictionary *parm = @{@"couponInstanceId":couponInstanceId,@"originalPrice":originalPriceStr,@"sellingPrice":sellPriceStr};
    
    
    [req post:url param:parm success:^(NSInteger code, id object,AFHTTPRequestOperation *operation) {
        
        NSLog(@"<----点击支付后的信息----object----》%@",object);
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(code,NO,content,nil);
        
        
    }];
    

    
    
    
    
    
    
    
    
    
    
}



@end
