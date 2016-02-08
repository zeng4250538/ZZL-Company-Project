//
//  ShakeCouponViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShakeCouponViewCtrl.h"
#import "CouponDetailViewCtrl.h"
#import "CouponView.h"
#import "ThrowLineTool.h"
#import "AppShareData.h"
#import "CartViewCtrl.h"
#import "BasketContainerViewCtrl.h"
#import "CouponService.h"
#import "ShakeService.h"



@interface ShakeCouponViewCtrl ()

@property(nonatomic,strong)CouponView *imgView;
@property(nonatomic,strong)CouponView *nextView;
@property(nonatomic,strong)UITapGestureRecognizer *tapCouponRG;
@property(nonatomic,strong)UIButton *cartButton;
@property(nonatomic,strong)UILabel *cartNumLabel;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeUpCouponRG;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeDownCouponRG;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeLeftCouponRG;

@property(nonatomic,strong)NSDictionary *couponData;

@property(nonatomic,strong)NSMutableArray *shakeCouponList;

@property(nonatomic,strong)UIView *placeHolderView;




@end

@implementation ShakeCouponViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.view.backgroundColor =[UIColor colorWithWhite:0.1f alpha:0.7f];
    
    
    UITapGestureRecognizer *rg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    
    [self.view addGestureRecognizer:rg];
  
    
    self.tapCouponRG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapCoupon:)];
    
    self.swipeUpCouponRG = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(doSwipe:)];
    
    self.swipeUpCouponRG.direction = UISwipeGestureRecognizerDirectionUp;
  
    self.swipeDownCouponRG = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(doSwipe:)];
    
    self.swipeDownCouponRG.direction = UISwipeGestureRecognizerDirectionDown;

//    self.swipeLeftCouponRG = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(doSwipe:)];
//    
//    self.swipeLeftCouponRG.direction = UISwipeGestureRecognizerDirectionLeft;
//    
    
    [self makeCartView];
    [self makeAddCommentView];
    
    
    [self makeRequestCoupon];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    

    
   // [UIColor colorWithWhite:0.5f alpha:0.5f];
    
    // Do any additional setup after loading the view.
}


#pragma mark - 初始化优惠券

-(void)makeRequestCoupon{
    
    
    CGFloat viewWidth = SCREEN_WIDTH-120;
    CGFloat viewHeight = SCREEN_WIDTH-120+40;
    
    
    
    ShakeService *service = [ShakeService new];
    
    [service requestShakeCoupon:nil success:^(int code, NSString *message, id data) {
        
        
        if (code==0) {
            
            self.shakeCouponList = [data mutableCopy];
            
            self.couponData = self.shakeCouponList[0];
            
            
            [self.shakeCouponList removeObjectAtIndex:0];
            
            
            
            CouponView *couponView = [[CouponView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, (SCREEN_HEIGHT-viewHeight)/2, viewWidth, viewHeight) data:self.couponData];
            
            
            [self.view addSubview:couponView];
            
            
            self.imgView = couponView;
            
            
            
        }
        
        
        
    } failure:^(int code, BOOL retry, NSString *message, id data) {
        
    }];
    
    
    
    
    
    
}




