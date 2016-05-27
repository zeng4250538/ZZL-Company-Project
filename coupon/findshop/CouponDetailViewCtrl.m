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
#import "BasketService.h"
#import "CouponService.h"
#import "GoToMapViewCtrl.h"



@interface CouponDetailViewCtrl ()
@property(nonatomic,strong)UILabel   *cartNumLabel;
@property(nonatomic,strong)UIButton *cartButton;
@property(nonatomic,strong)UIImage *couponImage;





@end

@implementation CouponDetailViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        //make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        
        
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
       // make.height.equalTo(@45);
        make.bottom.equalTo(self.view);
    }];
    
    
    
    
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationItem.title=@"优惠详情";
    
    
    
    
    [self makeHeaderView];
    
    
    
    if (self.couponDetailType == CouponDetailTypeHaveCart) {
        
        [self makeBottomView];
        
        [self makeCartView];
        
    }
    
    
    if (self.couponDetailPushMode == CouponDetailPushModePresent) {
        
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"关闭" style:UIBarButtonItemStylePlain handler:^(id sender) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }];
        
    }
    
    
 
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[UIColor whiteColor]];
    
    
    //暂时注释
//    if (self.couponViewMode == CouponViewModeNetwork) { //需要通过网络装载
//        
//        [self loadData];
//        
//    }
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"分享" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        
        //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
        
        
        NSString *couponName= SafeString(self.data[@"name"]);
        
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:UmengKey
                                          shareText:couponName
                                         shareImage:self.couponImage
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToSina,nil]
                                           delegate:self];
        
        

        
        
    }];
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    
    
    
}


//暂时注释
//-(void)loadData{
//    
//    
//    [ReloadHud showHUDAddedTo:self.tableView reloadBlock:^{
//        
//        
//        [self doLoad:^(BOOL ret){
//            
//            if (ret) {
//                [ReloadHud removeHud:self.tableView animated:YES];
//            }else{
//                
//                [ReloadHud showReloadMode:self.tableView];
//            }
//            
//            
//        }];
//        
//        
//    }];
//    
//    
//    [self doLoad:^(BOOL ret){
//        
//        if (ret) {
//            [ReloadHud removeHud:self.tableView animated:YES];
//        }else{
//            
//            [ReloadHud showReloadMode:self.tableView];
//        }
//        
//        
//    }];
//    
//    
//    
//}

//暂时注释
-(void)doLoad:(void(^)(BOOL ret))completion{
    
    
    CouponService *service = [CouponService new];
    
    
    
    [service requestCouponInfo:self.couponId success:^(NSInteger code, NSString *message, id data) {
        
        
        self.data = data[@"coupon"];
        
        [self makeHeaderView];
        
        [self.tableView reloadData];
        
        completion(YES);
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        [self makeHeaderView];
        
        
        
        
        completion(NO);
        
        
        
        
    }];
    
    
    
    
    
    
}







-(void)makeCartView{
    
    
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cartButton setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
    
    cartButton.frame = CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-150, 60, 60);
    
//    cartButton.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
//    
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
        
        make.left.equalTo(cartButton.mas_right).offset(-15);
        make.top.equalTo(cartButton.mas_top).offset(9);
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
    
//    CGFloat rate = 416.0f/750.0f;
    
//    NSLog(@"-------------------------hahhahahhahaha-------------------------------------%@",self.data);

    UIImageView *uv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    uv.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = SafeUrl(self.data[@"photoUrl"]);
    
    if (!url) {
        url =  SafeUrl(self.data[@"smallPhotoUrl"]);

    }
    
    
    
    
    [uv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo60@3x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        self.couponImage = image;
        
        
        
        
    }];
    
    
    
    self.tableView.tableHeaderView = uv;
    
    
    
    
}

