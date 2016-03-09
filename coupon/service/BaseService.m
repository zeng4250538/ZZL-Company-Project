//
//  BaseService.m
//  coupon
//
//  Created by chijr on 16/3/10.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService

-(NSString*)getBaseUrl{
    
    return @"http://120.25.66.110:9998/diamond-sis-web";
    
}


-(BOOL)checkParams{
    
    return YES;
}

@end
