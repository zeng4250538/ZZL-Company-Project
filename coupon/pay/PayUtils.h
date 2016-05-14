//
//  PayUtils.h
//  lingshi
//
//  Created by chijr on 15/11/20.
//  Copyright (c) 2015年 orangelight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayUtils : NSObject


//微信支付
+(void)wechatPay:(NSString*)orderId orderSn:(NSString*)orderSn orderName:(NSString*)orderName money:(CGFloat)money;

//淘宝支付
+(void)aliPay:(NSString*)orderId orderSn:(NSString*)orderSn orderName:(NSString*)orderName money:(CGFloat)money;


//调起微信客户端

+(void)callWeChatPay:(NSString*)prepayId sign:(NSString*)sign noncestr:(NSString*)noncestr timeStamp:(UInt32)timeStamp;


@end
