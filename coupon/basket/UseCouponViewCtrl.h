//
//  UseCouponViewCtrl.h
//  coupon
//
//  Created by chijr on 16/4/3.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  使用优惠券去支付页面
 */

typedef NS_ENUM(NSUInteger, PayMode) {
    PayModeWeChat, //微信支付
    PayModeAliPay   //淘宝支付
};

@interface UseCouponViewCtrl : UITableViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,assign)PayMode payMode;

@end
