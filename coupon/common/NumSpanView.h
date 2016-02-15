//
//  GoodsNumView.h
//  lingshi
//
//  Created by chijy on 15-11-8.
//  Copyright (c) 2015年 orangelight. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NumSpanViewBlock)(NSInteger value);

@interface NumSpanView : UIView

@property(nonatomic,assign)NSInteger num;
@property(nonatomic,copy)NumSpanViewBlock block;
@property(nonatomic,assign)NSInteger limitNum;






@end
