//
//  HistoryCouponCell.h
//  coupon
//
//  Created by chijr on 16/4/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CommentTouchBlock)(NSDictionary *data);

@interface HistoryCouponCell : UITableViewCell

@property(nonatomic,strong)NSDictionary *data;


@property(nonatomic,copy)CommentTouchBlock commentTouchBlock;

@end
