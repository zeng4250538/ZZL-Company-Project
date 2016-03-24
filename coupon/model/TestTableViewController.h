//
//  TestTableViewController.h
//  coupon
//
//  Created by chijr on 16/3/23.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end
