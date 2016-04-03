//
//  UseCouponViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/3.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "UseCouponViewCtrl.h"

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


@end

@implementation UseCouponViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self makeFooterView];
    
    
    
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
    
    
    
    UILabel *messageLabel = [UILabel new];
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor brownColor];
    
    [bgView addSubview:messageLabel];
    
    messageLabel.text=@"    支付宝和微信支付额外九折";
    
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
        

        NSLog(@"支付。。。。。");
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    

    
    
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
    
    moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    moneyTextField.delegate = self;
    moneyTextField.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:moneyTextField];
    [moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.right.equalTo(cell.contentView).offset(-10);
        make.height.equalTo(@20);
        make.centerY.equalTo(cell.contentView);
        
    }];
    
    
    //按钮修改后
    [moneyTextField bk_addEventHandler:^(id sender) {
        NSLog(@"money %@",moneyTextField.text);
        
        CGFloat money = [moneyTextField.text floatValue];
        
        CGFloat payMoney = money *0.7f;
        
        self.payMoneyTextField.text = [NSString stringWithFormat:@"%.2f元",payMoney];
        
    } forControlEvents:UIControlEventEditingChanged];
    
 

    
    
    
    
}

/**
 *  选择优惠券单元格
 *
 *  @param cell 单元格变量
 */
-(void)makeSelectCoupon:(UITableViewCell*)cell{
    
    
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text=@"咖啡懂你优惠券";
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
