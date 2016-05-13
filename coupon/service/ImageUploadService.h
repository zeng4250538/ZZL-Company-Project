//
//  ImageUploadService.h
//  coupon
//
//  Created by chijr on 16/5/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface ImageUploadService : BaseService


-(void)uploadImage:(UIImage*)image success:(void(^)(NSInteger code,id object))success  failure:(void(^)(NSInteger code,NSString *content))failure;


@end
