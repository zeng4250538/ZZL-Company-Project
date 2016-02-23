//
//  ShopDetailViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopInfoViewCtrl.h"
#import "CouponInfoTableViewCell.h"
#import "CouponDetailViewCtrl.h"
#import "ShopCommentViewCtrl.h"
#import "CouponListViewCtrl.h"
#import "MallMapViewCtrl.h"
#import "CouponService.h"


@interface ShopInfoViewCtrl ()

@property(nonatomic,strong)NSArray *limitCouponList;
@property(nonatomic,strong)NSArray *otherCouponList;

@end

@implementation ShopInfoViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[CouponInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self makeHeaderView];
    
    
 
    
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 48, 0);
    
    
    [self loadData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)loadData{
    
    
    
    
    CouponService *service = [CouponService new];
    
    [service queryShopCoupon:nil success:
    ^(int code, NSString *message, id data) {
        
        
        if (code==0) {
            
            self.limitCouponList = data[@"limit"];
            
            self.otherCouponList = data[@"other"];
            
            [self.tableView reloadData];
        }
        
        
        
        
        
    } failure:
    ^(int code, BOOL retry, NSString *message, id data) {
        
    }];
    
    
    
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
    
    
    UIButton *subButton = [UIButton buttonWithType:UIButtonTypeCustom];

    
    [shopBgButton addSubview:subButton];
    
    subButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(shopBgButton).offset(-10);
        make.bottom.equalTo(shopBgButton).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@60);
        
    }];
    
    [subButton bk_addEventHandler:^(id sender) {
        
        subButton.selected = !subButton.selected;
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    subButton.layer.cornerRadius=4;
    subButton.clipsToBounds = YES;
    
    [subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [subButton setTitle:@"订阅" forState:UIControlStateNormal];
 
    [subButton setTitle:@"取消订阅" forState:UIControlStateSelected];
    
    subButton.backgroundColor =UIColorFromRGB(247, 180, 38);
    
    //[GUIConfig greenBackgroundColor];
    
    
    
    
    UILabel *subLabel = [UILabel new];
    [shopBgButton addSubview:subLabel];
    subLabel.font = [UIFont boldSystemFontOfSize:10];
    subLabel.lineBreakMode = NSLineBreakByWordWrapping;
    subLabel.numberOfLines = 2;
    subLabel.textColor = [UIColor whiteColor];
    subLabel.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.7f];
    //[subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    subLabel.text=@"订阅数\n1234\n";
    subLabel.layer.cornerRadius=4;
    subLabel.clipsToBounds = YES;
    [subLabel sizeToFit];
    
    subLabel.textAlignment = NSTextAlignmentCenter;
    
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(subButton.mas_left).offset(-5);
        make.bottom.equalTo(subButton);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    
    
    
    
    
    
    
    UIView *bottomBar = [[UIView alloc] init];
    [uv addSubview:bottomBar];

    [bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(uv.mas_left);
        make.right.equalTo(uv.mas_right);
        make.top.equalTo(shopBgButton.mas_bottom);
        
    }];
    
    bottomBar.backgroundColor = [UIColor colorWithWhite:0.985 alpha:1.0];
    
    
    
    
    UIButton *likeButton = [GUIConfig iconGood];

    
    [bottomBar addSubview:likeButton];
    
    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bottomBar.mas_left).with.offset(20);
        make.centerY.equalTo(bottomBar);
    }];
    
    //喜欢按钮
    
    [likeButton bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *likeLabel = [UILabel new];
    [bottomBar addSubview:likeLabel];

    
    likeLabel.textColor=[GUIConfig grayFontColor];
    likeLabel.font = [UIFont systemFontOfSize:12];
    likeLabel.text=@"1234";
    [likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //make.width.equalTo(@40);
        make.left.equalTo(likeButton.mas_right).with.offset(10);
        make.centerY.equalTo(bottomBar.mas_centerY);
        
    }];
    
  
    
    UIButton *unlikeButton = [GUIConfig iconBad];
    
    
    
    
    [bottomBar addSubview:unlikeButton];
    
    
    //不喜欢按钮
    [unlikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(likeLabel.mas_right).with.offset(20);
        make.centerY.equalTo(bottomBar);
    }];
    
    
    [unlikeButton bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *unlikeLabel = [UILabel new];
    [bottomBar addSubview:unlikeLabel];
    
    
    unlikeLabel.textColor=[GUIConfig grayFontColor];
    unlikeLabel.font = [UIFont systemFontOfSize:12];
    unlikeLabel.text=@"55";
    [unlikeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@40);
        make.left.equalTo(unlikeButton.mas_right).with.offset(10);
        make.centerY.equalTo(bottomBar);
        
    }];
    
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [commentButton setTitleColor:[GUIConfig mainColor] forState:UIControlStateNormal];
    [commentButton setTitle:@"网友评论(1245)" forState:UIControlStateNormal];
    
    commentButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    [bottomBar addSubview:commentButton];
    
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bottomBar.mas_centerX);
        make.centerY.equalTo(bottomBar);

    }];
    
    [commentButton bk_addEventHandler:^(id sender) {
        
        ShopCommentViewCtrl *vc = [ShopCommentViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
  
    
    
    
    
    
    
    self.tableView.tableHeaderView = uv;
    
    
    
    
    
    
    
    
    
    
}
#pragma mark - Table View Config


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CouponDetailViewCtrl *vc = [[CouponDetailViewCtrl alloc] init];
    
    
    
    
    if ([indexPath section]==0) {
        
        
        vc.data = self.limitCouponList[indexPath.row];
        
    }else{
        
        
        vc.data = self.otherCouponList[indexPath.row];
    }
    
    
    
    
  //  NSDictionary *d = s
    
    
    
    vc.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        
        
        return [CouponInfoTableViewCell headerView:@"即时优惠" clickBlock:^{
            
            
            CouponListViewCtrl *vc =[CouponListViewCtrl new];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
            NSLog(@"click 即时优惠 ");
            
        }];

        
        
    }else{
        
        
        return [CouponInfoTableViewCell headerView:@"其他优惠" clickBlock:^{
            
            CouponListViewCtrl *vc =[CouponListViewCtrl new];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }];

        
   
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    return [CouponInfoTableViewCell height];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return [self.limitCouponList count];
    }else{
        return [self.otherCouponList count];
        
        
    }
    
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    

    
    if ([indexPath section]==0) {
        
        cell.couponActionType = CouponTypeLimited;
        
        NSDictionary *d = self.limitCouponList[indexPath.row];
        
        [cell updateData:d];
        
    }else{
        
        cell.couponActionType = CouponTypeNormal;
        
        NSDictionary *d = self.otherCouponList[indexPath.row];
        
        [cell updateData:d];
        
    }
    
    
    
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
