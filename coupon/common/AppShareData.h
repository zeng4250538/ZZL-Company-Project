//
//  AppShareData.h
//  coupon
//
//  Created by chijr on 16/1/18.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CouponQueue.h"



extern NSString * const UserNameKey;
extern NSString * const PasswordKey;
extern NSString * const AccessTokenKey;
extern NSString * const AudioStatusCloseKey;

extern NSString * const IsLoginKey;

extern NSString *const ReviewUpdateNotice;



@interface AppShareData : NSObject

@property(nonatomic,strong)NSDictionary *currentMall;
@property(nonatomic,strong)CouponQueue *shakeCouponQueue;

@property(nonatomic,copy,readonly)NSString *customId;
@property(nonatomic,copy,readonly)NSString *mallId;
@property(nonatomic,copy,readonly)NSString *city;

@property(nonatomic,copy,readonly)NSString *deviceToken;


@property(nonatomic,copy)NSString *accessToken;

+(instancetype)instance;


-(void)loginOut;

-(void)saveLogin:(NSString*)userName password:(NSString*)password accessToken:(NSString*)accessToken ;

-(void)setCity:(NSString *)city;

-(void)setDeviceToken:(NSString *)deviceToken;





-(void)saveMallId:(NSString*)mallId;

-(BOOL)isLogin;

-(NSUInteger)addCouponToCart:(NSDictionary*)data;

-(NSUInteger)getCartCount;



-(NSMutableArray*)getCartList;

-(void)openAudio:(BOOL)on;

-(BOOL)isAudioOpen;

-(void)myInformationData:(NSDictionary *)data;

-(NSDictionary *)getMyInfromationData;

@end
