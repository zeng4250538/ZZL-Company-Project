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
@property(nonatomic,assign,readonly)double lon;
@property(nonatomic,assign,readonly)double lat;
@property(nonatomic,strong,readonly)NSDate  *lastLocationDate;

@property(nonatomic,copy,readonly)NSString  *mallName;


//购物车数量
@property(nonatomic,assign)NSUInteger shoppingNumberl;


@property(nonatomic,copy,readonly)NSString *deviceToken;


@property(nonatomic,copy)NSString *accessToken;

+(instancetype)instance;


-(BOOL)isNeedLocationUpdate;


-(void)loginOut;

-(void)saveLogin:(NSString*)userName password:(NSString*)password accessToken:(NSString*)accessToken ;

-(void)setCity:(NSString *)city;

-(void)setDeviceToken:(NSString *)deviceToken;


//我改的。。。可删（已使用篮子数量）
-(NSInteger)shoppingCartNumber:(id)data;


-(void)saveMallId:(NSString*)mallId;

-(BOOL)isLogin;

-(NSInteger)addCouponToCart:(NSDictionary*)data;

-(NSInteger)getCartCount;



-(NSMutableArray*)getCartList;

-(void)openAudio:(BOOL)on;

-(BOOL)isAudioOpen;

-(void)myInformationData:(NSDictionary *)data;

-(NSDictionary *)getMyInfromationData;

-(void)setLat:(double)lat;

-(void)setLon:(double)lon;

-(void)setLastLocationDate:(NSDate *)lastLocationDate;

-(void)setMallName:(NSString *)mallName;



-(NSString*)customTestId;

-(void)addMallIdKVO:(id)delegate;

-(void)removeMallIdKVO:(id)delegate;







@end
