//
//  NSNull+Json.m
//  coupon
//
//  Created by chijr on 16/4/5.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "NSNull+Json.h"

@implementation NSNull (JSON)


- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)searchSet{
    
    return NSMakeRange(0,0);
    
    
}



- (NSUInteger)length {
    
    
   // [str rangeOfCharacterFromSet:nil options:NSCaseInsensitiveSearch];
    return 0;
}

- (NSInteger)integerValue { return 0; };

- (float)floatValue { return 0; };

- (NSString *)description { return @"0(NSNull)"; }

- (NSArray *)componentsSeparatedByString:(NSString *)separator { return @[]; }

- (id)objectForKey:(id)key { return nil; }

- (BOOL)boolValue { return NO; }

@end