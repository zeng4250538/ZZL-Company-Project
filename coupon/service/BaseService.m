//
//  BaseService.m
//  coupon
//
//  Created by chijr on 16/3/10.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService

-(NSString*)getBaseUrlNoVersion{
    
    
    
    
    //    if (!InLan) {
    NSString *url = [NSString stringWithFormat:@"http://183.6.190.75:9780/diamond-sis-web/"];
    
    return url;
    //    }else{
    //        NSString *url = [NSString stringWithFormat:@"http://192.168.6.97:8080/diamond-sis-web/%@",[self version]];
    //
    //        return url;
    //    }
    
    
    
    
}


-(NSString*)getBaseUrl{
    
    
    
    
//    if (!InLan) {
        NSString *url = [NSString stringWithFormat:@"http://183.6.190.75:9780/diamond-sis-web/%@",[self version]];

        return url;
//    }else{
//        NSString *url = [NSString stringWithFormat:@"http://192.168.6.97:8080/diamond-sis-web/%@",[self version]];
//        
//        return url;
//    }
    
    
    
    
}

-(NSString*)getBaseLoginUrl{
   
   //
    
    
    
//    if (!InLan) {
        NSString *url = [NSString stringWithFormat:@"http://183.6.190.75:9780/diamond-client-security-web"];
        return url;

//    }else{
//        
//        NSString *url = [NSString stringWithFormat:@"http://192.168.6.97:8080/diamond-client-security-web"];
//        
//        return url;
//
//        
//    }
   
    
    
    
}


-(NSString*)version{
    
    return @"v1";
}

-(BOOL)checkParams{
    
    return YES;
}

@end
