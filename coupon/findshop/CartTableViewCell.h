//
//  ShopCouponTableViewCell.h
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NumSpanView;



typedef void(^DataUpdateBlock_t)();



@interface CartTableViewCell : UITableViewCell


@property(nonatomic,strong)NSMutableDictionary *data;
@property(nonatomic,strong)NumSpanView *spanButton;
//数据发生改变的响应

@property(nonatomic,strong)DataUpdateBlock_t dataUpdateBlock;





-(void)updateData;




+(CGFloat)height;


@end
