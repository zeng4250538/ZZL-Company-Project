//
//  PortalShopTableViewCell.h
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"



typedef void(^UnFavBlock)();


@interface FavShopCell : UITableViewCell

@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,copy)UnFavBlock unFavBlock;




+(UIView*)headerView:(NSString*)title clickBlock:(void(^)())clickBlock;

//+(UIView*)headerViewWithSort:(NSString*)title clickBlock:(void(^)())clickBlock;

+(CGFloat)height;

-(void)updateData;


@end
