//
//  ConfigService.h
//  coupon
//
//  Created by chijr on 16/5/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface ConfigService : BaseService


-(void)putDeviceToken:(NSString*)deviceToken
              success:(void(^)(NSInteger code,NSString *message,id data))success
              failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;




@end
