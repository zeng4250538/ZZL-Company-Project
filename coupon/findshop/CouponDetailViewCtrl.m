//
//  CouponDetailViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/3.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CouponDetailViewCtrl.h"
#import "CartViewCtrl.h"
#import "ToPayTableViewCtrl.h"

#import "UINavigationBar+Awesome.h"
#import "AppShareData.h"
#import "ThrowLineTool.h"
#import "BasketContainerViewCtrl.h"


@interface CouponDetailViewCtrl ()
@property(nonatomic,strong)UILabel   *cartNumLabel;
@property(nonatomic,strong)UIButton *cartButton;


@end

@implementation CouponDetailViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        
        
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.view);
      
        make.bottom.equalTo(self.view).offset(-45);
    }];
    
    
    
    
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationItem.title=@"优惠详情";
    
    
    
    
    [self makeHeaderView];
    
    [self makeBottomView];
    
    [self makeCartView];
    
 
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[UIColor whiteColor]];
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




-(void)makeCartView{
    
    
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [cartButton setImage:[UIImage imageNamed:@"gocart.png"] forState:UIControlStateNormal];
    
    cartButton.frame = CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-150, 60, 60);
    
    cartButton.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    
    cartButton.clipsToBounds = YES;
    cartButton.layer.cornerRadius = 30;
    [self.view addSubview:cartButton];
    
    self.cartButton = cartButton;
    
    
    [cartButton bk_addEventHandler:^(id sender) {
        
        
        BasketContainerViewCtrl *vc =[[BasketContainerViewCtrl alloc] init];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
        
        
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    self.cartNumLabel = [UILabel new];
    
    
    [self.view addSubview:self.cartNumLabel];
    
    [self.cartNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cartButton.mas_right).offset(-10);
        make.top.equalTo(cartButton.mas_top).offset(10);
        make.width.equalTo(@14);
        make.height.equalTo(@14);
        
        
    }];
    
    self.cartNumLabel.layer.cornerRadius=7;
    self.cartNumLabel.font = [UIFont boldSystemFontOfSize:10];
    self.cartNumLabel.textColor = [UIColor whiteColor];
    self.cartNumLabel.clipsToBounds = YES;
    self.cartNumLabel.backgroundColor = [UIColor redColor];
    self.cartNumLabel.text=@"";
    self.cartNumLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    [self updateCartNum];
    
    
  
    
    
    
    
    
}

-(void)updateCartNum{
    
    
    NSUInteger count = [[AppShareData instance] getCartCount];
    
    if (count==0) {
        self.cartNumLabel.text=@"";
        self.cartNumLabel.hidden = YES;
    }else{
        
        self.cartNumLabel.text = [NSString stringWithFormat:@"%ld",count];
        self.cartNumLabel.hidden = NO;
    }
    
    
    
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)makeHeaderView{
    
    CGFloat rate = 416.0f/750.0f;
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*rate)];
    uv.backgroundColor = [UIColor whiteColor];
    
    UIButton *shopBgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shopBgButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*rate);
    
    [uv addSubview:shopBgButton];
    
    
    NSString *url = [Utils getRandomImage:@"商家封面"];
    
    [shopBgButton setBackgroundImage:[UIImage imageNamed:url] forState:UIControlStateNormal];
    
    
    self.tableView.tableHeaderView = uv;
    
    
    
    
}

-(void)makeBottomView{
    
    UIView *uv = [UIView new];
    
    uv.backgroundColor=[GUIConfig mainBackgroundColor];
    
    [self.view addSubview:uv];
    
    [uv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.height.equalTo(@45);
        make.left.right.equalTo(self.view);
        
    }];
    
    
    UIButton *addCartButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [uv addSubview:addCartButton];
    
    [addCartButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.top.left.and.bottom.equalTo(uv);
    }];
    
    [addCartButton setTitle:@"加入篮子" forState:UIControlStateNormal];
    
    [addCartButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    
    
    
    
    
    
    [addCartButton bk_addEventHandler:^(id sender) {
        
        
        ThrowLineTool *tool = [[ThrowLineTool alloc] init];
        
        
        
        UIView *ballView = [[UIView alloc] initWithFrame:CGRectMake(addCartButton.frame.origin.x+SCREEN_WIDTH/8, SCREEN_HEIGHT-60,20, 20)];
        
        ballView.backgroundColor = [UIColor redColor];
        ballView.layer.cornerRadius =ballView.frame.size.width;
        
        [self.view addSubview:ballView];
        
        
        
        
        
        CGFloat startX = ballView.frame.origin.x;//arc4random() % (NSInteger)CGRectGetWidth(self.frame);
        CGFloat startY = ballView.frame.origin.y;//CGRectGetHeight(self.frame);
        CGFloat endX = CGRectGetMidX(self.cartButton.frame)+25;
        CGFloat endY = CGRectGetMidY(self.cartButton.frame)-15;
        CGFloat height = -100;
        [tool throwBall:ballView
                     from:CGPointMake(startX, startY)
                       to:CGPointMake(endX, endY)
                   height:height duration:0.5];
        
        
        
        tool.didFinishBlock = ^(){
            
            [ballView removeFromSuperview];
            
            
            
            [[AppShareData instance] addCouponToCart:self.data];
            
            [self updateCartNum];
            
            
        };
        
        
            
            // return;
            
            
            
            
            
     
        
        
        
        
        
        
        
        
//        CartViewCtrl *vc = [CartViewCtrl new];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [uv addSubview:buyButton];
    
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH/2);
        
        make.top.right.and.bottom.equalTo(uv);
    }];
    
    [buyButton setTitle:@"直接购买" forState:UIControlStateNormal];
    
    [buyButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    
    [buyButton bk_addEventHandler:^(id sender) {
        ToPayTableViewCtrl *vc =[ToPayTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIView *line2 = [GUIConfig line];
    line2.backgroundColor = [GUIConfig grayFontColorLight];
    
    [uv addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@1);
        make.top.equalTo(buyButton).offset(10);
        make.bottom.equalTo(buyButton).offset(-10);
        make.left.equalTo(buyButton);
        
    }];

    
    
}

#pragma mark - TableViewCell 


-(void)makeCell1:(UITableViewCell*)cell{
    
    
    
    UILabel *couponNameLabel = [UILabel new];
    
    [cell.contentView addSubview:couponNameLabel];
    
    couponNameLabel.font = [UIFont boldSystemFontOfSize:16];
    couponNameLabel.textColor = [GUIConfig grayFontColorDeep];
    [couponNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(cell.contentView.mas_top).with.offset(20);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@20);
        
    }];
    
    couponNameLabel.text=self.data[@"name"];
    
    
    UILabel *priceLabel = [UILabel new];
    [cell.contentView addSubview:priceLabel];
    priceLabel.font = [UIFont systemFontOfSize:18];
    priceLabel.textColor = [GUIConfig mainColor];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(couponNameLabel);
        
        make.bottom.equalTo(cell.contentView).offset(-15);
        make.height.equalTo(@20);
        
    }];
    priceLabel.text=self.data[@"price"];
    
    
    
    
    
    
    
}

