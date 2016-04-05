//
//  PortalShopViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

//<<<<<<< HEAD
typedef void (^myBlock)(NSString *data);

//@interface ShopPortalViewCtrl : UITableViewController<UISearchBarDelegate>
//=======
@interface ShopPortalViewCtrl : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
//>>>>>>> 33fe839e0654da87eda8e68b79b7d17fea1112af

-(void)doLoad:(void(^)(BOOL ret))completion;

@property(nonatomic,copy)myBlock block;

//-(void)bolciView:(myBlock) blockView;

//-(void)myblockViewSuccesst:(void (^)(id data))successt;

-(void)lodeDataView;

@end
