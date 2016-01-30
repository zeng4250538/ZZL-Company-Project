//
//  NSObject+NSJSONSerialization.h
//  emessage
//
//  Created by chijy on 14-8-30.
//  Copyright (c) 2014年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <Foundation/Foundation.h>

@interface NSObject (NSJSONSerialization)

- (NSString *)toJsonString;

@end

@interface NSString (NSJSONSerialization)

- (id)fromJsonString;

@end

