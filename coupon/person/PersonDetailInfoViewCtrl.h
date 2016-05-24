//
//  PersonDetailInfoViewCtrl.h
//  coupon
//
//  Created by chijr on 16/5/10.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myInforMationRefreshBlock)(id data);

@interface PersonDetailInfoViewCtrl : UITableViewController

@property(nonatomic,copy)myInforMationRefreshBlock inforMationRefreshBlock;


@end
