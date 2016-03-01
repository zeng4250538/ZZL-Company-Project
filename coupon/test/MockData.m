//
//  MockData.m
//  coupon
//
//  Created by chijr on 16/2/6.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "MockData.h"
#import "YYCategories.h"



@implementation MockData


+ (instancetype)instance {
    static MockData *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}


-(NSString*)randomShopName{
    
    return [@[@"咖啡懂你",@"麦当劳",@"九毛九",
              @"绿茵阁",@"星巴克",@"周大福",@"品良",
              @"面包新语",@"必胜客",@"水果捞",@"赛百味",@"贡茶"
              ] randomObject];
    
    
    
    
}

-(NSString*)randomShopIcon{
    
    
    return  [Utils getRandomImage:@"商家新图"];
    
    
}

-(NSString*)randShopImage{
    
    return [Utils getRandomImage:@"商家封面"];
    
    
}

-(NSString*)randomAddress{
    
    
    return [@[@"正佳三楼109",
              @"天河城一楼西门",
              @"摩登百货二楼",
              @"万达四楼505"
              ] randomObject];

    
    
    
}



-(NSString*)randomShopPrompt{
    
    
    return [@[@"第一次使用送10元，满100元88折扣，满200元77折",
              @"满100元赠送20元代金券",
              @"满50元送5元，满100送10块",
              @"第2份套餐5折"
              ] randomObject];

    
    
}

-(NSString*)randomPhone{
    
    
    return [@[@"13808860210",
              @"020-83456789",
              @"020-87657600",
              @"第2份套餐5折"
              ] randomObject];
    
    
    
}


-(NSDictionary*)shopModel{
    
    return @{
             @"id":@([NSDate timeIntervalSinceReferenceDate]*1000),
             @"name":[self randomShopName],
             @"icon":[self randomShopIcon],
             @"headimage":[self randShopImage],
             @"goodcount":@(arc4random()%100),
             @"badcount":@(arc4random()%50),
             @"prompt":[self randomShopPrompt],
             @"address":[self randomAddress],
             @"phone":[self randomPhone]
             
             };
    
    
    
}

-(NSDictionary*)couponModelOrder:(NSInteger)order{
    
    
  //  NSString *imgrul = [Utils getRandomImage:@"商家新图"];
    
    NSString *imgurl = [Utils getOrderImage:@"商家新图" order:order];
    
    NSArray *priceArray=@[@"10.0",@"15.0",@"8.0",@"25.0",@"12.0",@"5.0",@"5.0",@"9.9",@"100",@"88"];
    
    
    
    NSArray *nameArray=@[@"代金券50",@"代金券8折",@"优惠券8.8折",@"满100送20",@"满200送50",
                         @"代金券买3送1",@"代金券",@"7折券",@"代金券6折",@"代金券6.6折"];
    
    
    
    
    NSString *name =nameArray [arc4random()%[nameArray count]];
    
    
    
    return @{@"icon":imgurl,
             @"name":name,
             @"shopName":[self randomShopName],
             @"price": priceArray[order%[priceArray count]],
             @"marketPrice": priceArray[order% [priceArray count]],
             @"prompt":[self randomShopPrompt],
             @"shop":[self shopModel]
             };
    
    
    
    
    
    
    
    
    
}



-(NSDictionary*)couponModel{
    
    
    NSString *imgrul = [Utils getRandomImage:@"商家新图"];
    
    NSArray *priceArray=@[@"10.0",@"15.0",@"8.0",@"25.0",@"12.0",@"5.0",@"5.0",@"9.9",@"100",@"88"];
    
    
    
    NSArray *nameArray=@[@"代金券50",@"代金券8折",@"优惠券8.8折",@"满100送20",@"满200送50",
                         @"代金券买3送1",@"代金券",@"7折券",@"代金券6折",@"代金券6.6折"];
    
    
    
    
    NSString *name =nameArray [arc4random()%[nameArray count]];
    
    
    
    return @{@"icon":imgrul,
             @"name":name,
             @"shopName":[self randomShopName],
             @"price": priceArray[arc4random()% [priceArray count]],
             @"marketPrice": priceArray[arc4random()% [priceArray count]],
             @"prompt":[self randomShopPrompt],
             @"shop":[self shopModel]
             };
    
    
    
    
    
    
    
    
    
}



-(NSArray*)randomShopModel:(NSUInteger)count{
    
    
    if (count<1) {
        return nil;
    }
    
    
    
    
    NSMutableSet *set  = [NSMutableSet setWithCapacity:100];
    
    NSMutableArray *data =[NSMutableArray arrayWithCapacity:count];
    
    for (int i=0; i<100; i++) {
        
        NSDictionary *d = [self shopModel];
        
        if (![set containsObject:d[@"icon"]]){
            [data addObject:d];
            
            [set addObject:d[@"icon"]];
        }
        
        if ([data count]>=count) {
            return data;
        }
        
        
    }
    
    
    return data;
    
    
}

-(NSArray*)randomCouponModel:(NSUInteger)count{
    
    
    
    if (count<1) {
        return nil;
    }
    
    
    
    
    NSMutableSet *set  = [NSMutableSet setWithCapacity:100];
    
    NSMutableArray *data =[NSMutableArray arrayWithCapacity:count];
    
    for (int i=0; i<100; i++) {
        
        NSDictionary *d = [self couponModel];
        
        if (![set containsObject:d[@"icon"]]){
            [data addObject:d];
            
            [set addObject:d[@"icon"]];
        }
        
        if ([data count]>=count) {
            return data;
        }
        
        
    }
    
    
    return data;
    
    
    
  
    
    
    
    
}

-(NSArray*)orderCouponModel:(NSUInteger)count{
    
    
    if (count<=1) {
        return nil;
    }
    
    
    
    
    
    NSMutableArray *data =[NSMutableArray arrayWithCapacity:count];
    
    for (int i=0; i<count; i++) {
        [data addObject:[self couponModelOrder:i]];
    }
    
    
    return data;
    
    
    
    
    
    
}



@end
