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

@property(nonatomic,copy,readonly)NSString *mallCityName;

@property(nonatomic,copy,readonly)NSString *mallId;

@property(nonatomic,copy,readonly)NSString *city;
@property(nonatomic,assign,readonly)double lon;
@property(nonatomic,assign,readonly)double lat;
@property(nonatomic,strong,readonly)NSDate  *lastLocationDate;

@property(nonatomic,copy,readonly)NSString  *mallName;

@property(nonatomic,strong)NSString *versions;//版本控制

@property(nonatomic,assign,readonly)BOOL  notDisplayImageViaCell;

//通过无线网访问
@property(nonatomic,assign,readonly)BOOL  isViaWLan;


//购物车数量
@property(nonatomic,assign)NSUInteger shoppingNumberl;


@property(nonatomic,copy,readonly)NSString *deviceToken;

@property(nonatomic,assign)int selected;

@property(nonatomic,copy)NSString *accessToken;

-(void)setNotDisplayImageViaCell:(BOOL)notDisplayImageViaCell;



+(instancetype)instance;


-(BOOL)isNeedLocationUpdate;


-(void)loginOut;

-(void)customId:(NSString *)customId saveLogin:(NSString*)userName password:(NSString*)password accessToken:(NSString*)accessToken ;

-(void)setCity:(NSString *)city;

-(void)setDeviceToken:(NSString *)deviceToken;

-(void)setMallCityNameKey:(id)data;

//（已使用篮子数量）
-(NSInteger)shoppingCartNumber:(id)data;

//设置版本号

-(void)versionsSetNumber:(NSString *)versionsNumber;

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

//通知暂时注释
//推送开关
-(void)setUMPush:( id)data;
//推送开关
-(BOOL)getUMPush;


@end
