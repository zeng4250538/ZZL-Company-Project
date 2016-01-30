//
//  SelectMallTableCtrl.h
//  coupon
//
//  Created by chijr on 16/1/13.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectMallBlock_t)(NSDictionary *data);

@interface SelectMallTableCtrl : UITableViewController
@property(nonatomic,copy)SelectMallBlock_t completion;

@end
