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
    
    
    NSString *url = [NSString stringWithFormat:@"http://120.25.66.110:9998/diamond-sis-web/%@",[self version]];
    
    return url;
    
    
    
}


-(NSString*)version{
    
    return @"v1";
}

-(BOOL)checkParams{
    
    return YES;
}

@end
