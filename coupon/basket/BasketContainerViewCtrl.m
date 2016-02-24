//
//  BasketContainerViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/30.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "BasketContainerViewCtrl.h"
#import "MHTabBarController.h"
#import "BasketNoPayViewCtrl.h"
#import "BasketNoUseViewCtrl.h"
#import "BasketFinishViewCtrl.h"
#import "BasketMessageViewCtrl.h"





@interface BasketContainerViewCtrl ()

@property(nonatomic,strong)MHTabBarController *headTabBar;


@end

@implementation BasketContainerViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headTabBar = [[MHTabBarController alloc] init];
    self.headTabBar.activeTitleColor = [GUIConfig mainColor];
    self.headTabBar.inactiveTitleColor = [GUIConfig mainColor];
    self.headTabBar.barBackgroundColor = [UIColor whiteColor];
    
    
    
    
    BasketNoPayViewCtrl *noPayVc = [BasketNoPayViewCtrl new];
    noPayVc.title=@"待支付";
    
    BasketNoUseViewCtrl *noUseVc = [BasketNoUseViewCtrl new];
    
    noUseVc.title=@"未使用";
    BasketFinishViewCtrl *finishedVc = [BasketFinishViewCtrl new];
    
    finishedVc.title=@"已消费";
    
    self.headTabBar.viewControllers = @[noPayVc, noUseVc, finishedVc];
    self.headTabBar.selectedViewController = noPayVc;
    
    
    
    CGRect frame = self.view.frame;
    
    
    frame.size.height -= 64;
    frame.origin.y =64;
    //
    self.headTabBar.view.frame = frame;
    
    self.navigationItem.title=@"篮子";
    
    
    [self addChildViewController:self.headTabBar];
    [self.view addSubview:self.headTabBar.view];
    
    
    [self.headTabBar didMoveToParentViewController:self];
    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"message_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        BasketMessageViewCtrl *vc =[BasketMessageViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    self.navigationItem.rightBarButtonItem=rightBarButton;

    
    
    
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
