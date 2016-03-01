//
//  ShopCouponTableViewCell.h
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum : NSUInteger {
    CouponTypeNormal=0,  //普通
    CouponTypeLimited,   //限时购买
    CouponTypeUnLimited,  //处于限时购买状态
    CouponTypeToPay,    
    CouponTypeToUse,
    CouponTypeToComment,
    CouponTypeToUnPay
    
 } CouponActionType;

//typedef NS_ENUM(NSUInteger, MyEnum) {
//    <#MyEnumValueA#>,
//    <#MyEnumValueB#>,
//    <#MyEnumValueC#>,
//};


typedef void(^PayBlock)(NSDictionary *data);

@interface CouponInfoTableViewCell : UITableViewCell


@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,assign)CouponActionType couponActionType;
@property(nonatomic,copy)PayBlock doActionBlock;
@property(nonatomic,strong)UILabel *couponStatusLabel;    //优惠券

@property(nonatomic,strong)UILabel *couponDrawBackStatusLabel;    //退款的显示流程



-(void)updateData;
-(void)updateData:(NSDictionary*)data;



+(UIView*)headerView:(NSString*)title clickBlock:(void(^)())touchBlock;


+(CGFloat)height;


@end
