//
//  ShopCommentViewCtrl.h
//  coupon
//
//  Created by chijr on 16/2/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCommentViewCtrl : UIViewController<UITableViewDataSource,UITabBarDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString *shopId;

@end
