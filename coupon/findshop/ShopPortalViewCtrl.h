//
//  PortalShopViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myBlock)(NSString *data);

@interface ShopPortalViewCtrl : UITableViewController<UISearchBarDelegate>

-(void)doLoad:(void(^)(BOOL ret))completion;

@property(nonatomic,copy)myBlock block;

//-(void)bolciView:(myBlock) blockView;

//-(void)myblockViewSuccesst:(void (^)(id data))successt;

-(void)lodeDataView;

@end
