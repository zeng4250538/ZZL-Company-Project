//
//  CouponView.h
//  coupon
//
//  Created by chijr on 16/1/14.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponView : UIView

@property(nonatomic,strong)NSDictionary *data;


-(instancetype)initWithFrame:(CGRect)frame data:(NSDictionary*)data;


@end