#pragma mark - 抛物线轨迹
- (void)beginThrowing:(UIView *)view
{
    
    
    ThrowLineTool *tool = [ThrowLineTool sharedTool];
    
    
    CGFloat startX = view.frame.origin.x*1.5f;//arc4random() % (NSInteger)CGRectGetWidth(self.frame);
    CGFloat startY = view.frame.origin.y;//CGRectGetHeight(self.frame);
    CGFloat endX = CGRectGetMidX(self.cartButton.frame) + 10;
    CGFloat endY = CGRectGetMidY(self.cartButton.frame);
    CGFloat height = 30;
    [tool throwObject:view
                 from:CGPointMake(startX, startY)
                   to:CGPointMake(endX, endY)
               height:height duration:0.5];
    
    
    
    tool.didFinishBlock = ^(){
        
        
       
       // return;
        
        
        
        
        
        
        
        
        
        
        [[AppShareData instance] addCouponToCart:self.couponData];
        
        [self updateCartNum];
        
        
        view.hidden = YES;
        
        [view removeFromSuperview];
        
      //  self.imgView = nil;
        
        
     
        if ([self.shakeCouponList count]==0) {
            
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
            
            
            [SVProgressHUD showInfoWithStatus:@"本轮优惠券已经完毕，请重新摇摇"];
            
            
            
            return ;
            
        }
        
        self.couponData = self.shakeCouponList[0];
        
        [self.shakeCouponList removeObjectAtIndex:0];
        
        CGFloat viewWidth = SCREEN_WIDTH-120;
        CGFloat viewHeight = SCREEN_WIDTH-120+40;
        
        CouponView *nextView = [[CouponView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, (SCREEN_HEIGHT-viewHeight)/2, viewWidth, viewHeight) data:self.couponData];
        
        
        
        
        
        [self.view addSubview:nextView];
        
        
        self.nextView = nextView;

        
        self.imgView = self.nextView;
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            CGRect r = self.imgView.frame;
            
            CGFloat x = (SCREEN_WIDTH-self.imgView.frame.size.width)/2;
            
            r.origin.x = x;
            
            self.imgView.frame = r;
            
            
            
            
            
        } completion:^(BOOL finished) {
            
            [self doAddAction];
            
            
            
        }];
        

        
        
        
        
        
        
    };
}


#pragma mark - 购物车视图
-(void)makeCartView{
    
    
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [cartButton setImage:[UIImage imageNamed:@"gocart.png"] forState:UIControlStateNormal];
    
    cartButton.frame = CGRectMake(SCREEN_WIDTH-100, 50, 60, 60);
    
    cartButton.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
    
    cartButton.clipsToBounds = YES;
    cartButton.layer.cornerRadius = 30;
    [self.view addSubview:cartButton];
    
    self.cartButton  = cartButton;
    
    [cartButton bk_addEventHandler:^(id sender) {
        
        
        [self dismissViewControllerAnimated:NO completion:^{
            
            
            BasketContainerViewCtrl *vc = [BasketContainerViewCtrl new];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.nav pushViewController:vc animated:YES];
            
            
        }];
        
        
        
      
        
        
        
        
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

#pragma mark - 修改购物车数字

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


#pragma mark - 额外相关的视图

-(void)makeAddCommentView{
    
    //加入
    
    
    
    self.placeHolderView = [UIView new];
    
    [self.view addSubview:self.placeHolderView];
    
    self.placeHolderView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.2f];
    
    
    [self.placeHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        
        make.width.equalTo(@(SCREEN_WIDTH-120));
        make.height.equalTo(@(SCREEN_WIDTH-120+40));
        
        
        
        
    }];
    
    
    
    
    
    
    
    //上滑实现
    
    UIImageView *upImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up.png"]];
    [self.view addSubview:upImageView1];
    
    [upImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.placeHolderView.mas_top).offset(-20);
       // make.bottom.equalTo(self.imgView.mas_top).offset(-20);
       // make.bottom.equalTo(couponView.).offset(-20);
        
        
    }];
    
    UIImageView *upImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up.png"]];
    [self.view addSubview:upImageView2];
    
    [upImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.view);
        
        
        make.top.equalTo(upImageView1.mas_bottom).offset(-15);
        
        
    }];
    
    
    
    UILabel *upLabel = [UILabel new];
    
    [self.view addSubview:upLabel];
    
    upLabel.font = [UIFont boldSystemFontOfSize:14];
    upLabel.textColor = [UIColor whiteColor];
    [upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(upImageView2.mas_right).offset(10);
        make.centerY.equalTo(upImageView2).offset(-5);
        
        
    }];
    
    upLabel.text=@"收了";
    
    
    //下滑提示
    
    UIImageView *downImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
    [self.view addSubview:downImageView1];
    
    [downImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.view);
        //距离滑动视图 20个像素
        make.top.equalTo(self.placeHolderView.mas_bottom).offset(10);
        
        
    }];
    
    
    UIImageView *downImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down.png"]];
    [self.view addSubview:downImageView2];
    
    [downImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.view);
        make.top.equalTo(downImageView1.mas_bottom).offset(-15);
        
        
    }];
    
    
    UILabel *downLabel = [UILabel new];
    
    [self.view addSubview:downLabel];
    
    downLabel.font = [UIFont boldSystemFontOfSize:14];
    downLabel.textColor = [UIColor whiteColor];
    [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(downImageView2.mas_right).offset(10);
        make.centerY.equalTo(downImageView2).offset(-5);
        
        
    }];
    
    downLabel.text=@"扔了";
    
    

    
    
    
    

    
    
    
    
}

