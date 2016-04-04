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

NSString * const AudioStatusCloseKey=@"audiostatusclose";

NSString * const IsLoginKey=@"islogin";

NSString * const CustomIdKey=@"customId";



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


-(NSString*)accessToken{
    
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:AccessTokenKey];
    
    
}

-(NSString*)customId{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:CustomIdKey];
    
}

-(NSMutableArray*)getCartList{
    
    
    return self.cartList;
    
    
    
    
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



-(BOOL)isAudioOpen{
    
    return ![[NSUserDefaults standardUserDefaults] boolForKey:AudioStatusCloseKey];
    
}


-(void)loginOut{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:UserNameKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:PasswordKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:AccessTokenKey];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IsLoginKey];
    
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
