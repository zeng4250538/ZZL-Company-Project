//
//  MallService.h
//  coupon
//
//  Created by chijr on 16/3/10.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface MallService : BaseService


//通过城市名称查询下属所有的商场

-(void)queryMallByCity:(NSString*)cityName
                   success:(void(^)(NSInteger code,NSString *message,id data))success
                   failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;




-(void)queryMoreHotShop:(NSDictionary*)params
                success:(void(^)(int code,NSString *message,id data))success
                failure:(void(^)(int code,BOOL retry,NSString*message,id data))failure;



@end
