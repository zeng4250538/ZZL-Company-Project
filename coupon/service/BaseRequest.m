//
//  BaseRequest.m
//  coupon
//
//  Created by chijr on 16/3/9.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest


-(void)get:(NSString*)url param:(NSDictionary*)param  success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        // 提问:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程
        
        success(operation.response.statusCode,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        
        failure(operation.response.statusCode,error.description);
        
    }];

    
    
    
}

-(void)post:(NSString*)url param:(NSDictionary*)param success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure  {
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //传入的参数
    
    //NSDictionary *parameters = @{@"1":@"XXXX",@"2":@"XXXX",@"3":@"XXXXX"};
    //你的接口地址
    //发送请求
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        
        success(operation.response.statusCode,responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        failure(operation.response.statusCode,error.description);
        
        NSLog(@"Error: %@", error);
    }];
    

    
}

-(void)put:(NSString*)url param:(NSDictionary*)param success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //传入的参数
    
    //NSDictionary *parameters = @{@"1":@"XXXX",@"2":@"XXXX",@"3":@"XXXXX"};
    //你的接口地址
    //发送请求
    [manager PUT:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        
        success(operation.response.statusCode,responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        failure(operation.response.statusCode,error.description);
        
        NSLog(@"Error: %@", error);
    }];
    

    
    
    
    
    
    
}

-(void)delete:(NSString*)url param:(NSDictionary*)param  success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure {
    
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //传入的参数
    
    //NSDictionary *parameters = @{@"1":@"XXXX",@"2":@"XXXX",@"3":@"XXXXX"};
    //你的接口地址
    //发送请求
    [manager DELETE:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        
        success(operation.response.statusCode,responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        failure(operation.response.statusCode,error.description);
        
        NSLog(@"Error: %@", error);
    }];
    
    

    
    
    
}


@end