#pragma mark - 准备新的视图


-(void)makeNextView{
    
    
    
    CGFloat viewWidth = SCREEN_WIDTH-120;
    CGFloat viewHeight = SCREEN_WIDTH-120+40;
    
    
    
    
    if ([self.shakeCouponList count]==0) {
        
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        
        
        [SVProgressHUD showInfoWithStatus:@"本轮优惠券已经完毕，请重新摇摇"];
        
        
        
        return ;
        
    }
    
   
    
    self.couponData = self.shakeCouponList[0];
    
    [self.shakeCouponList removeObjectAtIndex:0];
    
    CouponView *nextView = [[CouponView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, (SCREEN_HEIGHT-viewHeight)/2, viewWidth, viewHeight) data:self.couponData];
    
    
    
    [self.view addSubview:nextView];
    
    
    self.nextView = nextView;
    
    
    
    
    
}





#pragma mark - 滑动手势出发
-(void)doSwipe:(UISwipeGestureRecognizer*)rg{
    
    if (rg.direction == UISwipeGestureRecognizerDirectionUp){
        
        
        
        
        [self beginThrowing:rg.view];
        
        
        
        
        
   
        
        
        NSLog(@"up");
        
        
        
    }
    
    if (rg.direction == UISwipeGestureRecognizerDirectionDown){
        
        
        
        [self animationSwipeDown];
        
        
        
        NSLog(@"down");
        
        
        
        
    }
    
    
    if (rg.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self animationSwipeLeft];
    }
    
    
    
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    

    
    
}


-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
    
    
    [self doAddAction];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        
        CGRect r = self.imgView.frame;
        
        CGFloat x = (SCREEN_WIDTH-self.imgView.frame.size.width)/2;
        
        r.origin.x = x;
        
        self.imgView.frame = r;

        
        
        
        
        
    
    
    } completion:^(BOOL finished) {
        
        
    }];

    
    
    
    
    
    
    
    
    
    
}

#pragma mark - 优惠券展现完毕后，增加手势
-(void)doAddAction{
    
    self.imgView.userInteractionEnabled = YES;
    
    [self.imgView removeGestureRecognizer:self.tapCouponRG];
    
    [self.imgView addGestureRecognizer:self.tapCouponRG];
    
    [self.imgView removeGestureRecognizer:self.swipeUpCouponRG];
    
    [self.imgView addGestureRecognizer:self.swipeUpCouponRG];
    
 
    [self.imgView removeGestureRecognizer:self.swipeDownCouponRG];
    
    [self.imgView addGestureRecognizer:self.swipeDownCouponRG];
    
    
    //[self.imgView removeGestureRecognizer:self.swipeLeftCouponRG];
    
   // [self.imgView addGestureRecognizer:self.swipeLeftCouponRG];
    
    
}







