//
//  GUIHelper.m
//  couponbusiness
//
//  Created by chijr on 16/2/21.
//  Copyright (c) 2016年 richstone. All rights reserved.
//

#import "GUIHelper.h"

@implementation GUIHelper


+(UITextField*)makeTableCellTextField:(NSString*)title cell:(UITableViewCell*)cell{
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = title;
    nameLabel.textColor =[UIColor blackColor];
    
    [nameLabel sizeToFit];
    nameLabel.font = [UIFont systemFontOfSize:14];
    CGRect r = nameLabel.frame;
    r.size.width = 100;
    nameLabel.frame = r;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    
    
    
    
    
    UITextField *valueTexttField = [UITextField new];
    valueTexttField.leftViewMode = UITextFieldViewModeAlways;
    valueTexttField.leftView = nameLabel;
    
    valueTexttField.textColor = [UIColor blackColor];
    
    
    
   // valueTexttField.textColor = [UIColor lightGrayColor];
    valueTexttField.font = [UIFont systemFontOfSize:14];
    
    
    [cell.contentView addSubview:valueTexttField];
    
    
    [valueTexttField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(15);
        make.top.bottom.right.equalTo(cell.contentView);
    }];
    
    return valueTexttField;
    
    
    
    
    
    
}



+(UILabel*)makeTableCellLabel:(NSString*)title cell:(UITableViewCell*)cell{
    
    
    return nil;
    
    
    
    
}







@end
