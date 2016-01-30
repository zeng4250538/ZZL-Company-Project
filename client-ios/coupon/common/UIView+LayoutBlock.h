//
//  UIView+LayoutBlock.h
//  lingshi
//
//  Created by chijy on 15-8-29.
//  Copyright (c) 2015年 orangelight. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView (LayoutBlock)

-(void)layout:(void(^)(UIView* view))view;

@end

