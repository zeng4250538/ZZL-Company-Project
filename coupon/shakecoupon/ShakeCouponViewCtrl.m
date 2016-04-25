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
#import "BasketService.h"



#define CouponWidth  (SCREEN_WIDTH-60)
#define CouponHeight  (SCREEN_WIDTH-60)





@interface ShakeCouponViewCtrl ()

@property(nonatomic,strong)CouponView *imgView;
@property(nonatomic,strong)CouponView *nextView;
@property(nonatomic,strong)NSDictionary *currentData;
@property(nonatomic,strong)UITapGestureRecognizer *tapCouponRG;
@property(nonatomic,strong)UIButton *cartButton;
@property(nonatomic,strong)UILabel *cartNumLabel;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeUpCouponRG;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeDownCouponRG;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeLeftCouponRG;

@property(nonatomic,strong)NSDictionary *couponData;

@property(nonatomic,strong)NSMutableArray *shakeCouponList;

@property(nonatomic,strong)UIView *placeHolderView;

@property(nonatomic,strong)UIView *maskView;

@property(nonatomic,strong)UIImageView *leftMaskView;
@property(nonatomic,strong)UIImageView *rightMaskView;


@property(nonatomic,assign)BOOL isFirstIn;






@end

@implementation ShakeCouponViewCtrl






- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor =[UIColor colorWithWhite:0.1f alpha:0.0f];
    
    self.isFirstIn = YES;
    
    
    
    
    
    
    //制作遮罩
    
    
   // [UIColor colorWithWhite:0.5f alpha:0.5f];
    
    // Do any additional setup after loading the view.
    
    
    [self makeRecognizer];
    
    [self animationDidStart];
}


#pragma mark - 手势定义

-(void)makeRecognizer{
    
    
    //
    
    UITapGestureRecognizer *rg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    
    [self.view addGestureRecognizer:rg];
    
    
    
    //点击优惠券
    self.tapCouponRG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapCoupon:)];
    
    //上滑
    self.swipeUpCouponRG = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(doSwipeUp:)];
    
    self.swipeUpCouponRG.direction = UISwipeGestureRecognizerDirectionUp;
    
    
    //下滑
    self.swipeDownCouponRG = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(doSwipeDown:)];
    
    self.swipeDownCouponRG.direction = UISwipeGestureRecognizerDirectionDown;
    
    
    
    
}

#pragma mark - 动画开始

-(void)animationDidStart{
    
    
    
    [self makeMaskCircleView];
    
    
    
    
}

#pragma mar - 将优惠券添加到篮子里面


- (void)addCouponToBasket:(void(^)(BOOL ret))completion{
    
    
     BasketService * service  = [BasketService new];
    
    
    NSString *couponId = self.couponData[@"id"];
    
    [service requestADDBasket:couponId count:1 success:^(NSInteger code, NSString *message, id data) {
        
        
        
        [[AppShareData instance] addCouponToCart:self.currentData];
        
        
        completion(YES);
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        completion(NO);
        
        
        [SVProgressHUD showErrorWithStatus:@"加入篮子失败"];
        
        
        
    }];
   
}


#pragma mark ------------------------- 抛物线轨迹
- (void)addBasketWithAnimation:(UIView *)view{
    
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
        
        
        view.hidden = YES;
        
        [view removeFromSuperview];
        
        
        __weak id weakSelf =self;
        
        [self addCouponToBasket:^(BOOL ret){
            
            if (ret) {
                [weakSelf updateCartNum];
                
            }
            
        }];
        
        
        
        
        
        
      //  self.imgView = nil;
     
        self.couponData = [[AppShareData instance].shakeCouponQueue next];
        
        if (self.couponData==nil) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
            [SVProgressHUD showInfoWithStatus:@"本轮优惠券已经完毕，请重新摇摇"];
            return ;
        }
        
        
        
        
        
        
        
        CouponView *nextView = [[CouponView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, (SCREEN_HEIGHT-CouponHeight)/2, CouponWidth, CouponHeight) data:self.couponData];
        
        
        
        
        
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
    
    
    [cartButton setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
    
    cartButton.frame = CGRectMake(SCREEN_WIDTH-100, 50, 60, 60);
    
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
        
        make.left.equalTo(cartButton.mas_right).offset(-15);
        make.top.equalTo(cartButton.mas_top).offset(12);
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
    
    
    self.placeHolderView = [UIView new];
    
    [self.view addSubview:self.placeHolderView];
    
    self.placeHolderView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.0f];
    
    
    [self.placeHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        
        make.width.equalTo(@(CouponWidth));
        make.height.equalTo(@(CouponHeight));
        
        
    }];
    
    
    
    
    
    
    
    //上滑实现
    
    UIImageView *upImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up.png"]];
    [self.view addSubview:upImageView1];
    
    [upImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.placeHolderView.mas_top).offset(-20);
        //make.bottom.equalTo(self.imgView.mas_top).offset(-20);
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
    
    
    UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:upButton];

    [upButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.placeHolderView.mas_top).offset(-60);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@60);
        
        
        
    }];
    
    
