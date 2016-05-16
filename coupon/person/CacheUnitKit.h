//
//  CacheUnitKit.h
//  OfflineVersion
//
//  Created by ZZL on 16/5/11.
//  Copyright © 2016年 com.GuangZhou Rich Stone Data Technologies Company Limited.ZZL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheUnitKit : NSObject

//查询缓存大小
+(float)queryCache;

//清除缓存
+(void)removedCache;
@end
