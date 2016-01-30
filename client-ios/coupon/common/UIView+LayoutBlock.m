//
//  UIView+LayoutBlock.m
//  lingshi
//
//  Created by chijy on 15-8-29.
//  Copyright (c) 2015年 orangelight. All rights reserved.
//

#import "UIView+LayoutBlock.h"


@implementation UIView(LayoutBlock)


-(void)layout:(void(^)(UIView* view))view{

    view(self);
    
}


@end
