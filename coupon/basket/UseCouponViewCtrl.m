//
//  UseCouponViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/3.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "UseCouponViewCtrl.h"
#import "PayUtils.h"
#import "OrderService.h"
#import "WXUtil.h"
#import "SubBasketViewController.h"

@interface UseCouponViewCtrl ()


/**
 *  微信支付按钮
 */

@property(nonatomic,strong)UIButton *wechatPayButton;

/**
 *  支付宝按钮
 */
@property(nonatomic,strong)UIButton *aliPayButton;
/**
 *  实际支付金额
 */
@property(nonatomic,strong)UITextField *payMoneyTextField;


@property(nonatomic,assign)CGFloat originPrice;
@property(nonatomic,assign)CGFloat sellPrice;
@property(nonatomic,assign)CGFloat paymentPrice;



@end

@implementation UseCouponViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self makeFooterView];
    
    
    self.originPrice = 0.0f;
    
    
    self.navigationItem.title=@"优惠券支付";
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
        [self.tableView endEditing:YES];
    }];
    
    tap.delegate= self;
    
    
    [self.view addGestureRecognizer:tap];
    
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //微信支付消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPayResult:) name:[WechatPayNotice copy] object:nil];
    
    
    //淘宝支付消息通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayResult:) name:[ALiPayNotice copy] object:nil];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[WechatPayNotice copy] object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[ALiPayNotice copy] object:nil];
    
    

    
    
    
    
}


-(void)wechatPayResult:(id)sender{
    
 
    NSNotification *notice = (NSNotification*)sender;
    
    NSString *result = (NSString*)notice.object;
    
    if ([result isEqualToString:@"1"]){  //支付成功
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        UIAlertView *av =[UIAlertView bk_alertViewWithTitle:@"注意" message:@"微信支付成功！"];
        [av bk_addButtonWithTitle:@"关闭" handler:^{
            
        }];
        
        [av show];

        
        
        
        
//        PaySuccessViewCtrl *vc = [[PaySuccessViewCtrl alloc] init];
//        
//        vc.orderId = self.orderId;
//        
//        
//        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    }else{     //支付失败
        
        
//        
//        UINavigationController *nav = self.navigationController;
//        
//        
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        
//        OrderDetailViewCtrl *vc = [[OrderDetailViewCtrl alloc] init];
//        vc.orderId = self.orderId;
//        
//        [nav pushViewController:vc animated:YES];
        
        
        
        
        
        
        
        
        UIAlertView *av =[UIAlertView bk_alertViewWithTitle:@"注意" message:@"微信支付失败！"];
        [av bk_addButtonWithTitle:@"关闭" handler:^{
            
        }];
        
        [av show];
        
        
        
        
    }
    
    
    
    
    
    
    
}


#pragma mark - 淘宝支付结果通知

-(void)aliPayResult:(id)sender{
    
    
    NSNotification *notice = (NSNotification*)sender;
    
    NSString *result = (NSString*)notice.object;
    
    if ([result isEqualToString:@"1"]){  //支付成功
        
        
        UIAlertView *av =[UIAlertView bk_alertViewWithTitle:@"注意" message:@"支付宝支付成功！"];
        [av bk_addButtonWithTitle:@"关闭" handler:^{
            
        }];
        
        [av show];
        
        
        
//        PaySuccessViewCtrl *vc = [[PaySuccessViewCtrl alloc] init];
//        
//        vc.orderId = self.orderId;
//        // vc.data = self.data[@"orderinfo"];
//        
//        
//        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    }else{     //支付失败
        
        
        
        
        
        UINavigationController *nav = self.navigationController;
        
        
        
        UIAlertView *av =[UIAlertView bk_alertViewWithTitle:@"注意" message:@"支付宝支付失败！"];
        [av bk_addButtonWithTitle:@"关闭" handler:^{
            
        }];
        
        [av show];
        
        
        
    }
    
    
    
    
    
    
    
    
}






- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

/**
 *  尾部视图和按钮
 */
