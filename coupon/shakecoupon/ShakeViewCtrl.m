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
@interface ShakeViewCtrl ()

@property(nonatomic,strong)UIScrollView *contentView;


@end

@implementation ShakeViewCtrl


-(void)viewDidLoad{
    [super viewDidLoad];
    
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
    
    [self makeBarItem];
    
    [self makeShakeBody];
    
    
    
    
    
    
    

    
   // [self.contentView addSubview:[self makeView]];
    

    
    
    
  //  [self makeBody];
    
    
    
    
}


#pragma mark - 动画小图标
-(void)makeAnimateView:(UIView*)shakeLogo parentView:(UIView*)parentView{
    
    
    NSArray *paths = @[[[NSBundle mainBundle] pathForResource:@"animation001@2x" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation002@2x" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation003@2x" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation001@2x" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation002@2x" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation003@2x" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation001@2x" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation002@2x" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation003@2x" ofType:@"png"],
                       [[NSBundle mainBundle] pathForResource:@"animation001@2x" ofType:@"png"]];
    NSArray *times = @[@0.1, @0.1, @.1,@.1,@0.1,@0.1,@0.1, @0.1, @.1,@1.0];
    
    UIImage *image = [[YYFrameImage alloc] initWithImagePaths:paths frameDurations:times loopCount:0];
    
    
    UIImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    
    [parentView addSubview:imageView];
    
    
    
   // CGFloat FrameHeight = self.view.frame.size.height-[GUIConfig tabBarHeight];
    
    CGRect r = imageView.frame;
    r.origin.x = SCREEN_WIDTH/2+60;
    r.origin.y = shakeLogo.frame.origin.y+shakeLogo.frame.size.height;
    r.size.width = r.size.width/2;
    
    r.size.height = r.size.height/2;
    
    
    imageView.frame = r;
    
    
    [parentView addSubview:imageView];
    //imageView.frame = CGRectMake(SCREEN_WIDTH/2, FrameHeight/2,150 ,150);
        
    
    
    
    
    
}

#pragma mark - 摇一摇主图片
-(void)makeShakeBody{
    
    CGFloat FrameHeight = self.view.frame.size.height-[GUIConfig tabBarHeight];
    

    
    
    NSArray *ary = @[@"sampleImg01.png",@"sampleImg02.png",@"sampleImg03.png",@"sampleImg04.png"];
    
    
    
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
            
            
            [self doLoadShakeView];
            
            
        }];
        
        [imgView addGestureRecognizer:rg];
        
        
        CGRect r = imgView.frame;
        
        r.origin.x = x;
        r.origin.y = y;
        
        imgView.frame = r;
        
        [uv addSubview:imgView];
        
        [self.contentView addSubview:uv];
        
        
        
        
        [self makeAnimateView:imgView parentView:uv];
        
        
        
        
        
        
        
        
        
        
        
        
        
        //   uv.layer.borderWidth=2;
        
        pos++;
        
        
        
        
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
    
    
    UIBarButtonItem *scanerBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"scanner_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
    }];
    
    
    
    self.navigationItem.leftBarButtonItems = @[addressBarItem,addressNameBarItem];
    
    self.navigationItem.rightBarButtonItem = scanerBarItem;
    
    
    
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeSystem];
    headButton.frame = CGRectMake(0, 0, 200, 44);
    [headButton setTitle:@"正佳广场(1km)" forState:UIControlStateNormal];
    headButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    
    self.navigationItem.titleView = headButton;
    
    
    [headButton bk_addEventHandler:^(id sender) {
        
        SelectMallTableCtrl *vc = [SelectMallTableCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

#pragma mark - 主视图
/**
 
 已经废弃
 
 */

-(UIView*)makeView{
    
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handbg.png"]];
    
    bgView.frame = CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height);
    
    
    UIImageView *handView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hand.png"]];
    
    [bgView addSubview:handView];
    
    [handView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(bgView);
    }];
    
    
    UILabel *lab1 = [UILabel new];
    lab1.font = [UIFont boldSystemFontOfSize:20];
    lab1.textColor = [GUIConfig grayFontColorDeep];
    lab1.text=@"随时随地";
    
    [bgView addSubview:lab1];
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(bgView.mas_top).offset(-40);
      //  make.right.equalTo(self.view).multipliedBy(0.5);
        make.left.equalTo(@20);
        
        
    }];
    
    lab1.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel *lab2 = [UILabel new];
    lab2.font = [UIFont boldSystemFontOfSize:20];
    lab2.textColor = [GUIConfig grayFontColorDeep];
    lab2.text=@"想摇就摇";
    
    [bgView addSubview:lab2];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(bgView.mas_top).offset(-20);
      //  make.right.equalTo(self.view);
        make.left.equalTo(@(SCREEN_WIDTH/2));
        //make.left.equalTo(self.view);
        
        
    }];
    
    lab2.textAlignment = NSTextAlignmentCenter;
    
    
    return bgView;
    
    

    
    
    
    
    
}

#pragma mark - 摇换的界面


-(void)makeBody{
    
    

    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handbg.png"]];
    
    [self.contentView addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).offset(-20);
        
  
    
    }];
    
    
    UIImageView *handView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hand.png"]];
    
    [bgView addSubview:handView];
    
    [handView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(bgView);
    }];
    
    
    UILabel *lab1 = [UILabel new];
    lab1.font = [UIFont boldSystemFontOfSize:20];
    lab1.textColor = [GUIConfig grayFontColorDeep];
    lab1.text=@"随时随地";
    
    [self.view addSubview:lab1];
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(bgView.mas_top).offset(-40);
        make.right.equalTo(self.view).multipliedBy(0.5);
        make.left.equalTo(@20);
        
        
    }];
    
    lab1.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel *lab2 = [UILabel new];
    lab2.font = [UIFont boldSystemFontOfSize:20];
    lab2.textColor = [GUIConfig grayFontColorDeep];
    lab2.text=@"想摇就摇";
    
    [self.view addSubview:lab2];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(bgView.mas_top).offset(-20);
        make.right.equalTo(self.view);
        make.left.equalTo(@(SCREEN_WIDTH/2));
        //make.left.equalTo(self.view);
        
        
    }];
    
    lab2.textAlignment = NSTextAlignmentCenter;
    
   
     
    
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 装载摇一摇控制器
-(void)doLoadShakeView{
    
    ShakeCouponViewCtrl *vc = [ShakeCouponViewCtrl new];
    
    vc.nav = self.navigationController;
    
    
    
    
    self.definesPresentationContext = NO; //self is presenting view controller
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        
        vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }else{
        
        self.modalPresentationStyle=UIModalPresentationCurrentContext;
        
    }
    
    
    
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:^{
        
    }];
    
    
    

    
    
    
    
}

#pragma mark - 摇动感应器触发

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    [super motionEnded:motion withEvent:event];

    
        if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake){
            
            
            
            [self doLoadShakeView];
            
            
        
        }
 }



@end
