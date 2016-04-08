//
//  ShakeViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShakeViewCtrl.h"
#import "ShakeCouponViewCtrl.h"
#import "SelectCityTableViewCtrl.h"
#import "SelectMallTableCtrl.h"
#import "SelectMallPopViewCtrl.h"
#import "SimpleAudioPlayer.h"
#import "MallService.h"
#import "ShakeService.h"
#import "AppShareData.h"

@interface ShakeViewCtrl ()

@property(nonatomic,strong)UIScrollView *contentView;
@property(nonatomic,assign)BOOL audioOn;
@property(nonatomic,strong)UIButton *mallButton;

@property(nonatomic,assign)BOOL isShakeDataLoaded;


@end

@implementation ShakeViewCtrl

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.isShakeDataLoaded = NO;
    
    [self makeContentView];
    
    [self makeBarItem];
    
    [self makeShakeBody];
    
    [self makeAudioControl];
    
    
    [self loadShakeData:^(BOOL ret){
        
        self.isShakeDataLoaded = ret;
    }];
    
    
}

#pragma mark - 请求定位数据
-(void)requestLocation{
    
    
    
    
}


/**
 *  请求当前的商场
 *
 *  @param completion 完成回调
 
 */
-(void)requestCurrentMall:(void(^)(id data))completion{
    
#pragma mark ------ 周边商城网络请求
    MallService *services = [[MallService alloc] init];
    [services queryMallByNear:@"广州" lon:113.333655 lat:23.138651 success:^(NSInteger code, NSString *message, id data) {
        
        
    
        if (data ==nil) {
            completion(nil);
            return ;
        }
        
        if (![data isKindOfClass:[NSArray class]]) {
            completion(nil);
            return ;
            
        }
        
        
        if([data count]<1){
            
            completion(nil);
            return ;
        }
        
        //获取第一个默认的商城
        completion(data[0]);
       // completion();
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
    }];
    
    
    
}


#pragma mark - 装载摇一摇优惠券数据

-(void)loadShakeData:(void(^)(BOOL ret))completion{
    
    
    ShakeService *service = [ShakeService new];
    
    
    NSString *customId = [AppShareData instance].customId;
    
    NSString *mallId = [AppShareData instance].mallId;
    
    [service requestShakeCoupon:customId shopMallId:mallId success:^(NSInteger code, NSString *message, id data) {
        
        self.isShakeDataLoaded = YES;
        
        [[AppShareData instance].shakeCouponQueue resetData:data];
        
        
        completion(YES);
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        [SVProgressHUD dismiss];
        
        completion(NO);
        
        
    }];
    
   
    
}

#pragma mark - 创建首页内容视图

-(void)makeContentView{
    
    
    self.view.backgroundColor = [GUIConfig grayFontColor];
    
    self.contentView = [UIScrollView new];
    
    [self.view addSubview:self.contentView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat FrameHeight = self.view.frame.size.height-[GUIConfig tabBarHeight];
    
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, FrameHeight);
    
    //暂时只用一个页面
    self.contentView.contentSize = CGSizeMake(self.view.frame.size.width, FrameHeight);
    
    self.contentView.pagingEnabled = YES;
    
    self.contentView.showsVerticalScrollIndicator = NO;
    
    
    
    
    
}


#pragma mark - 声音图标

-(void)makeAudioControl{
    
    
    self.audioOn = YES;
    
    UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:audioButton];
    [audioButton setImage:[UIImage imageNamed:@"soundon"] forState:UIControlStateNormal];
    
    [audioButton setImage:[UIImage imageNamed:@"soundoff"] forState:UIControlStateSelected];
    
    
    
    
    [audioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        
        
        
    }];
    
    
    [audioButton bk_addEventHandler:^(id sender) {
        
        
        
        audioButton.selected = !audioButton.selected;
        
        
        [[AppShareData instance] openAudio:!audioButton.selected];
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:audioButton];
    
    
    
    
}


#pragma mark - 动画小图标
-(void)makeAnimateView:(UIView*)shakeLogo parentView:(UIView*)parentView{
    
    
    NSArray *paths = @[[[NSBundle mainBundle] pathForResource:@"animation_01" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_02" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_03" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_04" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_05" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_06" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_07" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_08" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_09" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_10" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_11" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation_12" ofType:@"png"]
                       
                       ];
    NSArray *times = @[@0.08, @0.08, @.08,@.08,@0.08,@0.08,@0.08, @0.08, @.08,@0.08,@0.08,@0.08];
    
    UIImage *image = [[YYFrameImage alloc] initWithImagePaths:paths frameDurations:times loopCount:0];
    
    
    UIImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    
    [parentView addSubview:imageView];
    
    [parentView addSubview:imageView];

    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(parentView).offset(100);
        make.centerY.equalTo(parentView).offset(130);
        make.width.equalTo(@(220/3));
        make.height.equalTo(@(370/3));

    }];
    
    
    
    
}

