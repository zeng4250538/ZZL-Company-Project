//
//  ClearCache.m
//  coupon
//
//  Created by ZZL on 16/5/16.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "ClearCache.h"

@implementation ClearCache

+(float)queryCache{
    
    return [self clearCache];
}

+(float)clearCache{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    float folderSize;
    
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFile = [fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFile) {
            NSString *fullPath = [path stringByAppendingPathComponent:fileName];
            folderSize+=[self fileSizePath:fullPath];
        }
    }
    
    return folderSize;
}

+(float)fileSizePath:(NSString *)path{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    
    return 0.0;
}


+(void)removedCache{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childeFile = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childeFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    
}


@end
