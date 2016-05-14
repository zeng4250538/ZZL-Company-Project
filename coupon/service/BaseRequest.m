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
        
        
        NSLog(@"======================>\n[DEBUG][GET][Request] url = %@ param = %@ [/DEBUG]",url,param);
        
        
        NSLog(@"[DEBUG][GET][Response] %@ [/DEBUG]\n<<===============================",responseObject);
        
        
        
        
        success(operation.response.statusCode,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"======================>\n[DEBUG][GET][Request] url = %@ param = %@ [/DEBUG]",url,param);

        NSLog(@"[ERROR]GET Method Error error = %@[/ERROR]\n<<<=====================", error);
        
        failure(operation.response.statusCode,error.description);
        
        
    }];

    
    
    
}

-(void)post:(NSString*)url param:(NSDictionary*)param success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure  {
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];

    
    
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/html",@"text/plain", @"application/json",nil];

    //传入的参数
    
    //NSDictionary *parameters = @{@"1":@"XXXX",@"2":@"XXXX",@"3":@"XXXXX"};
    //你的接口地址
    //发送请求
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        NSLog(@"======================>\n[DEBUG][POST][Request] url = %@ param = %@ [/DEBUG]",url,param);
        
        
        NSLog(@"[DEBUG][POST][Response] %@ [/DEBUG]\n<<===============================",responseObject);
        

        
        
        success(operation.response.statusCode,responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"======================>\n[DEBUG][POST][Request] url = %@ param = %@ [/DEBUG]",url,param);
        
        NSLog(@"[ERROR]POST Method Error error = %@[/ERROR]\n<<<=====================", error);
        
        
        failure(operation.response.statusCode,error.description);
        
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
        
        
        NSLog(@"======================>\n[DEBUG][PUT][Request] url = %@ param = %@ [/DEBUG]",url,param);
        
        
        NSLog(@"JSON: %@", responseObject);
        
        
        success(operation.response.statusCode,responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"put Method Error params=%@ url=%@ error = %@",param,url, error);

        
        
        failure(operation.response.statusCode,error.description);
        
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
        
        NSLog(@"delete Method Error params=%@ url=%@ error = %@",param,url, error);

        
        
        failure(operation.response.statusCode,error.description);
        
    }];
    
    

    
    
    
}

-(void)uploadImage:(NSString*)url  image:(UIImage*)image success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure {
    
    
    
    NSString *fileName=@"aaaa.jpg";
    
    
      NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/html",@"text/plain", @"application/json",nil];
    // 参数
    // 访问路径
    
    url = [url stringByAppendingString:@"?fileName=aaaa.jpg"];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 上传文件
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        success(operation.response.statusCode,responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        failure(operation.response.statusCode,error.description);
    }];

    
}




@end
