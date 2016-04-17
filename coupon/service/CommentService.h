//
//  CommentService.h
//  coupon
//
//  Created by chijr on 16/4/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "BaseService.h"

@interface CommentService : BaseService

/**
 *  评论查询接口
 *
 *  @param shopId   <#shopId description#>
 *  @param page     <#page description#>
 *  @param per_page <#per_page description#>
 *  @param sort     <#sort description#>
 *  @param success  <#success description#>
 *  @param failure  <#failure description#>
 */
-(void)requestCommentWithShop:(NSString*)shopId page:(NSInteger)page
                     per_page:(NSInteger)per_page
                         sort:(NSString*)sort
                success:(void(^)(NSInteger code,NSString *message,id data))success
                failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;

/**
 *  用户评论查询
 *
 *  @param shopId   <#shopId description#>
 *  @param page     <#page description#>
 *  @param per_page <#per_page description#>
 *  @param sort     <#sort description#>
 *  @param success  <#success description#>
 *  @param failure  <#failure description#>
 */
-(void)requestCommentWithCustomer:(NSString*)shopId page:(NSInteger)page
                     per_page:(NSInteger)per_page
                         sort:(NSString*)sort
                      success:(void(^)(NSInteger code,NSString *message,id data))success
                      failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;




-(void)postReview:(NSString*)shopId
          comment:(NSString*)comment
           isLike:(NSUInteger)isLike
          success:(void(^)(NSInteger code,NSString *message,id data))success
          failure:(void(^)(NSInteger code,BOOL retry,NSString*message,id data))failure;





@end
