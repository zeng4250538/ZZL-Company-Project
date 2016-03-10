//
//  MallService.m
//  coupon
//
//  Created by chijr on 16/3/10.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "MallService.h"

@implementation MallService

-(void)queryMallByCity:(NSString*)cityName
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shopmall"];
    
    NSDictionary *parm = @{@"city":cityName};
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
          success(code,@"",object);
            
        
        
    } failure:^(NSInteger code, NSString *content) {
        
    
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
    
    
}

-(void)queryMallByNear:(NSString*)cityName
                   lon:(double)lon
                   lat:(double)lat
               success:(void(^)(NSInteger code,NSString *message,id data))success
               failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shopmall"];
    
    NSDictionary *parm = @{@"city":cityName,@"lon":@(lon),@"lat":@(lat)};
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
}



@end
