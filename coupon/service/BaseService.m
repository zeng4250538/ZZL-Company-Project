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
    
    
    
//    NSString *url = [NSString stringWithFormat:@"http://192.168.6.97:8080/diamond-sis-web/%@",[self version]];
    
  
    
  //  192.168.6.97:8080 BasePath: /diamond-sis-web
    
    
     NSString *url = [NSString stringWithFormat:@"http://183.6.190.75:9780/diamond-sis-web/%@",[self version]];
    
//    183.6.190.75:9780
    
//<<<<<<< HEAD
//    NSString *url = [NSString stringWithFormat:@"http://183.6.190.75:9780/diamond-sis-web/%@",[self version]];
//=======
    
//    NSString *url = [NSString stringWithFormat:@"http://192.168.6.97:8080/diamond-sis-web/%@",[self version]];
//>>>>>>> 074a87fd9b7390ddb7fb7d306c0e12ccf76c841f
    
    return url;
    
    
    
}

-(NSString*)getBaseLoginUrl{
    
    
    
   //     NSString *url = [NSString stringWithFormat:@"http://192.168.6.97:8080/diamond-sis-web/%@",[self version]];

    
   // NSString *url = [NSString stringWithFormat:@"http://120.25.66.110:9998/diamond-client-security-web"];
    
   
     NSString *url = [NSString stringWithFormat:@"http://183.6.190.75:9870/diamond-client-security-web"];
    
    return url;
    
    
}


-(NSString*)version{
    
    return @"v1";
}

-(BOOL)checkParams{
    
    return YES;
}

@end
