//
//  SearchResultViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/29.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewCtrl : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>

@property(nonatomic,strong)NSString *keyWord;


@end
