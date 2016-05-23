//
//  IndoorMapViewService.m
//  coupon
//
//  Created by ZZL on 16/5/22.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "IndoorMapViewService.h"

@implementation IndoorMapViewService

-(void)mapReqestSuccess:(void (^) (id data))success withFailure:(void (^) (id data))failure{

    //http://183.6.190.75:9780/diamond-sis-web/v1/shopmall/11?fields=id%2Cname%2Ccity%2Cdistance%2CmapPhotoUrl
//    AppShareData *app = []
    BaseRequest *req = [BaseRequest new];
    
    NSString *url = [[self getBaseUrl] stringByAppendingFormat:@"/shopmall/%@",[AppShareData instance].mallId];
    NSDictionary *param = @{@"fields":@"id,name,city,distance,mapPhotoUrl"};
    [req get:url param:param success:^(NSInteger code, id object) {
       
        success(object);
        
    } failure:^(NSInteger code, NSString *content) {
        
        failure(content);
        
    }];


}

@end
