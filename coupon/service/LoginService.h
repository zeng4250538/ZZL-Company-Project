//
//  LoginService.h
//  coupon
//
//  Created by chijr on 16/3/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface LoginService : BaseService

/**
 *  用户登录
 *
 *  @param userName  登录的用户名
 *  @param password  登录的密码
 *  @param success 成功后回调
 *  @param failure 失败后回调
 */
-(void)doLogin:(NSString*)userName
      password:(NSString*)password
                   success:(void(^)(NSInteger code,NSString *message,id data))success
                   failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;

/**
 *  用户注册
 *
 *  @param params  参数说明
 *  @param success 成功后回调
 *  @param failure 失败后回调
 */


-(void)doRegister:(NSString*)userName
         password:(NSString*)password
 verificationCode:(NSString*)verification
       success:(void(^)(NSInteger code,NSString *message,id data))success
       failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;

//获取验证码
-(void)verificationCode:(NSString *)userName password:(NSString*)password
                success:(void(^)(NSInteger code,NSString *message,id data))success
                failure:(void(^)(id data))failure;

@end
