//
//  GUIHelper.h
//  couponbusiness
//
//  Created by chijr on 16/2/21.
//  Copyright (c) 2016年 richstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GUIHelper : NSObject


+(UITextField*)makeTableCellTextField:(NSString*)title cell:(UITableViewCell*)cell;



+(UILabel*)makeTableCellLabel:(NSString*)title cell:(UITableViewCell*)cell;


+(UITableView*)makeTableView:(UIView*)view delegate:(id)delegate;


+(UITableView*)zzl_makeTableView:(UIView *)view dalegate:(id)delegate;







@end
