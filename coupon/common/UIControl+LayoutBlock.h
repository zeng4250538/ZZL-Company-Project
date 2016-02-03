//
//  UIControl+LayoutBlock.h
//  lingshi
//
//  Created by chijy on 15-8-29.
//  Copyright (c) 2015年 orangelight. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIControl (LayoutBlock)

-(void)layout:(void(^)(UIControl* control))control;
@end
