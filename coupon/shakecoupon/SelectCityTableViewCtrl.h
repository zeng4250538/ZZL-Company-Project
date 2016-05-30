//
//  SelectCityTableViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/12.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectBlock)(NSString *cityName);

@interface SelectCityTableViewCtrl : UITableViewController

@property(nonatomic,strong)NSArray *sectionList;
@property(nonatomic,copy)SelectBlock selectBlock;



@end
