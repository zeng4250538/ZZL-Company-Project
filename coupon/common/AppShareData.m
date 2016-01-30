//
//  AppShareData.m
//  coupon
//
//  Created by chijr on 16/1/18.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "AppShareData.h"

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
        
        
    });
    
    return instance;
    
    
}

-(NSArray*)getCartList{
    
    
    return self.cartList;
    
    
    
    
}

-(NSUInteger)getCartCount{
    
    return [instance.cartList count];
}

-(NSUInteger)addCouponToCart:(NSDictionary*)data{
    
    [instance.cartList addObject:data];
    
    return [instance.cartList count];
    
}



@end
