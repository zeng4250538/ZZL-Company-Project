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

typedef NS_ENUM(NSUInteger, ShopViewMode) {
    ShopViewModeLocal=0,
    ShopViewModeNetwork=1
};


@interface ShopInfoViewCtrl : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)Shop *shopData;
@property(nonatomic,strong)NSString *shopId;  //需要二次装载数据，使用shopId



@property(nonatomic,strong)OptimizingBrandModel *OptimizingBrand;
@property(nonatomic,assign)ShopViewMode shopMode;



@property(nonatomic,strong)NSDictionary *data;

-(void)boll:(BOOL)bools;

@end
