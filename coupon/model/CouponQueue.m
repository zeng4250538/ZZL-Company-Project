//
//  CouponQueue.m
//  coupon
//
//  Created by chijr on 16/3/17.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "CouponQueue.h"



@interface CouponQueue()

@property(nonatomic,strong)NSMutableArray *queue;
@property(nonatomic,assign)NSInteger pos;

@end


@implementation CouponQueue




-(NSDictionary*)next{
    
    
    if (self.queue==nil) {
        return nil;
    }
    
    if ([self.queue count]<1) {
        
        return nil;
    }
    
    NSDictionary *data= self.queue[0];
    
    [self.queue removeObjectAtIndex:0];
    
    return data;
    
    
    
    
    
}

-(BOOL)isEmpty{
    
    
    if ([self.queue count]>0) {
        return NO;
    }
    
    return YES;
    
    
}

-(void)resetData:(NSArray*)data{
    
    
    self.queue = [data mutableCopy];
    
    
}


@end
