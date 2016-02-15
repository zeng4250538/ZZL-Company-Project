//
//  Utils.m
//  coupon
//
//  Created by chijr on 15/12/19.
//  Copyright (c) 2015年 chijr. All rights reserved.
//

#import "Utils.h"
#import "AppDelegate.h"

@implementation Utils


+(NSString*)getRandomImage:(NSString*)path{
    
    NSArray *ary = [Utils getImagePath:path];
    
    if ([ary count]>0) {
        
        int pos = arc4random()%[ary count] ;
        return ary[pos];
        
    }
    
    return @"";
    
}

+(void)incCoupon{
    
    AppDelegate *app =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    
    NSString *value = app.cartVc.tabBarItem.badgeValue;
    
    if ([value length]==0) {
        value = @"1";
    }else{
        
        NSInteger num = [value integerValue];
        num++;
        
        value = [NSString stringWithFormat:@"%ld",num];
        
    }
    
    
    
    app.cartVc.tabBarItem.badgeValue=value;
    
    
    
    
    
    
    
    
    
}

+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect{
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




+(NSDictionary*)getRandomData{
    
    
    NSString *imgrul = [Utils getRandomImage:@"商家图片"];
   
    NSArray *priceArray=@[@"10.0",@"15.0",@"8.0",@"25.0",@"12.0",@"5.0"];
    
    
    NSString *price = priceArray[arc4random()% [priceArray count]];
    
    NSArray *nameArray=@[@"贡茶代金券20代50",@"海底捞代金券8折",@"周大福优惠券8.8择",@"肯德基代金券满100送20",
                         @"zara代金券买3送1",@"汉拿山代金券，多送一盘",@"喜士多7折"];
    
    
    
    
    
    
    
    NSString *name =nameArray [arc4random()%[nameArray count]];
    
    
    
    return @{@"imgurl":imgrul,
             @"name":name,
             @"price":price
             };
    
    
    
    
    
    
    
}

+(NSArray*)getImagePath:(NSString*)addPath{
    
    
    
    
    
    NSString *path = [NSBundle mainBundle].bundlePath;
    
    path = [path stringByAppendingFormat:@"/%@",addPath];
    
    NSDirectoryEnumerator *enumFile = [[NSFileManager defaultManager] enumeratorAtPath:path];
    
    NSString *fileName=@"";
    
    
    NSMutableArray *fileList = [NSMutableArray arrayWithCapacity:10];
    while (fileName = [enumFile nextObject]) {
        
        
        if ([fileName length]==0) {
            continue;
        }
        
        if (!([fileName hasSuffix:@".png"] || [fileName hasSuffix:@".jpeg"] || [fileName hasSuffix:@".jpg"])  ) {
            continue;
        }
        
        if ([Utils containsString:fileName substring:@"/"]){
            continue;
        }
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",addPath,fileName];
        [fileList addObject:filePath];
        
    }
    
    return fileList;
    
    
}

+(BOOL)containsString:(NSString*)source substring:(NSString*)substring{
    
    if ([source length]==0) {
        return NO;
    }
    
    NSRange rg = [source rangeOfString:substring];
    
    
    if (rg.location == NSNotFound){
        return NO;
        
    }
    return YES;
}

+(void)popTransparentViewCtrl:(UIViewController*)parentViewCtrl childViewCtrl:(UIViewController*)childViewCtrl{
    
    
    
    
    parentViewCtrl.definesPresentationContext = NO; //self is presenting view controller
    
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childViewCtrl];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        
        nav.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }else{
        
        parentViewCtrl.modalPresentationStyle=UIModalPresentationCurrentContext;
        
    }
    
    
    
    
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:NO completion:^{
        
    }];
    
    
    
    

    
    
    
}



@end
