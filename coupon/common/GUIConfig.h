//
//  GUIConfig.h
//  coupon
//
//  Created by chijr on 15/12/19.
//  Copyright (c) 2015年 chijr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GUIConfig : NSObject

+(UIColor*)mainColor;

+(UIColor*)mainBackgroundColor;

+(UIColor*)grayFontColorLight;

+(UIColor*)grayFontColor;
+(UIColor*)grayFontColorDeep;


+(UIButton*)iconGood;
+(UIButton*)iconBad;

+(UIColor*)greenBackgroundColor;





+(void)tableViewGUIFormat:(UITableView*)tableView;

+(void)tableViewGUIFormat:(UITableView*)tableView backgroundColor:(UIColor*)color;


+(UIView*)line;

+(CGFloat)tabBarHeight;
+(CGFloat)navBarHeight;









@end
