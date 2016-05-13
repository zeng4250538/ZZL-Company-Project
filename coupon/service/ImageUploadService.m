//
//  ImageUploadService.m
//  coupon
//
//  Created by chijr on 16/5/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ImageUploadService.h"

@implementation ImageUploadService


-(void)uploadImage:(UIImage*)image success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure{
    
    
    
    BaseRequest *req = [BaseRequest new];
    
    
    NSString *url = [self.getBaseUrl stringByAppendingString:@"/photoupload"];
    
    
    NSTimeInterval dt = [NSDate timeIntervalSinceReferenceDate];
    
    
  //  url = [url stringByAppendingFormat:@"?fileName=aaa"];
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    [req uploadImage:url image:image success:^(NSInteger code, id object) {
        
        
        [SVProgressHUD dismiss];
        
        
        
        success(code,object);
        
        
        NSLog(@"object %@",object);
        
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        [SVProgressHUD dismiss];
        
        failure(code,content);
        
        
        
        NSLog(@"failure %@",content);
        
        
    }];
    

    
    
    
    
    
    
}


@end
