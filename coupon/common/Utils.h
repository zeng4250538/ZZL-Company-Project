//
//  Utils.h
//  coupon
//
//  Created by chijr on 15/12/19.
//  Copyright (c) 2015年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^block_t)(void);


void SafeLoadUrlImage(UIView *uv,NSURL *url,block_t completionBlock);



NSString *SafeString(id content);
NSURL *SafeUrl(id content);
BOOL SafeEmpty(id content);
id safeArrayValue(id array,NSInteger pos);

NSString *SafeLeft(NSString *content,NSUInteger length);

void SafePostMessage(NSString* messageName,id body);


BOOL dateBool(id content);

NSString *dateController(id content);

@interface Utils : NSObject

+(NSArray*)getImagePath:(NSString*)addPath;


+(NSString*)getRandomImage:(NSString*)path;

+(NSDictionary*)getRandomData;


+(void)incCoupon;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;

+(void)popTransparentViewCtrl:(UIViewController*)parentViewCtrl childViewCtrl:(UIViewController*)childViewCtrl;

+(NSString*)getOrderImage:(NSString*)path order:(NSInteger)order;

+(void)playShakeSound;


+(void)downCountLabel:(UILabel*)label;

+(NSString*)firstLetter:(NSString*)szString;

+(NSString*)downCountFormat:(NSString*)ymdFormat;

NSDate *SafeDate(NSString* ymd);



+(NSString*)firstLet:(NSString*)szString;


+(NSString*)firstLetAllWord:(NSString*)szString;


















@end