-(void)animationSwipeUp{
    
    
    
    
    [self makeNextView];

    
    
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        
        CGRect r = self.nextView.frame;
        
        CGFloat x = (SCREEN_WIDTH-self.nextView.frame.size.width)/2;
        
        r.origin.x = x;
        
        
        self.nextView.frame = r;
        
        
        
        CGRect rr = self.imgView.frame;
        
        CGFloat yy = self.imgView.frame.size.width*-2.0f;
        
        
        
        
        
       // self.imgView.alpha=0.0f;
        
        rr.origin.y = yy;
//        rr.size.width=0;
//        
//        rr.size.height=0;
//        
        
        self.imgView.frame = rr;
        
        
        
        
    } completion:^(BOOL finished) {
        
        
        [self.imgView removeFromSuperview];
        
        self.imgView = nil;
        
        self.imgView = self.nextView;
        
        [self doAddAction];
        
        
    }];
    
    
    
    

    
    
    
    
}

-(void)animationSwipeDown{
    
    
    [self makeNextView];
   
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        
        
        CGRect r = self.nextView.frame;
        
        CGFloat x = (SCREEN_WIDTH-self.nextView.frame.size.width)/2;
        
        r.origin.x = x;
        
        
        self.nextView.frame = r;
        
        
        
        
        
        CGRect rr = self.imgView.frame;
        
        CGFloat yy = SCREEN_WIDTH*1.5;
        
       // self.imgView.alpha=0.0f;
        
        
        
        rr.origin.y = yy;
        rr.origin.x = rr.origin.x+SCREEN_WIDTH/5;
        self.imgView.frame = rr;
        
        self.imgView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        
        
        
        
        
    } completion:^(BOOL finished) {
        
        
        [self.imgView removeFromSuperview];
        
        self.imgView = nil;
        
        self.imgView = self.nextView;
        
        [self doAddAction];
        
        [Utils incCoupon];
        
    }];
    
    
    
    
    
}

-(void)animationSwipeLeft{
    
    
    [self makeNextView];
   
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        
        CGRect r = self.nextView.frame;
        
        CGFloat x = (SCREEN_WIDTH-self.nextView.frame.size.width)/2;
        
        r.origin.x = x;
        
        
        self.nextView.frame = r;
        
        
        
        CGRect rr = self.imgView.frame;
        
        CGFloat xx = self.imgView.frame.size.width*-2.0f;
        
        rr.origin.x = xx;
        
        
        self.imgView.frame = rr;
        
        
        
        
    } completion:^(BOOL finished) {
        
        
        [self.imgView removeFromSuperview];
        
        self.imgView = nil;
        
        self.imgView = self.nextView;
        
        [self doAddAction];
        
        
        
    }];
    
    
    
    
    
    
    
    
    
    
}




- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    [super motionEnded:motion withEvent:event];
    
    
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake){
        
        
        [self animationSwipeLeft];
        
        
//        CouponView *nextView =[[CouponView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, (SCREEN_HEIGHT-240)/2, 200, 240) data:nil];
//        
//        
//        
//        [self.view addSubview:nextView];
//        
//        
//        self.nextView = nextView;
//        
//        
//        
//        
//        
//        [UIView animateWithDuration:0.5 animations:^{
//        
//            
//            
//            CGRect r = self.nextView.frame;
//            
//            CGFloat x = (SCREEN_WIDTH-self.nextView.frame.size.width)/2;
//            
//            r.origin.x = x;
//            
//            
//            self.nextView.frame = r;
//            
//            
//   
//            CGRect rr = self.imgView.frame;
//            
//            CGFloat xx = self.imgView.frame.size.width*-2.0f;
//            
//            rr.origin.x = xx;
//            
//            
//            self.imgView.frame = rr;
//            
//            
//            
//            
//        } completion:^(BOOL finished) {
//            
//            
//            [self.imgView removeFromSuperview];
//            
//            self.imgView = nil;
//            
//            self.imgView = self.nextView;
//            
//            [self doAddAction];
//            
//            
//            
//        }];
//        
        
        

        
        
        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        NSLog(@" subview  shake ...");
        
    }
}


-(void)doTapCoupon:(id)sender{
    
    
    
    
    
    
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        CouponDetailViewCtrl *vc =  [CouponDetailViewCtrl new];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.nav pushViewController:vc animated:YES];
        
    }];
    
    
    
    
    
}




-(void)doTap:(id)sender{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
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