-(void)makeCell2:(UITableViewCell*)cell{
    
    
    UILabel *addressLabel = [UILabel new];
    
    [cell.contentView addSubview:addressLabel];
    
    addressLabel.font = [UIFont boldSystemFontOfSize:16];
    addressLabel.textColor = [GUIConfig grayFontColorDeep];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(cell.contentView.mas_top).with.offset(10);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@30);
        
    }];
    
    addressLabel.text=self.data[@"shop"][@"address"];
    
    UIView *line = [GUIConfig line];
    
    [cell.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.top.equalTo(addressLabel.mas_bottom).offset(10);
        make.right.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(10);
        
        
    }];
    
    
    UIButton *callPhoneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [cell.contentView addSubview:callPhoneButton];
    
    [callPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.left.and.bottom.equalTo(cell.contentView);
        make.top.equalTo(line);
    }];
    
    [callPhoneButton setTitle:@"拨打电话" forState:UIControlStateNormal];
    
    [callPhoneButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    
 
    UIButton *gotoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [cell.contentView addSubview:gotoButton];
    
    [gotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH/2);
        
        make.right.and.bottom.equalTo(cell.contentView);
        make.top.equalTo(line);
    }];
    
    [gotoButton setTitle:@"去到这里" forState:UIControlStateNormal];
    
    [gotoButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    
    
    
    UIView *line2 = [GUIConfig line];
    
    [cell.contentView addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@1);
        make.top.equalTo(gotoButton).offset(10);
        make.bottom.equalTo(gotoButton).offset(-10);
        make.left.equalTo(gotoButton);
        
    }];


    
    
    
    
    
    
    
}


-(void)makeCell3:(UITableViewCell*)cell{
    
    
    UILabel *commentTitleLabel = [UILabel new];
    
    [cell.contentView addSubview:commentTitleLabel];
    
    commentTitleLabel.font = [UIFont boldSystemFontOfSize:16];
    commentTitleLabel.textColor = [GUIConfig grayFontColorDeep];
    [commentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(cell.contentView.mas_top).with.offset(10);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@20);
        
    }];
    
    commentTitleLabel.text=@"使用说明:";
    
    UIView *line = [GUIConfig line];
    
    [cell.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.top.equalTo(commentTitleLabel.mas_bottom).offset(10);
        make.right.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(10);
        
        
    }];
    
    
    UILabel *commentLabel = [UILabel new];
    
    [cell.contentView addSubview:commentLabel];
    
    commentLabel.font = [UIFont boldSystemFontOfSize:16];
    commentLabel.textColor = [GUIConfig grayFontColorDeep];
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(line.mas_top).with.offset(5);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@50);
        
    }];
    
    
    commentLabel.textColor = [GUIConfig grayFontColor];
    commentLabel.font = [UIFont systemFontOfSize:12];
    commentLabel.numberOfLines=0;
    commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    commentLabel.text=@"1.解释权归商家所有\n2.用餐前先预约\n3.用餐高峰需要排队\n4.有效期为一年";
    
    
    
    
    

    
    
    
}

#pragma mark - Table view config


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([indexPath section]==2) {
        return 130;
    }
    
    return 100;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }else{
        
        return 20;
    }
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    uv.backgroundColor = [GUIConfig mainBackgroundColor];
    
    return uv;
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    for (UIView *uv in [cell.contentView subviews]) {
        [uv removeFromSuperview];
    }
    
    if ([indexPath section]==0) {
        
        [self makeCell1:cell];
        
        
        
    }
 
    if ([indexPath section]==1) {
        
        
        [self makeCell2:cell];
        
        
 
        
    }
 
    if ([indexPath section]==2) {
        
        [self makeCell3:cell];
        
    }
    
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
