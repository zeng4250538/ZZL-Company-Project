//
//  Utils.m
//  coupon
//
//  Created by chijr on 15/12/19.
//  Copyright (c) 2015年 chijr. All rights reserved.
//

#import "Utils.h"
#import "AppDelegate.h"
#import "SimpleAudioPlayer.h"



@implementation Utils


NSDate *SafeDate(NSString* ymd){
    
    NSString *ymdString =  SafeString(ymd);
    
    if ([ymdString length]<19) {
        return nil;
    }
    
    
    NSDateFormatter *fm = [NSDateFormatter new];
    
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [fm dateFromString:ymdString];
    
    return date;
    

    
    
}

void SafePostMessage(NSString* messageName,id body){
    
    NSNotification *notification = [NSNotification notificationWithName:messageName object:body];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    
}



BOOL SafeEmpty(id content){
    
    if (content==nil) {
        return YES;
    }
    
    if ((NSNull*)content==[NSNull null]) {
        return YES;
    }
    
    if ([content isKindOfClass:[NSArray class]]) {
        if ([content count]==0) {
            return YES;
        }
        
    }
    
    if ([content isKindOfClass:[NSDictionary class]]) {
        if ([content count]==0) {
            return YES;
        }
        
    }
    
    
    if ([content length]==0) {
        return YES;
    }
    

    return NO;
    
    
   
    
    
}



NSString *SafeLeft(NSString *content,NSUInteger length){
    
    NSString *str = SafeString(content);
    
    NSUInteger len = [str length];
    
    if (len<length) {
        return str;
    }else{
        
        return [str substringToIndex:length];
    }
    
    
    
}


NSURL *SafeUrl(id content){
    
    if (content==nil) {
        return nil;
    }
    
    if ((NSNull*)content==[NSNull null]) {
        return nil;
    }

    
    if (![content isKindOfClass:[NSString class]]) {
        
        return nil;
    }
    
    NSString *urlString=@"";
    if ([Utils containsString:content substring:@"%"]) {
        
        urlString = content;
        
    }else{
        
          urlString = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
    }
        
    
    
    
    
 //   http://183.6.190.75:9780/images/demo/%E5%A4%A7%E5%BF%AB%E6%B4%BB.jpg
    
     
    
    
    if (!InLan) {
        
        urlString = [urlString stringByReplacingOccurrencesOfString:@"http://192.168.6.97:8080" withString:@"http://183.6.190.75:9780"];
        
    }
    
    
    
    
    
    return [NSURL URLWithString:urlString];
    
    
    
}


id safeArrayValue(id array,NSInteger pos){
    
    if (pos<[array count]) {
        return  nil;
    }
    
    return array[pos];
    
    
}

NSString *SafeString(id content){
    
    
    if (content==nil) {
        return @"";
    }
    if ((NSNull*)content==[NSNull null]) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@",content];
    
    
}





+(void)playShakeSound{


    if ([AppShareData instance].isAudioOpen) {
        
        [SimpleAudioPlayer playFile:@"shake_sound_male1.mp3"  volume:1.0f loops:0 withCompletionBlock:^(BOOL finished) {
            // NSLog(@"Finished playing %");
            
        }];
        
        
    }
}




+(NSString*)getRandomImage:(NSString*)path{
    
    NSArray *ary = [Utils getImagePath:path];
    
    if ([ary count]>0) {
        
        int pos = arc4random()%[ary count] ;
        return ary[pos];
        
    }
    
    return @"";
    
}

+(NSString*)getOrderImage:(NSString*)path order:(NSInteger)order{
    
    NSArray *ary = [Utils getImagePath:path];
    
    NSInteger  nn = arc4random()%[ary count];
    
    order = order+nn;
    
    NSInteger newOrder = order % [ary count];
    
    if ([ary count]>0 && newOrder<[ary count]) {
        
         ;
        return ary[newOrder];
        
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




+(NSString*)downCountFormat:(NSString*)ymdFormat{

    NSDateFormatter *fm = [NSDateFormatter new];
    
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *nextDate = [fm dateFromString:ymdFormat];
    
    NSTimeInterval totalSecond = [nextDate timeIntervalSinceNow];
    
    
    NSInteger hourValue = totalSecond/3600;
    
    NSInteger minuteValue = (totalSecond - hourValue*3600)/60;
    
    NSInteger secondValue = totalSecond - hourValue*3600-minuteValue*60;
    
    
    NSString *lastValue = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hourValue,(long)minuteValue,(long)secondValue];
    
    return lastValue;

    
    
    
    
    
    
    
    
    
}

+(NSString*)downCountString:(NSString*)value{
    
    
    NSString *timeString = value;
    
    if ([timeString length]!=8) {
        return @"00:00:00";
    }
    
    NSString *hour = [timeString substringWithRange:NSMakeRange(0,2)];
    
    NSString *minute = [timeString substringWithRange:NSMakeRange(3,2)];
    
    NSString *second = [timeString substringWithRange:NSMakeRange(6,2)];
    
    
    NSInteger totalSecond = [hour integerValue]*3600+[minute integerValue]*60+[second integerValue];
    
    if (totalSecond>0) {
        
        totalSecond --;
        
    }else{
        
        return @"00:00:00";
    }
    
    NSInteger hourValue = totalSecond/3600;
    
    NSInteger minuteValue = (totalSecond - hourValue*3600)/60;
    
    NSInteger secondValue = totalSecond - hourValue*3600-minuteValue*60;
    
    
    NSString *lastValue = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hourValue,(long)minuteValue,(long)secondValue];
    
   return  lastValue;
    
    
    
    
    
    
    
    
    
}



+(void)downCountLabel:(UILabel*)label{
    
    
    NSString *timeString = label.text;
    
    if ([timeString length]<8) {
        return ;
    }
    
    NSArray *ay = [timeString componentsSeparatedByString:@":"];
    
    NSString *hour = ay[0];
    
    NSString *minute = ay[1];
    
    NSString *second =ay[2];
    
    
    NSInteger totalSecond = [hour integerValue]*3600+[minute integerValue]*60+[second integerValue];
    
    if (totalSecond>0) {
        
        totalSecond --;
        
    }else{
        
        return ;
    }
    
    NSInteger hourValue = totalSecond/3600;
    
    NSInteger minuteValue = (totalSecond - hourValue*3600)/60;
    
    NSInteger secondValue = totalSecond - hourValue*3600-minuteValue*60;
    
    
    NSString *lastValue = [NSString stringWithFormat:@"%ld:%02ld:%02ld",(long)hourValue,(long)minuteValue,(long)secondValue];
    
    label.text = lastValue;
    
    
    
    
    
    
    
    
    
}

+(NSString*)firstLetter:(NSString*)szString{
    
    NSString *pyName = [Utils chineseToPy:szString];
    
    if ([pyName length]>0) {
        NSString *let = [pyName substringToIndex:1];
        
        let = [let uppercaseString];
        return let;
        
    }else{
        
        return @"";
        
    }
    
    
    
}


+(NSString*)chineseToPy:(NSString*)szString{
    if ([szString length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:szString];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        }
        return ms;
    }
    return @"";
}


+(void)postMessage:(NSString*)messageName body:(NSObject*)body{
    
    NSNotification *notification = [NSNotification notificationWithName:messageName object:body];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    
}







@end
