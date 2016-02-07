//
//  PortalShopTableViewCell.h
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopInfoTableViewCell : UITableViewCell


@property(nonatomic,strong)NSDictionary *data;
+(UIView*)headerView:(NSString*)title clickBlock:(void(^)())clickBlock;

+(CGFloat)height;

-(void)updateData;



@end
