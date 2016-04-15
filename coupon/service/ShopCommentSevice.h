//
//  ShopCommentSevice.h
//  coupon
//
//  Created by ZZL on 16/4/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCommentSevice : BaseService

//查看用户评论
-(void)requestParam:(NSDictionary *)param success:(void(^)(id data))success failure:(void(^)(id coad))failure;

//用户删除评论
-(void)removeRaviewRequestCommentID:(NSString *)CommentID success:(void(^)(id data))success failure:(void(^)(id code))failure;

//查看商家评论
-(void)ShopCommentRequestDictionary:(NSDictionary *)dic shopID:(NSString *)shopID success:(void(^)(id data))success failure:(void(^)(id code))failure;

@end
