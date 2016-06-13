//
//  CouponUsageDetail.h
//  coupon
//
//  Created by chijr on 16/4/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponUsageDetailViewCtrl : UITableViewController

@property(nonatomic,strong)NSDictionary *data;

@property(nonatomic,strong)NSString *couponInstanceId;

@property(nonatomic,assign)BOOL boolConsumptionData;

@end
