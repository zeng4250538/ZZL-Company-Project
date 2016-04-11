//
//  ShopListViewCtrl.h
//  coupon
//
//  Created by chijr on 16/2/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, QueryType) {
    QueryTypeRecommend=0,  //优选品牌
    QueryTypeBrand         //品牌街
    
};
@interface ShopListViewCtrl : UITableViewController

@property(nonatomic,assign)QueryType queryType;
@end
