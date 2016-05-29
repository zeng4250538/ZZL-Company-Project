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

@interface CouponUsageDetailViewCtrl ()


@property(nonatomic,assign)BOOL isSubmitReturn;
@property(nonatomic,strong)UIButton *toCommentButton;


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
        [logoView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [cell setNeedsLayout];
            
        }];
        
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
        
        UILabel *originPriceValueLabel = [UILabel new];
        originPriceValueLabel.font = [UIFont systemFontOfSize:14];
        originPriceValueLabel.textColor = [GUIConfig grayFontColor];
        originPriceValueLabel.text= [NSString stringWithFormat:@"%@元",SafeString(self.data[@"originalPrice"])];
        
        [cell.contentView addSubview:originPriceValueLabel];
        
        [originPriceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
        UILabel *realPriceValueLabel = [UILabel new];
        realPriceValueLabel.font = [UIFont systemFontOfSize:14];
        realPriceValueLabel.textColor = [GUIConfig grayFontColor];
        realPriceValueLabel.text= [NSString stringWithFormat:@"%@元",SafeString(self.data[@"sellingPrice"])];
        
        [cell.contentView addSubview:realPriceValueLabel];
        
        [realPriceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
            make.top.equalTo(realPriceValueLabel.mas_bottom).offset(10);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
            
        }];
//
        UILabel *payMethodValueLabel = [UILabel new];
        payMethodValueLabel.font = [UIFont systemFontOfSize:14];
        payMethodValueLabel.textColor = [GUIConfig grayFontColor];
        payMethodValueLabel.text = SafeString(self.data[@"paymentServiceProvider"]);
        
        [cell.contentView addSubview:payMethodValueLabel];
        
        [payMethodValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
        UILabel *payTimeValueLabel = [UILabel new];
        payTimeValueLabel.font = [UIFont systemFontOfSize:14];
        payTimeValueLabel.textColor = [GUIConfig grayFontColor];
        payTimeValueLabel.text=SafeString(self.data[@"consumedTime"]);
        
        [cell.contentView addSubview:payTimeValueLabel];
        
        [payTimeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *couponId = SafeString(self.data[@"id"]);
    
    
    
    
    CouponDetailViewCtrl *vc =[CouponDetailViewCtrl new];
    
    vc.couponViewMode = CouponViewModeNetwork;
    
    vc.couponDetailType = CouponDetailTypeNotHaveCart;
    
    vc.couponId = couponId;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}


-(void)subViewLoadData{

    


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
