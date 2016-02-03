//
//  NSObject+NSJSONSerialization.m
//  emessage
//
//  Created by chijy on 14-8-30.
//  Copyright (c) 2014年 cmcc. All rights reserved.
//

#import "NSObject+NSJSONSerialization.h"


@implementation NSObject (NSJSONSerialization)

- (NSString *)toJsonString {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    
    if (!jsonData) {
        NSLog(@"toJsonString error: %@", error);
        return @"";
    }
    
    NSString* jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

@end

@implementation NSString (NSJSONSerialization)

- (id)fromJsonString {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData) {
        NSLog(@"fromJsonString error: %@", error);
        return nil;
    }
    
    return jsonObject;
}

@end
