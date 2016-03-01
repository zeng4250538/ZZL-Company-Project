//
//  AppShareData.h
//  coupon
//
//  Created by chijr on 16/1/18.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppShareData : NSObject

+(instancetype)instance;

-(NSUInteger)addCouponToCart:(NSDictionary*)data;

-(NSUInteger)getCartCount;

-(NSMutableArray*)getCartList;

-(void)openAudio:(BOOL)on;

-(BOOL)isAudioOpen;



@end
