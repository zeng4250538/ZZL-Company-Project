//
//  AppShareData.h
//  coupon
//
//  Created by chijr on 16/1/18.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const UserNameKey;
extern NSString * const PasswordKey;
extern NSString * const AccessTokenKey;
extern NSString * const AudioStatusCloseKey;

extern NSString * const IsLoginKey;


@interface AppShareData : NSObject

@property(nonatomic,strong)NSDictionary *currentMall;


+(instancetype)instance;


-(void)loginOut;

-(void)saveLogin:(NSString*)userName password:(NSString*)password accessToken:(NSString*)accessToken ;

-(BOOL)isLogin;


-(NSUInteger)addCouponToCart:(NSDictionary*)data;



-(NSUInteger)getCartCount;

-(NSMutableArray*)getCartList;

-(void)openAudio:(BOOL)on;

-(BOOL)isAudioOpen;



@end
