//
//  CouponUsageDetail.m
//  coupon
//
//  Created by chijr on 16/4/15.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "CouponUsageDetailViewCtrl.h"
#import "CommentSubmitViewCtrl.h"
#import "CouponDetailViewCtrl.h"
#import "SubHistorySevice.h"
#import "IdShopSevice.h"
#import "ConsumptionSuccessDataSevice.h"
#import "HistoryCouponUsageViewCtrl.h"
#import "PersonInfoViewCtrl.h"
@interface CouponUsageDetailViewCtrl ()


@property(nonatomic,assign)BOOL isSubmitReturn;
@property(nonatomic,strong)UIButton *toCommentButton;
@property(nonatomic,strong)NSDictionary *subDic;

@property(nonatomic,strong)UILabel *originPriceValueLabel;
@property(nonatomic,strong)UILabel *realPriceValueLabel;
@property(nonatomic,strong)UILabel *payMethodValueLabel;
@property(nonatomic,strong)UILabel *payTimeValueLabel;


@end

@implementation CouponUsageDetailViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isSubmitReturn = NO;
    
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    self.navigationItem.title=@"消费明细";
    
    
    
    
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self makeFooterView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotice:) name: ReviewUpdateNotice object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)updateNotice:(id)sender{
    
    
    NSLog(@"NSNotificationCenter update %@",sender);
    
    self.toCommentButton.hidden = YES;
    
    
    
    
    
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  //  self.toCommentButton.hidden = YES;
        
    if (_boolConsumptionData == YES) {
        
        
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(barButtonClickEvent)];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        
        
        [self loadData];
        
        
        
    }
    
//    [self subViewLoadData];
    
}
//跳转到指定页面
-(void)barButtonClickEvent{
    
//     VC = self.navigationController.viewControllers[0];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushView" object:nil];
    

}

-(void)loadData{

    [ReloadHud showHUDAddedTo:self.tableView reloadBlock:^{
        
        
        [self doLoad:^(BOOL ret){
            
            if (ret) {
                
                
                [ReloadHud removeHud:self.tableView animated:YES];
            }else{
                
                [ReloadHud showReloadMode:self.tableView];
            }
            
            
        }];
        
        
    }];
    
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.tableView animated:YES];
        }else{
            
            [ReloadHud showReloadMode:self.tableView];
        }
        
        
    }];

}

#pragma mark ------ 网络数据获取
-(void)doLoad:(void(^)(BOOL ret))completion{
    
    ConsumptionSuccessDataSevice *app = [ConsumptionSuccessDataSevice new];
    [app consumptionDataRequestCouponInstanceId:_couponInstanceId success:^(id data) {
        
        
        NSDictionary *dic = @{@"id":data[@"id"] , @"reviewId":data[@"reviewId"] , @"couponPhotoUrl":data[@"coupon"][@"photoUrl"] , @"shopName":@"" , @"couponName":data[@"coupon"][@"name"] , @"originalPrice":data[@"originalPrice"] , @"paymentPrice":data[@"paymentPrice"] , @"paymentServiceProvider":data[@"paymentServiceProvider"] , @"consumedTime":data[@"consumedTime_Timestamp"] };
        
        _data = dic;
        completion(YES);
        [self.tableView reloadData];
        [self againLoadLayout];
//        [self subViewLoadData];
        
        
    } failure:^(id data) {
        
        completion(NO);
        
    }];
    
    
    
}


//重新获得数据
-(void)againLoadLayout{

    _payTimeValueLabel.text=SafeString(self.data[@"consumedTime"]);
    _originPriceValueLabel.text= [NSString stringWithFormat:@"%@元",SafeString(self.data[@"originalPrice"])];
    _realPriceValueLabel.text= [NSString stringWithFormat:@"%@元",SafeString(self.data[@"paymentPrice"])];
    _payMethodValueLabel.text = SafeString(self.data[@"paymentServiceProvider"]);
    _payTimeValueLabel.text=SafeString(self.data[@"consumedTime"]);

}