-(void)makeFooterView{
    
    self.tableView.backgroundColor=[GUIConfig mainBackgroundColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    bgView.backgroundColor = [GUIConfig mainBackgroundColor];
    
    self.tableView.tableFooterView = bgView;
    
    NSString *nums = SafeString(self.data[@"onlinePaymentDiscount"]);
    float num = [nums floatValue];
    int number = num*10;
    UILabel *messageLabel = [UILabel new];
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor brownColor];
    
    [bgView addSubview:messageLabel];
    
//    messageLabel.text=@"    支付宝和微信支付额外九折";
    if (num < 1) {
        NSLog(@"asdasd   %fl",num);
        messageLabel.text=[NSString stringWithFormat:@"    支付宝和微信支付额外%d折",number];
        
    }
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(bgView).offset(5);
        make.centerX.equalTo(bgView);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@30);
        
        
        
    }];
    
    
    
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [bgView addSubview:payButton];
    
    
    
    
    payButton.backgroundColor = [GUIConfig orangeColor];
    
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(50);
        make.centerX.equalTo(bgView);
        make.width.equalTo(@(SCREEN_WIDTH-60));
        make.height.equalTo(@40);
        
    }];
    
    
    
    
   // payButton.backgroundCol
    
    [payButton setTitle:@"支付" forState:UIControlStateNormal];
    
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    payButton.layer.cornerRadius = 4;
    payButton.clipsToBounds = YES;
    
    
    [payButton bk_addEventHandler:^(id sender) {
        
        
        
        
#pragma mark 支付功能
        
        
        NSString *moneyString = self.payMoneyTextField.text;
        
        if ([moneyString floatValue]<=0.0){
            
            [SVProgressHUD showErrorWithStatus:@"支付金额为空！"];
            return ;
            
            
        }
        
        
        NSTimeInterval tm = [NSDate timeIntervalSinceReferenceDate];
        
        //该id作为优惠券id
        
        NSString *couponInstanceId = SafeString(self.data[@"id"]);
        
        
        OrderService *service = [OrderService new];
        
        
#pragma mark - 微信支付
        
        if (self.wechatPayButton.selected){
            
            
            //本地支付测试使用
//            [self doWeChatLocalPay:@"优惠券001" price:1.0];
//            
//            return;
            
            
            
           // -(void)doWeChatLocalPay:(NSString*)orderName price:(CGFloat)price{

            
            //远程支付
            
            
            
            
            
            
            [SVProgressHUD showWithStatus:@"支付中..." maskType:SVProgressHUDMaskTypeBlack];
            
            [service requestPrepayId:couponInstanceId originalPrice:self.originPrice sellingPrice:self.sellPrice paymentPrice:self.paymentPrice success:^(NSInteger code, NSString *message, id data) {
                
                NSLog(@"<----点击支付后的信息----》%@",data);
                NSString *returnCode = data[@"returnCode"];
                
                if (![returnCode isEqualToString:@"SUCCESS"]) {
                    
                    [SVProgressHUD showErrorWithStatus:@"微信预支付失败" maskType:SVProgressHUDMaskTypeBlack];
                    
                    return ;
                    
                }
                
                
                NSString *prepayId = SafeString(data[@"prepayId"]);
                
                
               // NSDictionary *dict = [PayUtils weChatSign:prepayId];
                
                
                
                NSInteger timeStamp = [data[@"timestamp"] integerValue];
                
                
                [PayUtils callWeChatPay:prepayId sign:SafeString(data[@"sign"])
                               noncestr:SafeString(data[@"nonceStr"])
                              timeStamp:timeStamp];
                
                
                [SVProgressHUD dismiss];
                
                
                
                
//                PayUtils +(void)callWeChatPay:(NSString*)prepayId sign:(NSString*)sign noncestr:(NSString*)noncestr timeStamp:(UInt32)timeStamp;

                
                
                

                
                
                
                
                
                
                
            } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                
                
                [SVProgressHUD dismiss];
                
                
                
                [SVProgressHUD showErrorWithStatus:@"支付服务器繁忙" maskType:SVProgressHUDMaskTypeBlack];
                
                
                
            }];
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
#pragma mark - 淘宝支付
        if (self.aliPayButton.selected) {
            
            
            
            
            [service requestAliPaySign:couponInstanceId originalPrice:self.originPrice sellingPrice:self.sellPrice success:^(NSInteger code, NSString *message, id data) {
                
                NSLog(@"<----点击支付后的信息----》%@",data);
                NSString *returnCode = data[@"returnCode"];
                
                if (![returnCode isEqualToString:@"SUCCESS"]) {
                    
                    [SVProgressHUD showErrorWithStatus:@"支付宝支付服务器请求失败！" maskType:SVProgressHUDMaskTypeBlack];
                    
                    return ;
                    
                }
                
                
                
                // NSDictionary *dict = [PayUtils weChatSign:prepayId];
                
                
                
                
                
                NSString *waitSign = data[@"waitSign"];
                
                
                
               // [PayUtils aliPay:couponInstanceId orderSn:couponInstanceId orderName:@"test" money:1.0 sign:@""];
                [PayUtils aliPayServer:waitSign sign:data[@"sign"]];
                
                                
                [SVProgressHUD dismiss];
                
                
                
                
                //                PayUtils +(void)callWeChatPay:(NSString*)prepayId sign:(NSString*)sign noncestr:(NSString*)noncestr timeStamp:(UInt32)timeStamp;
                
                
                
                
                
                
                
                
                
                
                
                
            } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
                
                
                [SVProgressHUD dismiss];
                
                
                
                [SVProgressHUD showErrorWithStatus:@"支付服务器繁忙" maskType:SVProgressHUDMaskTypeBlack];
                
                
                
            }];

            
            
            
            
            
  
            
        }
        
        
        
        
        

        NSLog(@"支付中。。。。。");
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    

    
    
}


