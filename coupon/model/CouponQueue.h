//
//  CouponQueue.h
//  coupon
//
//  Created by chijr on 16/3/17.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponQueue : NSObject


-(NSDictionary*)next;

-(BOOL)isEmpty;

-(void)resetData:(NSArray*)data;



@end
