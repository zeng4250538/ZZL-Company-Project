//
//  PersonInfoViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/12.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myInformationBlock)();
@interface PersonInfoViewCtrl : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)myInformationBlock informationBlock;
@property(nonatomic,strong)UITableView *tableView;

@end
