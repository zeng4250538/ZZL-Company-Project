//
//  LoginService.m
//  coupon
//
//  Created by chijr on 16/3/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "LoginService.h"

@implementation LoginService




/**
 *   http://120.25.66.110:9998/diamond-client-security-web/oauth/token?username=2347313464&password=328uew93jd93hr9&client_id=clientidofinsightpc&client_secret=clientsecretofinsightpc&grant_type=password

 *
 *
 */





-(void)doLogin:(NSString*)userName
      password:(NSString*)password
       success:(void(^)(NSInteger code,NSString *message,id data))success
       failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
    
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseLoginUrl] stringByAppendingString:@"/oauth/token"];
    
    
    NSString *client_id=@"clientidofinsightpc";
    NSString *client_secret=@"clientsecretofinsightpc";
    NSString *grant_type=@"password";
    
    NSDictionary *parm = @{@"username":userName,
                           @"password":password,
                           @"client_id":client_id,
                           @"client_secret":client_secret,
                           @"grant_type":grant_type
                           };
    
    
    [req get:url param:parm success:^(NSInteger code, id object) {
        
        
        
        success(code,@"",object);
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        failure(code,NO,content,nil);
        
        
        
        
    }];
    

    
    
    
}



    


@end
