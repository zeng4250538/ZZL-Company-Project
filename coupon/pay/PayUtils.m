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



@implementation PayUtils


#pragma mark 微信支付

+(void)wechatPay:(NSString*)orderId orderSn:(NSString*)orderSn orderName:(NSString*)orderName money:(CGFloat)money{
    
    
    
    
    
    
    
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

    
    
    
    order.partner = @"2088701080647832";
    order.seller = @"lingshi040404@163.com";
    
    
    
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
    
    

    
    
    
    
        
    
        
        
        
        NSString   *privateKey= @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMH/0NJDQdE0DnW+C64mIZA23VM4mpuYfeNS08G1SqS0H4lXi09LQG6kTQOskVMB2qTxDidViZcIJiTZAykhQhleunlY1dOpbilM7vODQGUAjsyzFwXOj+NA/XwyFez8WdH/rMQB+ESLsYHVq8rHfMo48anAT3Tt+4sXj7rz04ElAgMBAAECgYA5a8SdV7b1exkElLnUVAj/LJ4Z8dkhUOOCE5QF8+kiEwZ6mmTrlXR+yzbYbY2eKiBTTd5ImjLdd1YC9hDPbb6oSzuvn8lfB4BubOuXutu/Zmd5Yway1nuiTIgGtCAaHe6EjriLMRZIWEVHnWSMAQFrIFS3ELEx5gOVSQKViEHAAQJBAPRWHuCy0wnxzKBRhvzmmDWvsu/AukEVyqDTHeAEsX+Ac7CJ3TvZ4X5ll1IjWxIdYC5dK5bJ0JwCG7khuxwE2SUCQQDLQo6huKX5DKKaDzOxCZwyv6QkhTnuk3NyZKhUJE/4J9vuM4f4Rm9RbPaleV+CGIsXLBxTYVd4TlQzfNNvt4gBAkEA1LTIarqiqCydBBAVYMLqTQpozvlL6+8pmDpR7ryHPUU48b4DH+B8wsl0I2huFuYF3jb0BHAqsDXRpqhruGesFQJBAJmsh4Pzw+Bo0iLiLXXDS0n/JE3MQEGFT7qEKdP75E49bIVKhpmKPy1z0YLIIhKNFdP+MKhFp0k5B2YqEP2c6AECQQCyOhychGbpStoIfvcOwVqR/nsJTFu4JccIY6BTgC9MgwZdbJSNXOC4G/lWJsSWDePMCpeIG+zd1zzsfm5nIumI";
        
        
         privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJ/Dr1+h3bnaiStwth2AYQD/XxYRiK/0KCmKrhCXRufIAqSOztlS1XZepdu1OquGRsRlfYntr1+GpKH1sPYi6K2JMyzSQzNBM/cX8/wJl1Ewk3ERe35iKcW+sSJf0G+HBoWpdDO8ROHorFkKIb/UOs3P/D3o37WSF2ICSo5hW8oNAgMBAAECgYAyWEvvauagJomLMt1wtn/a/J5OKgBU0i/Fx3nKqKEjcRfEG2x7d2rk/jZt4dI3Mv0h7ol86XWWOKuwjefR6HZBmbBA8jmeR60oDBiGXVITM0gqN0KpaV0MgBMTK8QzbxGu0yMDiC/uum6AFf1Sd/G6bVJsu1aueZHIUPqBMBJY0QJBANDPP1Vo8AlfwbgXUogCyE1CNXNuM40+I4s0XMYKb/eQ1OBlIoC9iCFEcnRLKcu1Tlk6irHQDGUcFxpKz2SuWxMCQQDD3ulw0lKsD1DHVfZv35kJDuvLglnOPukw3V66p7ZvBKqHFwRmeYfDX9ZEKBiFhOxPxf0F7l4nE/Y7nI1SacpfAkBkTKinZhim6BAtVUaXfn6oXb0/DRhGKCr6mtRVbH4L9M3MW8gO/vt8v1wa8F/LMfPIeI5WixDpIG0YfAbS3c1xAkEAtGnFYbsIlR1CTWk7pc4xuqs4u2nkaFmAFxdAIvNJ0bZdkDK+RdlZGLdUt9CqzYki1VPLfEQUCzCS1FOdxDRXRwJAXTjH8DYxCwr2/G+6yUvpgsKtALxE8anWl98TJT/l5WzLQlIwQmuN4R2JnBxPaZ6heZmu+98lI4F8t+zGPFxZHw==";
        
        
        privateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAO7ANGi6HmaUKhCS"
        "J2NrrhmSs/CU31JzkOhClipw2dsz17aW9DQO9EmiDyix34ktSLxys4YjJ9k0Z+HZ"
        "ER9avqGL7K34R2/8zRoyX7Q2bU9AL7QgljJfl6wrqK0zY8gGRVJl8MX9r/+arVjc"
        "htE4kSEodDEVXewKufPpY4mH8j0fAgMBAAECgYAmIKe9+csVEqBNGSoVJIMfLmBy"
        "ETRA1JfVn5yflnoUGYlfbWf+UE0O3USSeSV7oLG29pJY35BjjYzxclrbqQA8OUb4"
        "3mNNSwOdy6cTAQsim6pzFSepkH0Lbp1yh6TTGNTmQQxxAhJgQzu5foVNXzKcgfn7"
        "UjQRcWzB+dU24dl+QQJBAPlw/YJ30vDp04za3O+NrTkyUNecAjE3iXCV7mZ8FnSv"
        "JcKLOCJlF+5JQaJPQzPFJKVktoU6nKYl5UMXM0JLbvECQQD1B0FguN+SAUsROFzH"
        "CpfuHMa/7us/ra0ieCEN/B/LaReakvNnEq/2dObKURgCvhmncfj39jbY5+vaUf6I"
        "LI0PAkBmSRkLeQs80wV2ywCyEsynmaRg5Y5YlEd9rV2XFOc4beH0Bpa8M+w+QDfz"
        "0MDj58GBOO1HcKNv1jZO7qKMWtZhAkA8KC3a60iodfzSG35bt7QZV6NMGAJVvfQV"
        "1Fx5LH8513FeF9n+Yk4lOgo3fbVhZv6xZ3/ykNZiZn43OY4+LIHtAkB5HlJPXc8o"
        "KygzVTAexTk8rXQMmQ1+qBZLREWPsdopqqCJjxnQT4yq7xb1QS09M+Ht4uzYaAxo"
        "ZfdeabJakfkR";
    
    
//    privateKey=@"MIICXwIBAAKBgQC67zHqzNhXVLDdChWSD2g/jqZFltgkRRSvpE6MiUkkUJQU231g"
//    "1YQzvXrvkpqLO4Iz9siew5CTCsI916Aoapzs5/XKK0khBguqB7ueR4VvC5u+pSGx"
//    "6oXFiIxW5o+nAzC23/BCVot9zo3oR+hCqmqznVq37O/i1CZQYq8iRqns+wIDAQAB"
//    "AoGBAIy3vsXXyguDj1f1XWOEAZ/GjFfaQ36aGgZWE2MrfUm+9pn02B7q3Afu3Po3"
//    "S+r/svXXEhKheNWXxbyz8rY5+0H5phXPL4yzT51YPFEhKFmWnoTzzqv5p1kKQphd"
//    "SN6FrMblYnRsPCLxn01tEvMQoKxwYzZhI04AaVz+wX6d5XMxAkEA4SYenOZFK3Oe"
//    "KJQwMfLceikB6t0c7C1yUAmdwytozUJuD6gzejD5pUkQhFsc78lECR4gFEtBKwOv"
//    "Q4ftlB6PZwJBANSMkThSoLl/ABKJ1vrXRcjwqJo+G2vRdM6Hq52z/YqBtvemRc9Y"
//    "xD+CGaHx1hlYARjh/LXl/NsReivqdHRA/U0CQQC3aWJO1pdKimkxDWcliX5qVbWm"
//    "KnJBQ9R3tx25vEcnzxHx10f4JqV4LEk0STUNcZvnAY+IeLWh4OKJ1NWJcEvJAkEA"
//    "hYTcAOafAofOMtcWDjNHKkhLkcEsFpnYZ5kAbKvRvL1pg76Wof8gIMkIcxvpI7iN"
//    "z+S+jEGyiqc6+PVqPFFLDQJBAMnKCXqySYT2nXEzjvV6CjZMBuH1xxb+IOz0bT76"
//    "COP0JakJ3NV9p5+VpPqK1q9/WccWtYuQkSk9RBQhhNPtCGE=";
    
    
//    MIICXwIBAAKBgQC67zHqzNhXVLDdChWSD2g/jqZFltgkRRSvpE6MiUkkUJQU231g
//    1YQzvXrvkpqLO4Iz9siew5CTCsI916Aoapzs5/XKK0khBguqB7ueR4VvC5u+pSGx
//    6oXFiIxW5o+nAzC23/BCVot9zo3oR+hCqmqznVq37O/i1CZQYq8iRqns+wIDAQAB
//    AoGBAIy3vsXXyguDj1f1XWOEAZ/GjFfaQ36aGgZWE2MrfUm+9pn02B7q3Afu3Po3
//    S+r/svXXEhKheNWXxbyz8rY5+0H5phXPL4yzT51YPFEhKFmWnoTzzqv5p1kKQphd
//    SN6FrMblYnRsPCLxn01tEvMQoKxwYzZhI04AaVz+wX6d5XMxAkEA4SYenOZFK3Oe
//    KJQwMfLceikB6t0c7C1yUAmdwytozUJuD6gzejD5pUkQhFsc78lECR4gFEtBKwOv
//    Q4ftlB6PZwJBANSMkThSoLl/ABKJ1vrXRcjwqJo+G2vRdM6Hq52z/YqBtvemRc9Y
//    xD+CGaHx1hlYARjh/LXl/NsReivqdHRA/U0CQQC3aWJO1pdKimkxDWcliX5qVbWm
//    KnJBQ9R3tx25vEcnzxHx10f4JqV4LEk0STUNcZvnAY+IeLWh4OKJ1NWJcEvJAkEA
//    hYTcAOafAofOMtcWDjNHKkhLkcEsFpnYZ5kAbKvRvL1pg76Wof8gIMkIcxvpI7iN
//    z+S+jEGyiqc6+PVqPFFLDQJBAMnKCXqySYT2nXEzjvV6CjZMBuH1xxb+IOz0bT76
//    COP0JakJ3NV9p5+VpPqK1q9/WccWtYuQkSk9RBQhhNPtCGE=
//    
    
    
    
        

        

        
        
//            NSString *oderStringSource=@"partner=\"2088021577004853\"&seller_id=\"vab_pm@cmi.chinamobile.com\"&out_trade_no=\"RY2IA4Z78BYYCW1\"&subject=\"1\"&body=\"我是测试数据\"&total_fee=\"0.02\"&notify_url=\"http://www.xxx.com\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&show_url=\"m.alipay.com\"";
//            
        
        id<DataSigner> signer = CreateRSADataSigner(privateKey);
         NSString *signKey = [signer signString:[order description]];

        
        
        
        
        
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       [order description], signKey, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            
            NSInteger  statusCode = [resultDic[@"resultStatus"] integerValue];
            
            if (statusCode == 9000) {
                
                
              //  [Utils postMessage:[AliPayNotice copy] body:@"1"];
       
                
            }else{
                
           
           //     [Utils postMessage:[AliPayNotice copy] body:@"0"];
                
                
                
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