-(void)makeBottomView{
    
    UIView *uv = [UIView new];
    
    uv.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:uv];
    
    [uv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.height.equalTo(@60);
        make.left.right.equalTo(self.view);
        
    }];
    
    
    UIView *hLine = [UIView new];
    [uv addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.width.equalTo(uv);
        make.left.equalTo(uv);
        make.top.equalTo(uv);
        
        
    }];
    
    hLine.backgroundColor = [GUIConfig mainBackgroundColor];

    
    
    UIButton *addCartButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addCartButton.backgroundColor = UIColorFromRGB(249, 191, 66);
    
    [uv addSubview:addCartButton];
    
    [addCartButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(uv).offset(-40);
        make.left.equalTo(uv).offset(40);
        make.top.equalTo(uv).offset(10);
        make.bottom.equalTo(uv).offset(-10);
    }];
    
    [addCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addCartButton setTitle:@"加入篮子" forState:UIControlStateNormal];
    addCartButton.layer.cornerRadius = 7;
    [addCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [addCartButton bk_addEventHandler:^(id sender) {
        
        // [self loadData];
        
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
        
    } forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - TableViewCell 
-(void)makeCell1:(UITableViewCell*)cell{
    
    
    
//    UILabel *shopNameLabel = [UILabel new];
//    
//    [cell.contentView addSubview:shopNameLabel];
//    
//    shopNameLabel.font = [UIFont boldSystemFontOfSize:16];
//    shopNameLabel.textColor = [GUIConfig grayFontColorDeep];
//    [shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
//        make.top.equalTo(cell.contentView.mas_top).with.offset(20);
//        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
//        make.height.equalTo(@20);
//        
//    }];
    
//    shopNameLabel.text=SafeString(self.data[@"shopName"]);
    
    
    UILabel *couponNameLabel = [UILabel new];
    [cell.contentView addSubview:couponNameLabel];
    couponNameLabel.font = [UIFont systemFontOfSize:18];
    couponNameLabel.textColor = [GUIConfig mainColor];
    
    [couponNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(cell.contentView).offset(20);
        
        make.centerY.equalTo(cell.contentView);
        make.height.equalTo(@20);
        
    }];
    couponNameLabel.text=[NSString stringWithFormat:@"%@",SafeString(self.data[@"name"])];
    
    
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
    
    
    addressLabel.text=SafeString(self.data[@"shopName"]);
    
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
    
    [callPhoneButton bk_addEventHandler:^(id sender) {
        
        //phone
        
        NSString *phone = SafeString(self.data[@"shopPhone"]);
        
        NSString *phoneString=[NSString stringWithFormat:@"telprompt://%@",phone];
        NSLog(@"phoneString电话-----》 %@",phoneString);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
        
        

        
    } forControlEvents:UIControlEventTouchUpInside];
    
 
    UIButton *gotoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [cell.contentView addSubview:gotoButton];
    
    [gotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH/2);
        
        make.right.and.bottom.equalTo(cell.contentView);
        make.top.equalTo(line);
    }];
    
    [gotoButton setTitle:@"去到这里" forState:UIControlStateNormal];
    
    [gotoButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    
    
    [gotoButton bk_addEventHandler:^(id sender) {
        
        GoToMapViewCtrl *vc = [GoToMapViewCtrl new];
        vc.hidesBottomBarWhenPushed = YES;
        
        
        CLLocationCoordinate2D loc;
        loc.latitude = 23.138756;
        loc.longitude = 113.32881;
        vc.endLocation = loc;
        
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    
    UILabel *nameLabel = [UILabel new];
    
    [cell.contentView addSubview:nameLabel];
    
    nameLabel.font = [UIFont boldSystemFontOfSize:14];
    nameLabel.textColor = [GUIConfig grayFontColorDeep];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.centerY.equalTo(cell.contentView);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        
    }];
    
    nameLabel.text=@"有效时间:";
 
    UILabel *limitTimeLabel = [UILabel new];
    
    [cell.contentView addSubview:limitTimeLabel];
    
    limitTimeLabel.font = [UIFont systemFontOfSize:14];
    limitTimeLabel.textColor = [GUIConfig grayFontColor];
    [limitTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).with.offset(20);
        make.centerY.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView).offset(-20);
        make.height.equalTo(@20);
        
    }];
    
    limitTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    limitTimeLabel.text=SafeString(self.data[@"validEndDate"]);
    

    
}




-(void)makeCell4:(UITableViewCell*)cell{
    
    
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
    
    commentTitleLabel.text=@"使用须知:";
    
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
        make.height.equalTo(@80);
        
    }];
    
    
    commentLabel.textColor = [GUIConfig grayFontColor];
    commentLabel.font = [UIFont systemFontOfSize:14];
    commentLabel.numberOfLines=0;
    commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    commentLabel.text=@"1、商品说明：一次消费只能使用一张优惠券\n2、预约：免预约，消费高峰期可能";
    
  
    
}

#pragma mark - Table view config


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([indexPath section]==0) {
        return 50;
    }
    
    
    if ([indexPath section]==2) {
        return 50;
    }

    if ([indexPath section]==3) {
        return 130;
    }

    return 100;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }else if(section==4){
    
        return 60;
    }else{
        
        return 20;
    }
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 4) {
        
        UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20+40)];
        
        uv.backgroundColor = [GUIConfig mainBackgroundColor];
        
        
        UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [otherButton setTitle:@"其他优惠" forState:UIControlStateNormal];
        [uv addSubview:otherButton];
        [otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(uv);
            make.top.equalTo(uv).offset(20);
            make.bottom.equalTo(uv);
            make.width.equalTo(@(SCREEN_WIDTH/2));
        }];
        
        [otherButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
        
        otherButton.backgroundColor = [UIColor whiteColor];
 
        
        UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [likeButton setTitle:@"猜你喜欢" forState:UIControlStateNormal];
        [uv addSubview:likeButton];
        [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(otherButton.mas_right);
            make.top.equalTo(uv).offset(20);
            make.bottom.equalTo(uv);
            make.width.equalTo(@(SCREEN_WIDTH/2));
        }];
        
        likeButton.backgroundColor = [UIColor whiteColor];
        
        [likeButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
        
        
        UIView *vLine = [UIView new];
        [uv addSubview:vLine];
        [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@1);
            make.height.equalTo(@30);
            make.centerX.equalTo(uv);
            make.top.equalTo(uv).offset(25);
            
            
        }];
        
        vLine.backgroundColor = [GUIConfig mainBackgroundColor];
        
        UIView *hLine = [UIView new];
        [uv addSubview:hLine];
        [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@1);
            make.width.equalTo(uv);
            make.left.equalTo(uv);
            make.bottom.equalTo(uv);
            
            
        }];
        
        hLine.backgroundColor = [GUIConfig mainBackgroundColor];

        
       // btn1.layer.borderWidth=1;
        
        return uv;
 
    }
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    uv.backgroundColor = [GUIConfig mainBackgroundColor];
    
    return uv;
    
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
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
    
 
    if ([indexPath section]==3) {
        
        [self makeCell4:cell];
        
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
