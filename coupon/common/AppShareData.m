//
//  AppShareData.m
//  coupon
//
//  Created by chijr on 16/1/18.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "AppShareData.h"
#import "CouponKVO.h"


NSString * const UserNameKey=@"username";
NSString * const PasswordKey=@"password";
NSString * const AccessTokenKey=@"accesstoken";

NSString * const MallIdKey=@"mallid";

NSString * const AudioStatusCloseKey=@"audiostatusclose";

NSString * const IsLoginKey=@"islogin";

NSString * const CustomIdKey=@"customId";

NSString * const myInformationDataKey = @"myInformationData";

NSString * const CityKey = @"city";


NSString *const ReviewUpdateNotice=@"ReviewUpdate";

NSString *const DeviceTokenKey=@"DeviceToken";








@interface AppShareData()

@property(nonatomic,strong)NSMutableArray *cartList;
@property(nonatomic,strong)CouponKVO *couponKVO;



@end


@implementation AppShareData


static AppShareData *instance;




+(instancetype)instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance =[[AppShareData alloc] init];
        
        instance.cartList = [@[] mutableCopy];
        
        instance.shakeCouponQueue =[CouponQueue new];
        
        
        instance.couponKVO = [CouponKVO new];
        
//        instance.selected = 0;
     
        
        

        
        
    });
    
    return instance;
    
    
}



-(void)addMallIdKVO:(id)delegate{
    
    
    [self.couponKVO addObserver:delegate forKeyPath:@"mallId" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
}


-(void)removeMallIdKVO:(id)delegate{
    
    
    [self.couponKVO removeObserver:delegate forKeyPath:@"mallId"];
    
    
    
}

-(void)setCity:(NSString *)city{
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:CityKey];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    
    
}

-(BOOL)notDisplayImageViaCell{
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"notdisplayimageviacell"];
    
}
-(void)setNotDisplayImageViaCell:(BOOL)notDisplayImageViaCell{
    
    [[NSUserDefaults standardUserDefaults] setBool:notDisplayImageViaCell forKey:@"notdisplayimageviacell"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}




-(void)setDeviceToken:(NSString *)deviceToken{
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:DeviceTokenKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}


-(NSString*)deviceToken{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:DeviceTokenKey];
   
    
}

-(NSString*)city{
    
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:CityKey];

    
}

-(void)setLat:(double)lat{
    
    
    [[NSUserDefaults standardUserDefaults] setDouble:lat forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)setLon:(double)lon{
    
    
    [[NSUserDefaults standardUserDefaults] setDouble:lon forKey:@"lon"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


-(double)lat{
    
    
    return [[NSUserDefaults standardUserDefaults] doubleForKey:@"lat"];
    
  
}

-(double)lon{
    
    
    return [[NSUserDefaults standardUserDefaults] doubleForKey:@"lon"];
    
    
}

-(void)setLastLocationDate:(NSDate *)lastLocationDate{
    
    [[NSUserDefaults standardUserDefaults] setObject:lastLocationDate forKey:@"lastDate"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(NSDate*)lastLocationDate{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastDate"];
    
}


-(NSString*)mallName{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"mallName"];
}

-(void)setMallName:(NSString *)mallName{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:mallName forKey:@"mallName"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    
}


-(NSString*)accessToken{
    
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:AccessTokenKey];
    
    
}


-(void)saveMallId:(NSString*)mallId{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:mallId forKey:MallIdKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //KVO通知
    
    self.couponKVO.mallId = mallId;
    
    
    
}


-(NSString*)mallId{
    
    //return @"11";
    
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:MallIdKey];

    
    
}


-(NSString*)customTestId{
    
    
    return @"15818865756";
    
    
}


-(NSString*)customId{
    

    //return @"15818865756";
    
   return SafeString([[NSUserDefaults standardUserDefaults] objectForKey:CustomIdKey]);
    
}


-(void)setCustomId:(NSString *)customId{
    
    
     
    [[NSUserDefaults standardUserDefaults] setObject:customId forKey:CustomIdKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    
}



-(NSMutableArray*)getCartList{
    
    
    return self.cartList;
    
    
    
    
}


//（已使用篮子数量）
-(NSInteger)shoppingCartNumber:(id)data{

    NSString *num = [NSString stringWithFormat:@"%@",data];
    instance.shoppingNumberl = [num integerValue];
    
    return instance.shoppingNumberl;

}

-(NSInteger)getCartCount{
    
//    return [instance.cartList count];
    return instance.shoppingNumberl;
}

-(NSInteger)addCouponToCart:(NSDictionary*)data{
    
    if (data==nil) {
        return 0;
    }
    
//    [instance.cartList addObject:[data mutableCopy]];
    
//    return [instance.cartList count];
    
    instance.shoppingNumberl+=1;
    return instance.shoppingNumberl;
    
}

-(void)openAudio:(BOOL)on{
    
    [[NSUserDefaults standardUserDefaults] setBool:!on forKey:AudioStatusCloseKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


-(void)myInformationData:(NSDictionary *)data{

    
//    {
//        "id": "15818865756"
//        "phoneMsisdn": "15818865756"
//        "phoneImei": null
//        "name": null
//        "nickname": null
//        "gender": "男"
//        "countryName": null
//        "cityName": "广州"
//        "photoUrl": null
//        "smallPhotoUrl": "http://192.168.6.97:8080/image/4.png"
//        "passwordCredential": null
//        "disable": false
//    }
    NSDictionary *dic = @{@"phoneMsisdn":data[@"phoneMsisdn"],@"gender":data[@"gender"],@"cityName":data[@"cityName"],@"smallPhotoUrl":data[@"smallPhotoUrl"]};
    
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"myInformation"];

    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


-(NSDictionary *)getMyInfromationData{

    return [[NSUserDefaults standardUserDefaults]objectForKey:@"myInformation"];
}


-(BOOL)isAudioOpen{
    
    return ![[NSUserDefaults standardUserDefaults] boolForKey:AudioStatusCloseKey];
    
}


-(void)loginOut{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:UserNameKey];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:PasswordKey];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:AccessTokenKey];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:CustomIdKey];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IsLoginKey];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"myInformation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)customId:(NSString *)customId saveLogin:(NSString*)userName password:(NSString*)password accessToken:(NSString*)accessToken{
    
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:UserNameKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:customId forKey:CustomIdKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:PasswordKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:AccessTokenKey];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsLoginKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

-(BOOL)isLogin{
    
    
    NSString *customId = [[NSUserDefaults standardUserDefaults] objectForKey:CustomIdKey];
    
    if (SafeEmpty(customId)) {
        return NO;
    }else{
        
        return YES;
    }
    
    
}

-(BOOL)isNeedLocationUpdate{
    
    NSDate *lastUpdate = self.lastLocationDate;
    
    
    double passTime = [[NSDate date] timeIntervalSinceNow] - [lastUpdate timeIntervalSinceNow];
    
    if (passTime> 60*5*passTime ) {
        return YES;
    }
    return NO;
    
    
    
}


//通知暂时注释
//推送开关
-(void)setUMPush:(id)data{

    [[NSUserDefaults standardUserDefaults]setValue:data forKey:@"UMPush"];

}
//推送开关
-(BOOL)getUMPush{
    
    NSUserDefaults *asd = [[NSUserDefaults standardUserDefaults]objectForKey:@"UMPush"];
    NSString *string  = [NSString stringWithFormat:@"%@",asd];
    if ([string isEqualToString:@"YES"]) {
        
        return YES;
        
    }
    
        return NO;
    
}



@end