-(void)makeFooterView{
    
    self.tableView.tableFooterView.frame = CGRectMake(0,0,SCREEN_WIDTH, 100);
    
    
    UIButton *toCommentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.toCommentButton = toCommentButton;
    [self.tableView.tableFooterView addSubview:toCommentButton];
    
    [toCommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.tableView.tableFooterView).offset(20);
        make.left.equalTo(self.tableView.tableFooterView).offset(30);
        make.right.equalTo(self.tableView.tableFooterView).offset(-30);
        make.height.equalTo(@40);
        
    }];
    
    [toCommentButton setTitle:@"去评论" forState:UIControlStateNormal];
    toCommentButton.backgroundColor = [GUIConfig orangeColor];
    [toCommentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [toCommentButton bk_addEventHandler:^(id sender) {
        
        
        CommentSubmitViewCtrl *vc =[CommentSubmitViewCtrl new];
        vc.data =self.data;
        
        self.isSubmitReturn = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    if (SafeEmpty(self.data[@"reviewId"])) {
        
        toCommentButton.hidden = NO;
        
        
    }else{
        
        toCommentButton.hidden = YES;
        
    }
    
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    
    if (section==1) {
        return 30;
    }
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        return 100;
    }
    
    return 160;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    
    uv.backgroundColor = [GUIConfig mainBackgroundColor];
    
    UILabel *lab = [UILabel new];
    
    lab.frame = CGRectMake(10, 0, SCREEN_WIDTH- 10, 30);
    
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [GUIConfig grayFontColor];
    
    lab.text=@"消费明细";
    [uv addSubview:lab];
    
    return uv;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    for(UIView * subView in cell.contentView.subviews) [subView removeFromSuperview];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ((indexPath.row==0) && (indexPath.section==0)) {
        
        UIImageView *logoView = [UIImageView new];
        
        [cell.contentView addSubview:logoView];
        
        [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView).offset(15);
            make.top.equalTo(cell.contentView).offset(10);
            make.bottom.equalTo(cell.contentView).offset(-10);
            make.width.equalTo(@100);
        }];
        
        NSURL *url = SafeUrl(self.data[@"couponPhotoUrl"]);
        SafeLoadUrlImage(logoView, url, ^{
            [cell setNeedsLayout];
        });
        UILabel *shopLabel = [UILabel new];
        [cell.contentView addSubview:shopLabel];
        
        [shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(logoView.mas_right).offset(10);
            make.top.equalTo(logoView.mas_top);
            make.right.equalTo(cell.contentView).offset(20);
            make.height.equalTo(@20);
            
        }];
        
        shopLabel.text = SafeString(self.data[@"shopName"]);
        shopLabel.font = [UIFont systemFontOfSize:14];
        shopLabel.textColor = [GUIConfig grayFontColor];
        
        UILabel *couponLabel = [UILabel new];
        [cell.contentView addSubview:couponLabel];
        
        [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(logoView.mas_right).offset(10);
            make.top.equalTo(shopLabel.mas_bottom).offset(5);
            make.right.equalTo(cell.contentView).offset(20);
            make.height.equalTo(@20);
            
        }];
        
        couponLabel.text = SafeString(self.data[@"couponName"]);
        
        couponLabel.font = [UIFont systemFontOfSize:12];
        couponLabel.textColor = [GUIConfig grayFontColorLight];
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;

        
        
        
    }
    
    if ((indexPath.row==0) && (indexPath.section==1)) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *originPriceLabel = [UILabel new];
        originPriceLabel.font = [UIFont systemFontOfSize:14];
        originPriceLabel.textColor = [GUIConfig grayFontColorDeep];
        originPriceLabel.text=@"消费金额";
        
        [cell.contentView addSubview:originPriceLabel];
        
        [originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(15);
            make.top.equalTo(cell.contentView).offset(15);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
            
        }];
        
        _originPriceValueLabel = [UILabel new];
        _originPriceValueLabel.font = [UIFont systemFontOfSize:14];
        _originPriceValueLabel.textColor = [GUIConfig grayFontColor];
        
        if ([SafeString(self.data[@"originalPrice"]) length]>0) {
            _originPriceValueLabel.text= [NSString stringWithFormat:@"%@元",SafeString(self.data[@"originalPrice"])];
        }
        else{
        
            _originPriceValueLabel.text= @"0元";
        
        }
        
        
        [cell.contentView addSubview:_originPriceValueLabel];
        
        [_originPriceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(SCREEN_WIDTH/2));
            make.top.equalTo(originPriceLabel);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
            
        }];
        
        
        
        

        
        UILabel *realPriceLabel = [UILabel new];
        realPriceLabel.font = [UIFont systemFontOfSize:14];
        realPriceLabel.textColor = [GUIConfig grayFontColorDeep];
        realPriceLabel.text=@"实付金额";
        
        [cell.contentView addSubview:realPriceLabel];
        
        [realPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(15);
            make.top.equalTo(originPriceLabel.mas_bottom).offset(10);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
            
        }];
        
        
        //实付金额钱数
        _realPriceValueLabel = [UILabel new];
        _realPriceValueLabel.font = [UIFont systemFontOfSize:14];
        _realPriceValueLabel.textColor = [GUIConfig grayFontColor];
        if ([SafeString(self.data[@"paymentPrice"]) length]>0) {
            
            _realPriceValueLabel.text= [NSString stringWithFormat:@"%@元",SafeString(self.data[@"paymentPrice"])];
            
        }
        else{
        
            _realPriceValueLabel.text= @"0元";
        
        }
        
        [cell.contentView addSubview:_realPriceValueLabel];
        
        [_realPriceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(SCREEN_WIDTH/2));
            make.top.equalTo(realPriceLabel);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
            
        }];
        
        
        
 
        UILabel *payMethodLabel = [UILabel new];
        payMethodLabel.font = [UIFont systemFontOfSize:14];
        payMethodLabel.textColor = [GUIConfig grayFontColorDeep];
        payMethodLabel.text=@"支付方式";
        
        [cell.contentView addSubview:payMethodLabel];
        
        [payMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(15);
            make.top.equalTo(_realPriceValueLabel.mas_bottom).offset(10);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
            
        }];