-(void)doWeChatLocalPay:(NSString*)orderName price:(CGFloat)price{
    
    
    
    [PayUtils sendWechatPay:orderName price:[NSString stringWithFormat:@"%.0f",price*100]];
    
    
    
    
    
    
//    + (void)sendWechatPay:(NSString*)orderName price:(NSString*)price
//
//    
//    [PayUtils aliPay:orderId orderSn:orderId orderName:SafeString(self.data[@"name"]) money:[self.payMoneyTextField.text floatValue]];
//
    
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 表格单元生成
/**
 *  输入金额的单元格生成
 *
 *  @param cell 单元格变量
 */

-(void)makeInputMoneyCell:(UITableViewCell*)cell{
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text=@"消费总金额";
    nameLabel.font = [UIFont systemFontOfSize:14];
    //nameLabel.backgroundColor=[UIColor greenColor];
    [cell.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(15);
        make.width.equalTo(cell.contentView).dividedBy(4);
        make.height.equalTo(@20);
        
    }];
    
    UITextField *moneyTextField = [UITextField new];
    moneyTextField.placeholder = @"询问服务员后输入金额";
    
    moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    moneyTextField.delegate = self;
    moneyTextField.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:moneyTextField];
    [moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.right.equalTo(cell.contentView).offset(-10);
        make.height.equalTo(@20);
        make.centerY.equalTo(cell.contentView);
        
    }];
    
    moneyTextField.text =[NSString stringWithFormat:@"%.2f",self.originPrice];
    NSLog(@"%@",moneyTextField.text);
    
    
#pragma  mark - 修改moneyTextField
    
    [moneyTextField bk_addEventHandler:^(id sender) {
        NSLog(@"money %@",moneyTextField.text);
        
        CGFloat money = [moneyTextField.text floatValue];
        
        
        
        self.originPrice = money;
        
        NSString *nums = SafeString(self.data[@"onlinePaymentDiscount"]);
        float num = [nums floatValue];
//        int number = num*10;
        
        CGFloat discountRate = [SafeString(self.data[@"discountRate"]) floatValue];
#pragma  mark - 计算金额
        CGFloat payMoney = money * discountRate;
        
        self.paymentPrice = payMoney*num;
        
        self.sellPrice = payMoney;
        
        self.payMoneyTextField.text = [NSString stringWithFormat:@"%.2f元",payMoney];
        
    } forControlEvents:UIControlEventEditingChanged];
    
 

    
    
    
    
}

/**
 *  选择优惠券单元格
 *
 *  @param cell 单元格变量
 */

#pragma mark - 选择优惠券单元格
-(void)makeSelectCoupon:(UITableViewCell*)cell{
    
    
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text=SafeString(self.data[@"name"]);
    nameLabel.font = [UIFont systemFontOfSize:14];
    //nameLabel.backgroundColor=[UIColor greenColor];
    [cell.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(15);
        make.right.equalTo(cell.contentView).offset(-15);
        make.height.equalTo(@20);
        
    }];

    
    
    
    
    
    
    
}


/**
 *  实付金额
 *
 *  @param cell 单元格
 */

-(void)makeRealMoneyCell:(UITableViewCell*)cell{
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text=@"实付金额：";
    nameLabel.font = [UIFont systemFontOfSize:14];
    //nameLabel.backgroundColor=[UIColor greenColor];
    [cell.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(15);
        make.width.equalTo(cell.contentView).dividedBy(4);
        make.height.equalTo(@20);
        
    }];
    
    UITextField *moneyTextField = [UITextField new];
    moneyTextField.placeholder = @"";
    moneyTextField.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:moneyTextField];
    [moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.right.equalTo(cell.contentView).offset(-10);
        make.height.equalTo(@20);
        make.centerY.equalTo(cell.contentView);
        
    }];
    
    moneyTextField.enabled = NO;
    
    self.payMoneyTextField = moneyTextField;
    
    
    
    
}


