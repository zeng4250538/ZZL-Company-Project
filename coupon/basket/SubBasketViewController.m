//
//  SubBasketViewController.m
//  coupon
//
//  Created by ZZL on 16/5/19.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "SubBasketViewController.h"
#import "GoToMapViewCtrl.h"
#import "UseCouponViewCtrl.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"
@interface SubBasketViewController ()<UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SubBasketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableLayout];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"分享" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        
        //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
        
        
        NSString *couponName= SafeString(self.subData[@"name"]);
        
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:UmengKey
                                          shareText:couponName
                                         shareImage:@""
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToSina,nil]
                                           delegate:self];
        
        
        
        
        
    }];
}

-(void)tableLayout{
    
    _tableView =[[UITableView alloc]init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(-70);
        make.right.and.left.equalTo(self.view).offset(0);
        
    }];
    
    UIImageView *immediatelyBg = [[UIImageView alloc]init];
    immediatelyBg.backgroundColor = [UIColor whiteColor];
    [immediatelyBg setUserInteractionEnabled:YES];
    [self.view addSubview:immediatelyBg];
    [immediatelyBg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.view).offset(-10);
        make.left.and.right.equalTo(self.view).offset(0);
        make.width.equalTo(@70);
    }];
    
    if (_boolView == NO) {
        return;
    }
    UIButton *immediateUseButton = [[UIButton alloc]init];
    [immediateUseButton setTitle:@"立即使用" forState:UIControlStateNormal];
    immediateUseButton.layer.masksToBounds = YES;
    immediateUseButton.layer.cornerRadius = 7;
    [immediateUseButton setBackgroundColor:UIColorFromRGB(249, 191, 66)];
    [immediatelyBg addSubview:immediateUseButton];
    [immediateUseButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(immediatelyBg).offset(5);
        make.bottom.equalTo(immediatelyBg).offset(-5);
        make.left.equalTo(immediatelyBg).offset(27);
        make.right.equalTo(immediatelyBg).offset(-27);
    }];
    [immediateUseButton bk_addEventHandler:^(id sender) {
        
        UseCouponViewCtrl *vc = [UseCouponViewCtrl new];
        
        NSDictionary *d = self.subData;
        
        
        
        vc.data = d;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    
    
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 260;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        return 50;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        return 60;
    }
    if (indexPath.section == 3 && indexPath.row == 0) {
        return 60;
    }
    if (indexPath.section == 4 && indexPath.row == 0) {
        return 60;
    }
    if (indexPath.section == 5 && indexPath.row == 0) {
        return 60;
    }
    
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 4) {
        return 1;
    }
    if (section == 5) {
        return 0;
    }
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
            
        case 0:
            return 1;
            break;
            
        case 1:
            return 1;
            break;
            
        case 2:
            return 1;
            break;
        
        case 3:
            return 1;
            break;
        
        case 4:
            return 1;
            break;
        
        case 5:
            return 1;
            break;
            
        default:
            break;
    }
    
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 NSLog(@"优惠篮子优惠券详情 ---------》%@",_subData);
    
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self firstOneCellView:cell];
        
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self firstTwoCellView:cell];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.backgroundColor = UIColorFromRGB(230, 230, 230);
        [self firstThreeCellView:cell];
    }
    if (indexPath.section == 3 && indexPath.row == 0) {
        [self firstFourCellView:cell];
    }
    if (indexPath.section == 4 && indexPath.row == 0) {
        [self firstForCellView:cell];
    }
    if (indexPath.section == 5 && indexPath.row == 0) {
        [self firstSexCellView:cell];
    }
    
    return cell;


}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    

}


-(void)firstOneCellView:(UITableViewCell *)cell{

    UIImageView *topImage = [[UIImageView alloc]init];
    
    NSURL *url = SafeUrl(self.subData[@"photoUrl"]);
    [topImage sd_setImageWithURL:url];
    [cell.contentView addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(cell.contentView).offset(0);
        make.right.and.left.equalTo(cell.contentView).offset(0);
        make.height.equalTo(@220);
        
    }];

    UILabel *couponName = [[UILabel alloc]init];
    couponName.text = SafeString(self.subData[@"name"]);
    couponName.font = [UIFont systemFontOfSize:14];
    couponName.textColor = UIColorFromRGB(215, 60, 63);
//    couponName.backgroundColor = [UIColor greenColor];
    [cell addSubview:couponName];
    [couponName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(topImage).offset(220);
        make.left.equalTo(cell.contentView).offset(15);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
        
    }];
    
}


-(void)firstTwoCellView:(UITableViewCell *)cell{

    UILabel *shopName = [[UILabel alloc]init];
    shopName.text = SafeString(self.subData[@"shopName"]);
    shopName.textColor = UIColorFromRGB(200, 200, 200);
    [cell.contentView addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).offset(10);
        make.left.equalTo(cell.contentView).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];


}

-(void)firstThreeCellView:(UITableViewCell *)cell{

    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.backgroundColor = [UIColor whiteColor];
    [leftButton setTitle:@"拨打电话" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, self.view.bounds.size.width/2-1, 60);
    [cell.contentView addSubview:leftButton];
    
    [leftButton bk_addEventHandler:^(id sender) {
        NSString *phoneString=[NSString stringWithFormat:@"telprompt://%@",SafeString(self.subData[@"phone"])];
        NSLog(@"phoneString电话-----》 %@",phoneString);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://12580"]];
    } forControlEvents:UIControlEventTouchUpInside];

    UIButton *rightButton = [[UIButton alloc]init];
    rightButton.backgroundColor = [UIColor whiteColor];
    [rightButton setTitle:@"去到那里" forState:UIControlStateNormal];
    [rightButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(self.view.bounds.size.width/2+1, 0, self.view.bounds.size.width/2-1, 60);
    [cell.contentView addSubview:rightButton];

    [rightButton bk_addEventHandler:^(id sender) {
        
        GoToMapViewCtrl *vc = [GoToMapViewCtrl new];
        vc.hidesBottomBarWhenPushed = YES;
        
        
        CLLocationCoordinate2D loc;
        loc.latitude = 23.138756;
        loc.longitude = 113.32881;
        vc.endLocation = loc;
        
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];

}

-(void)firstFourCellView:(UITableViewCell *)cell{

    UILabel *titleabel  = [[UILabel alloc]init];
    titleabel.text = @"有效期为：";
    [cell.contentView addSubview:titleabel];
    [titleabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(cell.contentView).offset(0);
        make.left.equalTo(cell.contentView).offset(10);
        make.right.equalTo(cell.contentView).offset(0);
    }];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = [NSString stringWithFormat:@"%@",SafeString(self.subData[@"endTime"])];
    [cell.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.bottom.equalTo(cell.contentView).offset(0);
        make.left.equalTo(cell.contentView).offset(100);
        make.width.equalTo(@300);
        
    }];


}

-(void)firstForCellView:(UITableViewCell *)cell{

    UILabel *titleLatbel = [[UILabel alloc]init];
    titleLatbel.text = @"使用须知";
    [cell.contentView addSubview:titleLatbel];
    [titleLatbel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(cell.contentView).offset(10);
        make.left.equalTo(cell.contentView).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
        
    }];

}

-(void)firstSexCellView:(UITableViewCell *)cell{

    UILabel *commontLabel = [[UILabel alloc]init];
    commontLabel.text = @"1、预约：免预约，消费高峰期可能需排队";
    commontLabel.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:commontLabel];
    [commontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(cell.contentView).offset(10);
        make.left.equalTo(cell.contentView).offset(10);
        make.width.equalTo(@300);
        make.height.equalTo(@40);
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
