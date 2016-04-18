//
//  BaseService.h
//  coupon
//
//  Created by chijr on 16/3/10.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseService : NSObject


-(NSString*)getBaseUrl;
-(NSString*)getBaseLoginUrl;

-(NSString*)getBaseUrlNoVersion;


-(BOOL)checkParams;
-(NSString*)version;

@end
