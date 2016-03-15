//
//  LoginViewCtrl.h
//  coupon
//
//  Created by chijr on 16/3/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginEndBlock)(BOOL isLogin);

@interface LoginViewCtrl : UITableViewController
@property(nonatomic,copy)LoginEndBlock loginEndBlock;

@end
