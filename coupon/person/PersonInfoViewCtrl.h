//
//  PersonInfoViewCtrl.h
//  coupon
//
//  Created by chijr on 16/1/12.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myInformationBlock)();
typedef void (^refreshBlock)();
@interface PersonInfoViewCtrl : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)myInformationBlock informationBlock;

@property(nonatomic,copy)refreshBlock refreshBlock;

@property(nonatomic,assign)BOOL bollJump;

@property(nonatomic,strong)UITableView *tableView;

@end
