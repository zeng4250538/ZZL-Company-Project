//
//  PayUtils.h
//  lingshi
//
//  Created by chijr on 15/11/20.
//  Copyright (c) 2015年 orangelight. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *WechatPay_API_KEY ;  //注意保密
extern NSString *WechatPay_APP_ID ;
extern NSString *WechatPay_MCH_ID ;


@interface PayUtils : NSObject


//微信支付2

+ (void)sendWechatPay:(NSString*)orderName price:(NSString*)price;

+(NSDictionary*)weChatSign:(NSString*)prePayId;








//微信支付
+(void)wechatPay:(NSString*)orderId orderSn:(NSString*)orderSn orderName:(NSString*)orderName money:(CGFloat)money;

//淘宝支付
//+(void)aliPay:(NSString*)orderId orderSn:(NSString*)orderSn orderName:(NSString*)orderName money:(CGFloat)money;


+(void)aliPay:(NSString*)orderId orderSn:orderSn orderName:(NSString*)orderName money:(CGFloat)money sign:(NSString*)sign;




//调起微信客户端

+(void)callWeChatPay:(NSString*)prepayId sign:(NSString*)sign noncestr:(NSString*)noncestr timeStamp:(UInt32)timeStamp;

//淘宝支付服务器版本

+(void)aliPayServer:(NSString*)orderString  sign:(NSString*)sign;


@end
