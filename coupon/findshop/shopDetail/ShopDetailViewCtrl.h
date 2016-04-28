//
//  ShopDetailViewCtrl.h
//  coupon
//
//  Created by chijr on 16/4/28.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailViewCtrl : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSString *shopId;
@property(nonatomic,strong)UITableView *tableView;



@end
