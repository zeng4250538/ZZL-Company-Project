//
//  Utils.h
//  coupon
//
//  Created by chijr on 15/12/19.
//  Copyright (c) 2015年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(NSArray*)getImagePath:(NSString*)addPath;


+(NSString*)getRandomImage:(NSString*)path;

+(NSDictionary*)getRandomData;


+(void)incCoupon;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;




@end
