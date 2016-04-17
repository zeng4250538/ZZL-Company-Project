//
//  MySubViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/13.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySubViewCtrl : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end