//
        _payMethodValueLabel = [UILabel new];
        _payMethodValueLabel.font = [UIFont systemFontOfSize:14];
        _payMethodValueLabel.textColor = [GUIConfig grayFontColor];
        _payMethodValueLabel.text = SafeString(self.data[@"paymentServiceProvider"]);
        
        [cell.contentView addSubview:_payMethodValueLabel];
        
        [_payMethodValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(SCREEN_WIDTH/2));
            make.top.equalTo(payMethodLabel);
            make.right.equalTo(cell.contentView.mas_right).offset(-10);
            make.height.equalTo(@20);
            
        }];


        UILabel *payTimeLabel = [UILabel new];
        payTimeLabel.font = [UIFont systemFontOfSize:14];
        payTimeLabel.textColor = [GUIConfig grayFontColorDeep];
        payTimeLabel.text=@"支付时间";
        
        [cell.contentView addSubview:payTimeLabel];
        
        [payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(15);
            make.top.equalTo(payMethodLabel.mas_bottom).offset(10);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
            
        }];
        
        _payTimeValueLabel = [UILabel new];
        _payTimeValueLabel.font = [UIFont systemFontOfSize:14];
        _payTimeValueLabel.textColor = [GUIConfig grayFontColor];
        
//        SafeString(self.data[@"consumedTime"]);
        
       
        _payTimeValueLabel.text = dateController(self.data[@"consumedTime"]);
        
        [cell.contentView addSubview:_payTimeValueLabel];
        
        [_payTimeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(SCREEN_WIDTH/2));
            make.top.equalTo(payTimeLabel);
            make.right.equalTo(cell.contentView.mas_right).offset(-10);
            make.height.equalTo(@20);
            
        }];

        
        
        return cell;
        
    }
    
    return cell;
    
    // Configure the cell...
    
}

#pragma mark - long时间转换
//-(NSString *)dateData:(NSString *)data{
//
//    const long dateTimeLong = [data longLongValue]/1000;
//    NSDate *dateTime = [[NSDate alloc] initWithTimeIntervalSince1970:dateTimeLong];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeStyle:NSDateFormatterNoStyle];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    NSLocale *formatterLocal = [[NSLocale alloc] initWithLocaleIdentifier:@"en_us"];
//    [formatter setLocale:formatterLocal];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateString = [formatter stringFromDate:dateTime];
//    return dateString;
//    
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSString *couponId = SafeString(self.data[@"id"]);
    
    
    
    
    CouponDetailViewCtrl *vc =[CouponDetailViewCtrl new];
    
    vc.couponViewMode = CouponViewModeNetwork;
    
    vc.couponDetailType = CouponDetailPushModePush;
    
//    vc.couponId = couponId;
    
    
    
    
    if (indexPath.section == 0 && indexPath.row ==0) {
       
        [self subViewLoadData:^(bool data) {
            
            if (data) {
                vc.data = _subDic;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }];
        
    }

}


//获取消费明细点击进去的详情页的头部信息
-(void)subViewLoadData:(void(^)(bool data))success{
    
    NSString *couponId = SafeString(self.data[@"id"]);
    SubHistorySevice *app = [SubHistorySevice new];
    [app subRequrestCouponInstanceId:couponId withSuccess:^(id data) {
        
        [self shopIdRequrestLoadData:SafeString(data[@"shopId"]) withSuccess:^(id shopData) {
            
            [app subBoolShopCart:SafeString(data[@"couponPromotion"][@"id"]) customerId:[AppShareData instance].customId withSuccess:^(id cartData) {
                
                _subDic =@{@"name":SafeString(data[@"coupon"][@"name"]),@"photoUrl":SafeString(data[@"coupon"][@"photoUrl"]),@"shopName":SafeString(shopData[@"name"]),@"shopPhone":SafeString(shopData[@"phone"]),@"startTime":dateController(data[@"couponPromotion"][@"validStartDate"]),@"endTime":dateController(data[@"couponPromotion"][@"validEndDate"]),@"id":SafeString(data[@"couponId"]),@"addedToBasket":SafeString([NSString stringWithFormat:@"%@",cartData[@"allowedTakenByCurrentCustomer"]])};
                success(YES);
                
            } withFailure:^(id cartData) {
                
            }];
            
        }];
        
//        _subDic = @{@"name":SafeString(data[@"coupon"][@"name"])};
        
//        vc.data = _subDic;
//        [self.navigationController pushViewController:vc animated:YES];
        
    } withFailure:^(id data) {
        
    }];


}

//消费明细点击进去的详情页的底部请求
-(void)shopIdRequrestLoadData:(NSString *)shopId withSuccess:(void(^)(id shopData))success{

    IdShopSevice *iss = [IdShopSevice new];
    [iss shopIdRequrestString:shopId withSuccess:^(id data) {
        success(data);
    } withFailure:^(id data) {
        
    }];
    
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
