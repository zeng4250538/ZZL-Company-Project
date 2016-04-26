//
//  PayUtils.m
//  lingshi
//
//  Created by chijr on 15/11/20.
//  Copyright (c) 2015年 orangelight. All rights reserved.
//

#import "PayUtils.h"
#import "payRequsestHandler.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "APAuthV2Info.h"

#import "WXApi.h"

/**
 *  淘宝支付参数
 */

 NSString *ALiPay_Partner=@"2088801900305895";
 NSString *ALiPay_Seller=@"2088801900305895";
 NSString *ALiPay_Private=@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJ/Dr1+h3bnaiStwth2AYQD/XxYRiK/0KCmKrhCXRufIAqSOztlS1XZepdu1OquGRsRlfYntr1+GpKH1sPYi6K2JMyzSQzNBM/cX8/wJl1Ewk3ERe35iKcW+sSJf0G+HBoWpdDO8ROHorFkKIb/UOs3P/D3o37WSF2ICSo5hW8oNAgMBAAECgYAyWEvvauagJomLMt1wtn/a/J5OKgBU0i/Fx3nKqKEjcRfEG2x7d2rk/jZt4dI3Mv0h7ol86XWWOKuwjefR6HZBmbBA8jmeR60oDBiGXVITM0gqN0KpaV0MgBMTK8QzbxGu0yMDiC/uum6AFf1Sd/G6bVJsu1aueZHIUPqBMBJY0QJBANDPP1Vo8AlfwbgXUogCyE1CNXNuM40+I4s0XMYKb/eQ1OBlIoC9iCFEcnRLKcu1Tlk6irHQDGUcFxpKz2SuWxMCQQDD3ulw0lKsD1DHVfZv35kJDuvLglnOPukw3V66p7ZvBKqHFwRmeYfDX9ZEKBiFhOxPxf0F7l4nE/Y7nI1SacpfAkBkTKinZhim6BAtVUaXfn6oXb0/DRhGKCr6mtRVbH4L9M3MW8gO/vt8v1wa8F/LMfPIeI5WixDpIG0YfAbS3c1xAkEAtGnFYbsIlR1CTWk7pc4xuqs4u2nkaFmAFxdAIvNJ0bZdkDK+RdlZGLdUt9CqzYki1VPLfEQUCzCS1FOdxDRXRwJAXTjH8DYxCwr2/G+6yUvpgsKtALxE8anWl98TJT/l5WzLQlIwQmuN4R2JnBxPaZ6heZmu+98lI4F8t+zGPFxZHw==";




//微信支付参数
NSString *WechatPay_API_KEY = @"fengshiguangzhoutianhehuitong160";  //注意保密
NSString *WechatPay_APP_ID =@"wx77914cc659d2889c";
NSString *WechatPay_MCH_ID =@"1332430001";





@implementation PayUtils


#pragma mark 微信支付




+(void)wechatPay:(NSString*)orderId orderSn:(NSString*)orderSn orderName:(NSString*)orderName money:(CGFloat)money{
    
    
    NSString *priceString = [NSString stringWithFormat:@"%.0f",money*100];
    [self sendWechatPay:orderName price:priceString];
    
    
    
    
}


+ (void)sendWechatPay:(NSString*)orderName price:(NSString*)price
{
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:WechatPay_APP_ID mch_id:WechatPay_MCH_ID];
    //设置密钥
    [req setKey:WechatPay_API_KEY];
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay:orderName price:price];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq * req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}



+(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}



+(void)aliPay:(NSString*)orderId orderSn:orderSn orderName:(NSString*)orderName money:(CGFloat)money{
    
    
    Order *order = [[Order alloc] init];

    
    
    
    order.partner =[ALiPay_Partner copy];
    order.seller = [ALiPay_Seller copy];
    
    
    
    
    
    
//    order.partner = @"2088221016697815";
//    order.seller = @"paytreasuredeveloper@richstonedt.com";
    
    
    
//
    order.tradeNO = orderSn; //订单ID（由商家自行制定）
    order.productName = orderName; //商品标题
    order.productDescription = orderName; //商品描述
    
    order.amount = [NSString stringWithFormat:@"%.2f",money]; //商品价格
    order.notifyURL =  @"http://m.lingshi.com/app/callback/alipay.php"; //回调URL
    
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    
    
    
    NSString *appScheme = @"coupon";
    
    

        

        
        
//            NSString *oderStringSource=@"partner=\"2088021577004853\"&seller_id=\"vab_pm@cmi.chinamobile.com\"&out_trade_no=\"RY2IA4Z78BYYCW1\"&subject=\"1\"&body=\"我是测试数据\"&total_fee=\"0.02\"&notify_url=\"http://www.xxx.com\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&show_url=\"m.alipay.com\"";
//            
        
        id<DataSigner> signer = CreateRSADataSigner([ALiPay_Private copy]);
         NSString *signKey = [signer signString:[order description]];

        
        
        
        
        
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       [order description], signKey, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            
            NSInteger  statusCode = [resultDic[@"resultStatus"] integerValue];
            
            if (statusCode == 9000) {
                //成功发布消息
                
                SafePostMessage(ALiPayNotice, @"1");
                
                
            }else{
                
                //失败发送消息
                SafePostMessage(ALiPayNotice, @"0");
                
                
            }
            
      
        }];

        
        
        
        
        
        
        
    
        
    
    
    
    
    
    
}


