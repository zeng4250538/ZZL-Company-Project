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


-(void)doRegister:(NSString*)userName
         password:(NSString*)password
 verificationCode:(NSString*)verification
          success:(void(^)(NSInteger code,NSString *message,id data))success
          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure{
    
      //http://192.168.6.97:8080/diamond-sis-web/v1/customer
    
    BaseRequest *req = [BaseRequest new];
     NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer"];
    NSDictionary *param = @{@"phoneMsisdn":userName,@"passwordCredential":@{@"password":password},@"smscode":verification};
    [req post:url param:param success:^(NSInteger code, id object, AFHTTPRequestOperation *operation) {
        
        success(code,@"",object);
        
    } failure:^(NSInteger code, NSString *content) {
       
        failure(code , NO ,@"",content);
        
    }];
    


}



//获取验证码
-(void)verificationCode:(NSString *)userName password:(NSString*)password
                success:(void(^)(NSInteger code,NSString *message,id data))success
                failure:(void(^)(id data))failure{

    BaseRequest *req = [BaseRequest new];
    NSDate *time = [[NSDate alloc]init];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyyMMddHHssmm";
    NSString *strTime = [format stringFromDate:time];
    
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/smscode"];
    NSDictionary *param = @{@"mobile":userName,@"createdTime":strTime,@"type":password};
    [req post:url param:param success:^(NSInteger code, id object, AFHTTPRequestOperation *operation) {
        success(code,@"",object);
    } failure:^(NSInteger code, NSString *content) {
        failure(content);
    }];



}

//重置密码
-(void)modifyPassword:(NSString *)passWord withNewPassword:(NSString *)newPassword withRepeatPassword:(NSString *)repeatPassword success:(void(^)(id data))success failure:(void(^)(id data))failure{

    
        //http://183.6.190.75:9780/diamond-sis-web/v1/customer/15818865756/password
    
        BaseRequest *req = [BaseRequest new];
        NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/customer/%@/password",[AppShareData instance].customId];
        NSDictionary *param = @{@"oldPassword":passWord,@"newPassword":newPassword,@"repeatPassword":repeatPassword};
        [req put:url param:param success:^(NSInteger code, id object) {
    
            success(object);
        } failure:^(NSInteger code, NSString *content) {
            failure(content);
        }];

}


//验证验证码是否通过
-(void)verificationCodeIsPassedModify:(NSString *)modify withCode:(NSString *)code withType:(NSString *)type success:(void(^)(id data))success failure:(void(^)(id data))failure{
    
    //http://192.168.6.97:8080/diamond-sis-web/v1/verifySms?mobile=15360894730&code=1111111&type=1
    
    BaseRequest *req = [BaseRequest new];
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/verifySms"];
    NSDictionary *param = @{@"mobile":modify,@"code":code,@"type":type};
    [req get:url param:param success:^(NSInteger code, id object) {
        
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(content);
        
    }];

}


//找回密码
-(void)retrievePasswordPhone:(NSString *)phone withNewPassword:(NSString *)newPassword withRepeatPassword:(NSString *)repeatPassword success:(void(^)(id data))success failure:(void(^)(id data))failure{

    //http://192.168.6.97:8080/diamond-sis-web/v1/customer/15818865756/resetCustomerPassword
    
    BaseRequest *req = [BaseRequest new];
    NSString *url = [[self getBaseUrl] stringByAppendingString:@"/customer/resetCustomerPassword"];
     NSDictionary *param = @{@"phoneMsisdn":phone,@"newPassword":newPassword,@"repeatPassword":repeatPassword};
    [req put:url param:param success:^(NSInteger code, id object) {
        
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure([NSString stringWithFormat:@"%ld",code]);
        
    }];


}

@end
