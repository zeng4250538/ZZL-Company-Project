//
//  BaseRequest.h
//  coupon
//
//  Created by chijr on 16/3/9.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject


-(void)get:(NSString*)url param:(NSDictionary*)param success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure  ;

-(void)post:(NSString*)url param:(NSDictionary*)param success:(void(^)(NSInteger code,id object,AFHTTPRequestOperation *operation))success  failure:(void(^)(NSInteger code,NSString *content))failure  ;



-(void)put:(NSString*)url param:(NSDictionary*)param success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure;
    

-(void)delete:(NSString*)url param:(NSDictionary*)param  success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure;


-(void)uploadImage:(NSString*)url  image:(UIImage*)image success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure;







@end
