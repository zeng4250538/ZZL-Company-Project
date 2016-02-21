//
//  GUIConfig.m
//  coupon
//
//  Created by chijr on 15/12/19.
//  Copyright (c) 2015年 chijr. All rights reserved.
//

#import "GUIConfig.h"

@implementation GUIConfig

+(UIColor*)mainColor{
    
    
    //return UIColorFromRGB(235,104,119);
 
    return UIColorFromRGB(233,44,94);
    //http://www.chinacloud.cn/show.aspx?id=22800&cid=16
    
   // return [UIColor orangeColor];
}


+(UIColor*)greenBackgroundColor{
    
 return UIColorFromRGB(40, 162, 123);
    
    
}



+(UIColor*)mainBackgroundColor{
    
    
    return UIColorFromRGB(238, 238, 238);
    
    
}

+(UIColor*)grayFontColorLight{
    
    return UIColorFromHex(0xcccccc);
    
    
}


+(UIColor*)grayFontColor{
    
    return UIColorFromHex(0x999999);
    
    
}

+(UIColor*)grayFontColorDeep{
    
    return UIColorFromHex(0x555555);
    
    
}
+(UIButton*)iconGood{
    
    
    UIImage *img = [UIImage imageNamed:@"good_icon.png"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:img forState:UIControlStateNormal];
    
    
    return btn;
    
}
+(UIButton*)iconBad{
    
     
    UIImage *img = [UIImage imageNamed:@"bad_icon.png"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:img forState:UIControlStateNormal];
    
    
    return btn;
    

    
}

+(void)tableViewGUIFormat:(UITableView*)tableView  {
    
    
    tableView.separatorColor = [UIColor colorWithWhite:0.92f alpha:1.0f];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    uv.backgroundColor=[UIColor clearColor];
    tableView.tableFooterView = uv;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor= tableView.separatorColor;
    
    [uv addSubview:line];
    
    tableView.backgroundColor = [UIColor whiteColor];
    
    
    [[UITableViewHeaderFooterView appearance] setTintColor:[GUIConfig mainBackgroundColor]];
    
    
    
    
}


+(void)tableViewGUIFormat:(UITableView*)tableView backgroundColor:(UIColor*)color {
    
    
    tableView.separatorColor = [UIColor colorWithWhite:0.92f alpha:1.0f];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    uv.backgroundColor=color;
    tableView.tableFooterView = uv;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor= tableView.separatorColor;
    
    [uv addSubview:line];
    
    tableView.backgroundColor = color;
    
    tableView.backgroundView = [[UIView alloc] initWithFrame:tableView.frame];
    //tableView.backgroundView = nil;
    
    tableView.backgroundView.backgroundColor = color;
    
    
    
    
    //[[UITableViewHeaderFooterView appearance] setTintColor:[GUIConfig mainBackgroundColor]];
    
    
    
    
}


+(UIView*)line{
    
    UIView *line = [UIView new];
    line.backgroundColor=[GUIConfig mainBackgroundColor];
    return line;
    
    
    
}

+(CGFloat)tabBarHeight{
    
    return 48.0f;
}
+(CGFloat)navBarHeight{
    
    return 64.0f;
    
}






@end
