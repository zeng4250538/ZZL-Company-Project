//
//  EditViewCtrl.h
//  coupon
//
//  Created by chijr on 16/5/10.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EditFieldType) {
    EditFieldTypeName,
    EditFieldTypeCity,
    EditFieldTypeSex
,
};

@interface EditViewCtrl : UIViewController

@property(nonatomic,copy)NSString *value;
@property(nonatomic,assign)EditFieldType editFieldType;

@end
