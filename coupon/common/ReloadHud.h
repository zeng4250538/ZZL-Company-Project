//
//  ReloadHud.h
//  coupon
//
//  Created by chijr on 16/3/10.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadBlock)();


@interface ReloadHud : UIView

@property(nonatomic,copy)ReloadBlock reloadBlock;



+ (instancetype)showHUDAddedTo:(UIView *)view reloadBlock:(ReloadBlock)reloadBlock;


+ (void)removeHud:(UIView *)view animated:(BOOL)animated;
+ (void)showReloadMode:(UIView*)view;


@end
