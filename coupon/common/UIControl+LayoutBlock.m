//
//  UIControl+LayoutBlock.m
//  lingshi
//
//  Created by chijy on 15-8-29.
//  Copyright (c) 2015年 orangelight. All rights reserved.
//

#import "UIControl+LayoutBlock.h"

@implementation UIControl(LayoutBlock)


-(void)layout:(void(^)(UIControl* control))control{
    
    control(self);
    
}

@end