-(void)makePayMethod:(UITableViewCell*)cell payMode:(PayMode)payMode{
    
    
    UILabel *nameLabel = [UILabel new];
    
    if (payMode==PayModeWeChat) {
        nameLabel.text=@"微信支付";
    }
    
    if (payMode==PayModeAliPay) {
        nameLabel.text=@"支付宝支付";
    }
    
    
    nameLabel.font = [UIFont systemFontOfSize:14];
    //nameLabel.backgroundColor=[UIColor greenColor];
    [cell.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(15);
        make.width.equalTo(cell.contentView).dividedBy(3);
        make.height.equalTo(@20);
        
    }];
    
    
    if (payMode==PayModeWeChat) {
        
        self.wechatPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.wechatPayButton.selected = YES;
        
        [self.wechatPayButton setImage:[UIImage imageNamed:@"CellRedSelected"] forState:UIControlStateSelected];
        
        [self.wechatPayButton setImage:nil forState:UIControlStateNormal];
        
        [cell.contentView addSubview:self.wechatPayButton];
        
        
        [self.wechatPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(-20);
            make.centerY.equalTo(cell.contentView);
            
        }];
        
        
        
    }
    

    if (payMode==PayModeAliPay) {
        
        self.aliPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.aliPayButton.selected = NO;
        
        [self.aliPayButton setImage:[UIImage imageNamed:@"CellRedSelected"] forState:UIControlStateSelected];
        
        [self.aliPayButton setImage:nil forState:UIControlStateNormal];
        
        [cell.contentView addSubview:self.aliPayButton];
        
        
        [self.aliPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(-20);
            make.centerY.equalTo(cell.contentView);
            
        }];
        
        
        
    }

    
    

    
    
    
}


#pragma mark - Table view data source


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section==1) {
        UIView *uv = [UIView new];
        uv.backgroundColor = [GUIConfig mainBackgroundColor];
        uv.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        UILabel *nameLabel = [UILabel new];
        [uv addSubview:nameLabel];
        nameLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-10 ,30);
        
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = [GUIConfig grayFontColor];
        nameLabel.text=@"使用的优惠券";
        
        return uv;
        
        
        
        
    }
    
    if (section==2) {
        UIView *uv = [UIView new];
        uv.backgroundColor = [GUIConfig mainBackgroundColor];
        uv.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        UILabel *nameLabel = [UILabel new];
        [uv addSubview:nameLabel];
        nameLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-10 ,20);
        
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.textColor = [UIColor redColor];
        nameLabel.text=@"请确认该优惠券是否为商家所有";
        
        return uv;
        
        
        
        
    }
    
    
    if (section==3) {
        UIView *uv = [UIView new];
        uv.backgroundColor = [GUIConfig mainBackgroundColor];
        uv.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        UILabel *nameLabel = [UILabel new];
        [uv addSubview:nameLabel];
        nameLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-10 ,30);
        
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = [GUIConfig grayFontColor];
        nameLabel.text=@"选择支付方式";
        
        return uv;
        
        
        
        
    }

    
    
    
    
    
    
    return nil;
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }
    
    
    if (section==1) {
        return 30;
    }
    
    if (section==2) {
        return 50;
    }
    
    
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==3) {
        return 2;
    }
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *uv in [cell.contentView subviews]) {
        
        [uv removeFromSuperview];
    }
    
    if (indexPath.section==0) {
        
        
        [self makeInputMoneyCell:cell];
    
        
    }
    
    if (indexPath.section==1) {
        
        
        [self makeSelectCoupon:cell];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    
    if (indexPath.section==2) {
        
        
        
        [self makeRealMoneyCell:cell];
        
        
        
    }
    
    if (indexPath.section==3) {
        
        
        if (indexPath.row==0) {
            
            
            [self makePayMethod:cell payMode:PayModeWeChat];
            
        }
        
        if (indexPath.row==1) {
            
            [self makePayMethod:cell payMode:PayModeAliPay];
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        SubBasketViewController *SBVC = [SubBasketViewController new];
        SBVC.boolView = NO;
        SBVC.subData = self.data;
        [self.navigationController pushViewController:SBVC animated:YES];
        
    }
    
    if (indexPath.section==3 && indexPath.row==0) {
        
        self.wechatPayButton.selected = YES;
        self.aliPayButton.selected = NO;
    }
    
    if (indexPath.section==3 && indexPath.row==1) {
        
        self.wechatPayButton.selected = NO;
        self.aliPayButton.selected = YES;
    }
    
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
