//
//  ClearCache.h
//  coupon
//
//  Created by ZZL on 16/5/16.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClearCache : NSObject

//查询缓存大小
+(float)queryCache;

//清除缓存
+(void)removedCache;

@end
