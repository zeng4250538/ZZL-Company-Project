//
//  PortalShopViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myBlock)(NSString *string);

@interface ShopPortalViewCtrl : UITableViewController<UISearchBarDelegate>

-(void)doLoad:(void(^)(BOOL ret))completion;

@property(nonatomic,strong)myBlock block;


@end
