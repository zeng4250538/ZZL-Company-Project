//
//  Shop.h
//  coupon
//
//  Created by chijr on 16/3/19.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject

@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *mallid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,assign)NSUInteger good;
@property(nonatomic,assign)NSUInteger bad;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,assign)CGFloat longitude;
@property(nonatomic,assign)CGFloat latitude;
@property(nonatomic,assign)CGFloat distance;
@property(nonatomic,copy)NSString * smallPhotoUrl;
//@property(nonatomic,copy)NSString *smallPhotoUrl;

@property(nonatomic,assign)NSInteger subscribeNum;


@end