#pragma mark - 调用微信支付

//+(void)callWeichatPay:(NSDictionary*)dict{
//    
//    
//    //调起微信支付
//    PayReq* req             = [[PayReq alloc] init];
//    req.openID              = [dict objectForKey:@"appid"];
//    req.partnerId           = [dict objectForKey:@"partnerid"];
//    req.prepayId            = [dict objectForKey:@"prepayid"];
//    req.nonceStr            = [dict objectForKey:@"noncestr"];
//    req.timeStamp           = (UInt32)[[dict objectForKey:@"timestamp"] integerValue];
//    req.package             = [dict objectForKey:@"package"];
//    req.sign                = [dict objectForKey:@"sign"];
//    
//    [WXApi sendReq:req];
//    
//    
//
//    
//    
//    
//    
//}
+(void)aliPay2:(NSString*)orderId orderSn:(NSString*)orderSn orderName:(NSString*)orderName money:(NSUInteger)money{
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    
    
    NSString* partner = @"2088021577004853";
    
    //商户收款账号
    NSString *seller = @"vab_pm@cmi.chinamobile.com";
    //@"overseas_test1@alipay.com";
    //商户私钥，pkcs8格式
    NSString   *privateKey= @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMH/0NJDQdE0DnW+C64mIZA23VM4mpuYfeNS08G1SqS0H4lXi09LQG6kTQOskVMB2qTxDidViZcIJiTZAykhQhleunlY1dOpbilM7vODQGUAjsyzFwXOj+NA/XwyFez8WdH/rMQB+ESLsYHVq8rHfMo48anAT3Tt+4sXj7rz04ElAgMBAAECgYA5a8SdV7b1exkElLnUVAj/LJ4Z8dkhUOOCE5QF8+kiEwZ6mmTrlXR+yzbYbY2eKiBTTd5ImjLdd1YC9hDPbb6oSzuvn8lfB4BubOuXutu/Zmd5Yway1nuiTIgGtCAaHe6EjriLMRZIWEVHnWSMAQFrIFS3ELEx5gOVSQKViEHAAQJBAPRWHuCy0wnxzKBRhvzmmDWvsu/AukEVyqDTHeAEsX+Ac7CJ3TvZ4X5ll1IjWxIdYC5dK5bJ0JwCG7khuxwE2SUCQQDLQo6huKX5DKKaDzOxCZwyv6QkhTnuk3NyZKhUJE/4J9vuM4f4Rm9RbPaleV+CGIsXLBxTYVd4TlQzfNNvt4gBAkEA1LTIarqiqCydBBAVYMLqTQpozvlL6+8pmDpR7ryHPUU48b4DH+B8wsl0I2huFuYF3jb0BHAqsDXRpqhruGesFQJBAJmsh4Pzw+Bo0iLiLXXDS0n/JE3MQEGFT7qEKdP75E49bIVKhpmKPy1z0YLIIhKNFdP+MKhFp0k5B2YqEP2c6AECQQCyOhychGbpStoIfvcOwVqR/nsJTFu4JccIY6BTgC9MgwZdbJSNXOC4G/lWJsSWDePMCpeIG+zd1zzsfm5nIumI";
    //
    NSString *RSA_PUBLIC = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB";

    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderSn; //订单ID（由商家自行制定）
    order.productName = orderName; //商品标题
    order.productDescription = orderName; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",money/100.0]; //商品价格
    order.notifyURL =  @"http://devel.jegotrip.com/app/alipay/fastPayNotify"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
        
    }

    
    
    
    
}


@end
