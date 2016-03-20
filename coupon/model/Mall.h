//
//  Mall.h
//  coupon
//
//  Created by chijr on 16/3/19.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mall : NSObject

@property(nonatomic,copy)NSString *mallid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,assign)CGFloat distance;



@end
