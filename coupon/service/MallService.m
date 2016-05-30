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
    
    
    //http://183.6.190.75:9780/diamond-sis-web/v1/shopmall?city=%E5%B9%BF%E5%B7%9E%E5%B8%82&longitude=10&latitude=10&fields=id%2Cname%2Ccity%2Cdistance%2CmapPhotoUrl
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/shopmall"];
    
    NSDictionary *parm = @{@"city":SafeString(cityName),@"longitude":@(lon),@"latitude":@(lat)};
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
}

-(void)queryMoreHotShop:(NSString*)cityName
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



@end
