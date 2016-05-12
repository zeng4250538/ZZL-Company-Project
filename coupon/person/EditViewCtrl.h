//
//  EditViewCtrl.h
//  coupon
//
//  Created by chijr on 16/5/10.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomerService.h"


typedef void(^CustomUpdateBlock)(CustomerFieldType fieldType,NSString *value);
@interface EditViewCtrl : UIViewController

@property(nonatomic,strong)NSString *value;
@property(nonatomic,assign)CustomerFieldType editFieldType;
@property(nonatomic,copy)CustomUpdateBlock updateBlock;


@end
