//
//  PortalShopViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myBlock)(NSString *data);


@interface ShopPortalViewCtrl : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

-(void)doLoad:(void(^)(BOOL ret))completion;

-(void)subRefreshView;

@property(nonatomic,copy)myBlock block;



@end
