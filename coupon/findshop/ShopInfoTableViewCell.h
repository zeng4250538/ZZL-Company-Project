//
//  PortalShopTableViewCell.h
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"


typedef NS_ENUM(NSUInteger, SubscribeType) {
    SubscribeTypeNone=0,
    SubscribeTypeHave,

};

@interface ShopInfoTableViewCell : UITableViewCell

@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,assign)SubscribeType subscribeType;
@property(nonatomic, strong) Shop *model;


+(UIView*)headerView:(NSString*)title clickBlock:(void(^)())clickBlock;

//+(UIView*)headerViewWithSort:(NSString*)title clickBlock:(void(^)())clickBlock;

+(CGFloat)height;

-(void)updateData;



@end
