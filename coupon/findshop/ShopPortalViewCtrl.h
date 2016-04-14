//
//  PortalShopViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myBlock)(NSString *data);

typedef void (^cityBlock)(NSString *city);

@interface ShopPortalViewCtrl : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

-(void)doLoad:(void(^)(BOOL ret))completion;

@property(nonatomic,copy)myBlock block;

@property(nonatomic,copy)cityBlock cityBlock;//传城市

@property(nonatomic,strong)NSString *findShopId;

@property(nonatomic,strong)NSString *city;

@end
