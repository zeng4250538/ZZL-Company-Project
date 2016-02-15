//
//  GoodsNumView.h
//  lingshi
//
//  Created by chijy on 15-11-8.
//  Copyright (c) 2015年 orangelight. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GoodsNumSpanViewBlock)(NSInteger value);

@interface GoodsNumSpanView : UIView

@property(nonatomic,assign)NSInteger num;
@property(nonatomic,copy)GoodsNumSpanViewBlock block;
@property(nonatomic,assign)NSInteger limitNum;
@property(nonatomic,strong) UILabel *textLabel;






@end
