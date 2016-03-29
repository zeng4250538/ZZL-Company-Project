//
//  ShopDetailViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "OptimizingBrandModel.h"
//#import ""

@interface ShopInfoViewCtrl : UITableViewController

@property(nonatomic,strong)Shop *shopData;

@property(nonatomic,strong)OptimizingBrandModel *OptimizingBrand;


@property(nonatomic,strong)NSDictionary *data;

-(void)boll:(BOOL)bools;

@end
