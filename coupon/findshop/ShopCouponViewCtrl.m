//
//  ShopDetailViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopCouponViewCtrl.h"
#import "ShopCouponTableViewCell.h"
#import "CouponDetailViewCtrl.h"


@interface ShopCouponViewCtrl ()

@end

@implementation ShopCouponViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[ShopCouponTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self makeHeaderView];
    
    
 
    
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 48, 0);
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    static int NAVBAR_CHANGE_POINT = 50;
    
    UIColor * color = [GUIConfig mainColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

#pragma mark - viewWillAppear


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    
    
    
    
    
    
    
    
    
    
    
}



-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    self.navigationController.automaticallyAdjustsScrollViewInsets=YES;
    
  //  self.automaticallyAdjustsScrollViewInsets=YES;
    
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    
    
    
    //self.parentViewController.navigationItem.leftBarButtonItem = nil;
    
    
    
    
    //  self.navigationController.navigationBar.translucent = YES;
    
    
    
    
    
    
}




#pragma mark - 头部信息
-(void)makeHeaderView{
    
    
    CGFloat rate = 416.0f/750.0f;
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*rate+30)];
    uv.backgroundColor = [UIColor whiteColor];
    
    UIButton *shopBgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shopBgButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*rate);
    
    [uv addSubview:shopBgButton];
    
    
    NSString *url = [Utils getRandomImage:@"商家封面"];
    
    [shopBgButton setBackgroundImage:[UIImage imageNamed:url] forState:UIControlStateNormal];
    
    
    UIView *bottomBar = [[UIView alloc] init];
    [uv addSubview:bottomBar];

    [bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(uv.mas_left);
        make.right.equalTo(uv.mas_right);
        make.top.equalTo(shopBgButton.mas_bottom);
        
    }];
    
    bottomBar.backgroundColor = [UIColor colorWithWhite:0.985 alpha:1.0];
    
    
    
    UIImageView *goodIcon = [GUIConfig iconGood];
    
    [bottomBar addSubview:goodIcon];
    
    [goodIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bottomBar.mas_left).with.offset(20);
        make.centerY.equalTo(bottomBar.mas_centerY);
    }];
    
    
    UILabel *goodLabel = [UILabel new];
    [bottomBar addSubview:goodLabel];

    
    goodLabel.textColor=[GUIConfig grayFontColor];
    goodLabel.font = [UIFont systemFontOfSize:12];
    goodLabel.text=@"1234";
    [goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@40);
        make.left.equalTo(goodIcon.mas_right).with.offset(10);
        make.centerY.equalTo(bottomBar.mas_centerY);
        
    }];
    
  
    
    UIImageView *badIcon = [GUIConfig iconBad];
    
    [bottomBar addSubview:badIcon];
    
    [badIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(goodLabel.mas_right).with.offset(20);
        make.centerY.equalTo(bottomBar.mas_centerY);
    }];
    
    
    UILabel *badLabel = [UILabel new];
    [bottomBar addSubview:badLabel];
    
    
    badLabel.textColor=[GUIConfig grayFontColor];
    badLabel.font = [UIFont systemFontOfSize:12];
    badLabel.text=@"55";
    [badLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@40);
        make.left.equalTo(badIcon.mas_right).with.offset(10);
        make.centerY.equalTo(bottomBar.mas_centerY);
        
    }];
    
    
    UILabel *commentLabel = [UILabel new];
    commentLabel.textColor = [GUIConfig mainColor];
    commentLabel.font = [UIFont systemFontOfSize:12];
    
    [bottomBar addSubview:commentLabel];
    
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
  //      make.width.equalTo(@40);
        make.left.equalTo(bottomBar.mas_centerX);
        make.centerY.equalTo(bottomBar.mas_centerY);

    }];
    
    commentLabel.text=@"网友评论(1245)";
    
  
    
    
    
    
    
    
    self.tableView.tableHeaderView = uv;
    
    
    
    
    
    
    
    
    
    
}
#pragma mark - Table View Config


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CouponDetailViewCtrl *vc = [[CouponDetailViewCtrl alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        
        
        return [ShopCouponTableViewCell headerView:@"即时优惠" touchBlock:^{
            
        }];

        
        
    }else{
        
        
        return [ShopCouponTableViewCell headerView:@"其他优惠" touchBlock:^{
            
        }];

        
   
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [ShopCouponTableViewCell height];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return 2;
    }
    
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    if ([indexPath section]==0) {
        
        cell.couponType = CouponTypeLimited;
    }else{
        
        cell.couponType = CouponTypeNormal;
    }
    
    
    [cell updateData];
    
    // Configure the cell...
    
    return cell;
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
