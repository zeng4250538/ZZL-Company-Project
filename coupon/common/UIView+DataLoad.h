//
//  UIView+DataLoad.h
//  coupon
//
//  Created by chijr on 16/3/20.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UIViewDataLoadDelegate<NSObject>

@optional

-(void)doLoad:(void(^)(BOOL ret))completion;

@end




@interface UIView (DataLoad)<UIViewDataLoadDelegate>



-(void)loadData;

-(void)doLoad:(void(^)(BOOL ret))completion;



@end