//    upButton.layer.borderWidth=1;
//    upButton.layer.borderColor = [[UIColor redColor] CGColor];
    
    
    [upButton bk_addEventHandler:^(id sender) {
        
        
        
        
        [self addBasketWithAnimation:self.imgView];

        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UILabel *upLabel = [UILabel new];
    
    [self.view addSubview:upLabel];
    
    upLabel.font = [UIFont boldSystemFontOfSize:14];
    upLabel.textColor = [UIColor whiteColor];
    [upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(upImageView1.mas_right).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        make.centerY.equalTo(upImageView1).offset(10);
        
        
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
        
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        
        
        make.left.equalTo(downImageView1.mas_right).offset(10);
        make.centerY.equalTo(downImageView1).offset(5);
        
        
    }];
    
    downLabel.text=@"扔了";
    
    
    UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:downButton];
    
    [downButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.placeHolderView.mas_bottom);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@60);
        
        
        
    }];
    
    
//    downButton.layer.borderWidth=1;
//    downButton.layer.borderColor = [[UIColor redColor] CGColor];
//    
    
    [downButton bk_addEventHandler:^(id sender) {
        
        
        
        
        [self doSwipeDown:nil];
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
 
  
    
}


#pragma mark - 准备新的视图
-(void)makeNextView{
    
//    CGFloat viewWidth = SCREEN_WIDTH-120;
//    CGFloat viewHeight = SCREEN_WIDTH-120+40;
//    
    self.couponData = [[AppShareData instance].shakeCouponQueue next];
    
    
    //无法获取新的优惠券
    if (self.couponData==nil) {
        
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        
        
        [SVProgressHUD showInfoWithStatus:@"本轮优惠券已经完毕，请重新摇摇"];
        
        
        
        return ;
        
    }
    
    [self.shakeCouponList removeObjectAtIndex:0];
    
    CouponView *nextView = [[CouponView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, (SCREEN_HEIGHT-CouponHeight)/2, CouponWidth, CouponHeight) data:self.couponData];
    
    
    
    [self.view addSubview:nextView];
    
    
    self.nextView = nextView;
    
}



#pragma mark 建立屏蔽视图
-(void)makeMaskCircleView{
    
    
    UIView *maskView = [UIView new];
    
    
    [self.view addSubview:maskView];

    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-55);
        
        make.width.equalTo(@218);
        make.height.equalTo(@218);
        
    }];
    
    maskView.layer.cornerRadius = 109;
    maskView.clipsToBounds = YES;
    
    self.maskView = maskView;
    
    
    UIImageView *maskLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mask_left"]];
    
    UIImageView *maskRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mask_right"]];
    
    
    maskLeft.frame = CGRectMake(-109, 0, 109, 218);
    
    maskRight.frame = CGRectMake(109+109, 0, 109, 218);
    
    [self.maskView addSubview:maskLeft];
    
    [self.maskView addSubview:maskRight];
    
    
    self.leftMaskView = maskLeft;
    self.rightMaskView = maskRight;
    
      
    
    
    
    
}

#pragma mark - 圆形遮罩关闭

