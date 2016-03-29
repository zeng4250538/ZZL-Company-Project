//
//  SelectCityPopViewCtrl.h
//  coupon
//
//  Created by chijr on 16/2/1.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectMallBlock)(BOOL ret,NSDictionary *data);

@interface SelectMallPopViewCtrl : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSString *cityString;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *mallList;
@property(nonatomic,copy)SelectMallBlock selectMallBlock;

@end