#pragma mark - 摇一摇主图片

/**
 *  摇换主界面，
 */
-(void)makeShakeBody{
    
    
    CGFloat FrameHeight = self.view.frame.size.height-[GUIConfig tabBarHeight];
    
    NSArray *ary = @[@"sampleImg010.png"];
   
    int pos=0;
    
    for (NSString *content in ary) {
       
        UIView *uv = [UIView new];
        uv.backgroundColor =[GUIConfig mainBackgroundColor];
        
        NSString *imgFile = content;
        
        uv.frame = CGRectMake(0, pos*FrameHeight, SCREEN_WIDTH,FrameHeight);
       
        UIImage *img = [UIImage imageNamed:imgFile];
       
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];

        CGFloat x = (uv.frame.size.width - imgView.frame.size.width)/2;
        CGFloat y = (uv.frame.size.height - imgView.frame.size.height)/2;

        imgView.userInteractionEnabled = YES;
       
        UITapGestureRecognizer *rg = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
           
           
            
        }];
        
        [imgView addGestureRecognizer:rg];

        CGRect r = imgView.frame;

        r.origin.x = x;
        r.origin.y = y;

        imgView.frame = r;
        
        [self.contentView addSubview:uv];
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,FrameHeight)];
        
        bgView.image = [UIImage imageNamed:@"mainpagebg"];
        
        [uv addSubview:bgView];
        
        UIImageView *ballView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guangzhoufood"]];
        
        [uv addSubview:ballView];
        
        [ballView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(uv);
            make.centerY.equalTo(uv).offset(-30);
            
        }];
       
        [self makeAnimateView:imgView parentView:uv];
        
        
    }

}


#pragma mark- 导航栏按钮

-(void)makeBarItem{
    
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    
    UIBarButtonItem *addressBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"location_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
     
        
        SelectCityTableViewCtrl *vc = [SelectCityTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
   
    UIBarButtonItem *addressNameBarItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"广州" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        SelectCityTableViewCtrl *vc = [SelectCityTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
//    UIBarButtonItem *scanerBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"scanner_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
//        
//    }];
   
    self.navigationItem.leftBarButtonItems = @[addressBarItem,addressNameBarItem];
    
  //  self.navigationItem.rightBarButtonItem = scanerBarItem;
    
    
    UIButton *mallButton = [UIButton buttonWithType:UIButtonTypeSystem];
    mallButton.frame = CGRectMake(0, 0, 100, 44);
    [mallButton setTitle:@"选择商城" forState:UIControlStateNormal];
    mallButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];

    
    [self requestCurrentMall:^(id data) {
        
        NSString *mallId = SafeString(data[@"id"]);
        
        //存储为当前的mallid
        
        [[AppShareData instance] saveMallId:mallId];
        
        
        [mallButton setTitle:SafeString(data[@"name"]) forState:UIControlStateNormal];
    }];
    
    self.mallButton =mallButton;
    
    
    self.navigationItem.titleView = mallButton;
    
    
    
    [mallButton bk_addEventHandler:^(id sender) {
        
        
        
        SelectMallPopViewCtrl *vc = [SelectMallPopViewCtrl new];
        
        [Utils popTransparentViewCtrl:self childViewCtrl:vc];
        
        vc.selectMallBlock = ^(BOOL ret ,NSDictionary *mall){
            
            
            NSString *name = [NSString stringWithFormat:@"%@(%@)",SafeString(mall[@"name"]),SafeString(mall[@"distance"])];
            
            
            
            [self.mallButton setTitle:name forState:UIControlStateNormal];
        };
      
    } forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 装载摇一摇控制器
-(void)doLoadShakeView{
    
    if ([AppShareData instance].isAudioOpen) {
        
            [SimpleAudioPlayer playFile:@"shake_sound_male1.mp3"  volume:1.0f loops:0 withCompletionBlock:^(BOOL finished) {
                // NSLog(@"Finished playing %");
                
            }];
        
    }
    
    ShakeCouponViewCtrl *vc = [ShakeCouponViewCtrl new];
    
    vc.nav = self.navigationController;
    
    self.definesPresentationContext = NO; //self is presenting view controller
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        
        vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }
    
    else{
        
        self.modalPresentationStyle=UIModalPresentationCurrentContext;
        
    }
   
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:^{
        
    }];
    
}



#pragma mark ------------------------------ 摇动感应器触发
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    [super motionEnded:motion withEvent:event];

    
        if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake){
    
            [self loadShakeData:^(BOOL ret){
                
                if (ret) {
                    
                    [self doLoadShakeView];
                    
                }else{
                    
                    [SVProgressHUD showErrorWithStatus:@"网络错误，请重试！"];
                    
                }
                
            }];
       
        }
 }



@end