-(void)makeMaskCircleViewClose{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        self.leftMaskView.frame = CGRectMake(0, 0, 109, 218);
        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        self.rightMaskView.frame = CGRectMake(109, 0, 109, 218);
        
        
        
        
        
        
    } completion:^(BOOL finished) {
        
        
        
        NSDictionary *couponData = [[AppShareData instance].shakeCouponQueue next];
        
        self.couponData = couponData;
        
        if (couponData == nil) {
        
            
            UIAlertView *av = [[UIAlertView alloc] bk_initWithTitle:@"错误" message:@"当前无优惠券，请重新摇一摇"];
            
            [av bk_addButtonWithTitle:@"确认" handler:^{
                
                
                [av dismissWithClickedButtonIndex:0 animated:YES];
                
                
            }];
            
            [av show];
            
            return ;
            
        }
        
        
        
        
        CouponView *couponView = [[CouponView alloc] initWithFrame:CGRectMake(0, 0, CouponWidth, CouponHeight) data:couponData];
        
        self.currentData = couponData;
        
        self.imgView = couponView;
        
        
        
        [self.maskView addSubview:couponView];
        
        [self.maskView sendSubviewToBack:couponView];
        
        
        
        [self makeMaskCircleViewOpen];
        
        
    }];
    
    
    
    
    
    
    
}



-(void)makeMaskCircleViewOpen{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        self.leftMaskView.frame = CGRectMake(0-109, 0, 109, 218);
        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
 
    [UIView animateWithDuration:0.5 animations:^{
        
        
        self.rightMaskView.frame = CGRectMake(109+109, 0, 109, 218);
        
        
        
        
        
        
    } completion:^(BOOL finished) {
        
         [self makeCartView];
         [self makeAddCommentView];

        
        
        [self.rightMaskView removeFromSuperview];
        
        
        [self.imgView removeFromSuperview];
        
        
        CGFloat rate  = 0.9f;
        
        
        
        
        CouponView *couponView = [[CouponView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-CouponWidth*rate)/2,
                                                                              (SCREEN_HEIGHT-CouponHeight*rate)/2, CouponWidth*rate, CouponHeight*rate) data:self.currentData];
        
        
        
        [self.view addSubview:couponView];
        
        self.imgView = couponView;
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
           // self.view.alpha=0.5;
            
            self.view.backgroundColor =[UIColor colorWithWhite:0.1f alpha:0.7f];
            
            
            self.maskView.layer.cornerRadius=0;
            
            self.imgView.transform = CGAffineTransformScale(self.imgView.transform, 1.1, 1.1);
           
            
            
            
            
        } completion:^(BOOL finished) {
            
            [self doAddAction];
            
            
            
        }];
        
        
        
        
    }];
    


    
    
    
    
    
    
    
}



#pragma mark - 手势向上滑动

-(void)doSwipeUp:(UISwipeGestureRecognizer*)rg{
    
   // if (rg.direction == UISwipeGestureRecognizerDirectionUp){
        
        
        [self addBasketWithAnimation:rg.view];
        
    //}
    

    
    
}

#pragma mark - 手势向下滑动

