//
//  AppShareData.m
//  coupon
//
//  Created by chijr on 16/1/18.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "AppShareData.h"


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

@end


@implementation AppShareData


static AppShareData *instance;




+(instancetype)instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance =[[AppShareData alloc] init];
        
        instance.cartList = [@[] mutableCopy];
        
        instance.shakeCouponQueue =[CouponQueue new];
        
    });
    
    return instance;
    
    
}


-(void)setCity:(NSString *)city{
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:CityKey];
    
    
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

-(NSString*)accessToken{
    
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:AccessTokenKey];
    
    
}


-(void)saveMallId:(NSString*)mallId{
    
    
    [[NSUserDefaults standardUserDefaults] objectForKey:mallId];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
}


-(NSString*)mallId{
    
    return @"11";
}


-(NSString*)customId{
    

    return @"15818865756";
    
   // return [[NSUserDefaults standardUserDefaults] objectForKey:CustomIdKey];
    
}

-(NSMutableArray*)getCartList{
    
    
    return self.cartList;
    
    
    
    
}


//我改的。。。可删（未使用）
-(void)shoppingCartNumber:(id)data{

    NSNumber *number = data;
    
    

}

-(NSUInteger)getCartCount{
    
    return [instance.cartList count];
}

-(NSUInteger)addCouponToCart:(NSDictionary*)data{
    
    if (data==nil) {
        return 0;
    }
    
    [instance.cartList addObject:[data mutableCopy]];
    
    return [instance.cartList count];
    
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
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IsLoginKey];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"myInformation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)saveLogin:(NSString*)userName password:(NSString*)password accessToken:(NSString*)accessToken{
    
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:UserNameKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:CustomIdKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:PasswordKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:AccessTokenKey];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsLoginKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

-(BOOL)isLogin{
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:IsLoginKey];
    
}





@end