-(void)doSwipeDown:(UISwipeGestureRecognizer*)rg{
    
    
        
        [self makeNextView];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect r = self.nextView.frame;
            
            CGFloat x = (SCREEN_WIDTH-self.nextView.frame.size.width)/2;
            
            r.origin.x = x;
            
            self.nextView.frame = r;
            
            CGRect rr = self.imgView.frame;
            
            CGFloat yy = SCREEN_WIDTH*1.5;
            
            
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

-(void)doSwipeLeft:(UISwipeGestureRecognizer*)rg{
    
    
    if (rg.direction == UISwipeGestureRecognizerDirectionLeft) {
        
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
    

    
    
    
    
    
}




-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  
}


-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
    //
    if (self.isFirstIn) {
        [self makeMaskCircleViewClose];
        
        self.isFirstIn = NO;

    }
    
   
   
    
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


////-(void)animationSwipeUp{
////    
////    [self makeNextView];
//// 
////    [UIView animateWithDuration:0.5 animations:^{
////        
////        
////        
////        CGRect r = self.nextView.frame;
////        
////        CGFloat x = (SCREEN_WIDTH-self.nextView.frame.size.width)/2;
////        
////        r.origin.x = x;
////        
////        
////        self.nextView.frame = r;
////        
////        
////        
////        CGRect rr = self.imgView.frame;
////        
////        CGFloat yy = self.imgView.frame.size.width*-2.0f;
////       
////        rr.origin.y = yy;
////        
////        self.imgView.frame = rr;
////        
////    } completion:^(BOOL finished) {
////        
////        
////        [self.imgView removeFromSuperview];
////        
////        self.imgView = nil;
////        
////        self.imgView = self.nextView;
////        
////        [self doAddAction];
////        
////        
////    }];
////    
////    
////    
////    
////
////    
////    
////    
////    
////}
////
//-(void)animationSwipeDown{
//   
//    [self makeNextView];
//   
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        CGRect r = self.nextView.frame;
//        
//        CGFloat x = (SCREEN_WIDTH-self.nextView.frame.size.width)/2;
//        
//        r.origin.x = x;
//       
//        self.nextView.frame = r;
//       
//        CGRect rr = self.imgView.frame;
//        
//        CGFloat yy = SCREEN_WIDTH*1.5;
//        
//       // self.imgView.alpha=0.0f;
//       
//        rr.origin.y = yy;
//        rr.origin.x = rr.origin.x+SCREEN_WIDTH/5;
//        self.imgView.frame = rr;
//        
//        self.imgView.transform = CGAffineTransformMakeScale(0.2, 0.2);
//        
//      
//    } completion:^(BOOL finished) {
//        
//        
//        [self.imgView removeFromSuperview];
//        
//        self.imgView = nil;
//        
//        self.imgView = self.nextView;
//        
//        [self doAddAction];
//        
//        [Utils incCoupon];
//        
//    }];
//   
//}
//

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

/**
 *  装载摇换数据
 *
 *  @param completion 完成后回调
 */

-(void)loadShakeData:(void(^)(BOOL ret))completion{
    
    
    ShakeService *service = [ShakeService new];
    
    NSString *customerId = [AppShareData instance].customId;
    NSString *mallId = [AppShareData instance].mallId;
    
    
  
    [service requestShakeCoupon:customerId shopMallId:mallId success:^(NSInteger code, NSString *message, id data) {
       
        [[AppShareData instance].shakeCouponQueue resetData:data];
        
        
        completion(YES);
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        if (code>=400 && code<500) {
            
            [SVProgressHUD showErrorWithStatus:@"无数据"];
            
        }
        
        if (code>=500) {
            
            [SVProgressHUD showErrorWithStatus:@"服务端错误"];
            
        }
        
       completion(NO);
        
        
        
    }];
}

    


/**
 *  摇一摇触发
 *
 *  @param motion
 *  @param event
 */

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    
    
    [Utils playShakeSound];
    
    
    [super motionEnded:motion withEvent:event];
    
    
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake){
        
       // -(void)loadShakeData:(void(^)(BOOL ret))completion{
            
            
        [self loadShakeData:^(BOOL ret) {
            
            if (ret) {
                
                [self animationSwipeLeft];
                
                return ;
                
            }
            
            UIAlertView *av = [[UIAlertView alloc] bk_initWithTitle:@"警告" message:@"获取优惠券失败,请重试获取"];
            
            
            [av bk_addButtonWithTitle:@"关闭" handler:^{
                
                [av dismissWithClickedButtonIndex:0 animated:YES];
                
            }];
            
            [av show];
            
        }];

        
        
        
        
    }
}



#pragma mark - 优惠券点击

-(void)doTapCoupon:(id)sender{
 
//    [self dismissViewControllerAnimated:NO completion:^{
    
        CouponDetailViewCtrl *vc =  [CouponDetailViewCtrl new];
        
        vc.data = self.couponData;
    
        vc.hidesBottomBarWhenPushed = YES;
    
    vc.couponDetailPushMode = CouponDetailPushModePresent;
    
    
    
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    nav.navigationBar.barTintColor = [GUIConfig mainColor];
    
    nav.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"关闭" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
    }];
    
        
    
    
    
    
    
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
        //[self.nav pushViewController:vc animated:YES];
        
 //   }];
    
}



#pragma mark - 点击退出
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
