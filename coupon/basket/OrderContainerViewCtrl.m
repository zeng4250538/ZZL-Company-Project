//
//  OrderContainerViewCtrl.m
//  coupon
//
//  Created by chijr on 16/3/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "OrderContainerViewCtrl.h"

#import "BasketContainerViewCtrl.h"
#import "MHTabBarController.h"
#import "BasketNoPayViewCtrl.h"
#import "BasketNotUseViewCtrl.h"
#import "BasketFinishViewCtrl.h"
#import "BasketMessageViewCtrl.h"


@interface OrderContainerViewCtrl ()

@property(nonatomic,strong)MHTabBarController *headTabBar;


@end

@implementation OrderContainerViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    
    self.headTabBar = [[MHTabBarController alloc] init];
    self.headTabBar.activeTitleColor = [GUIConfig mainColor];
    self.headTabBar.inactiveTitleColor = [GUIConfig mainColor];
    self.headTabBar.barBackgroundColor = [UIColor whiteColor];
    
    
    
    
    BasketNotUseViewCtrl *noUseVc = [BasketNotUseViewCtrl new];
    
    noUseVc.title=@"未使用";
    BasketFinishViewCtrl *finishedVc = [BasketFinishViewCtrl new];
    
    finishedVc.title=@"已消费";
    
    self.headTabBar.viewControllers = @[noUseVc, finishedVc];
    self.headTabBar.selectedViewController = noUseVc;
    
    
    
    CGRect frame = self.view.frame;
    
    
    frame.size.height -= 64;
    frame.origin.y =64;
    //
    self.headTabBar.view.frame = frame;
    
    self.navigationItem.title=@"订单";
    
    
    [self addChildViewController:self.headTabBar];
    [self.view addSubview:self.headTabBar.view];
    
    
    [self.headTabBar didMoveToParentViewController:self];
    
    
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"message_icon.png"] style:UIBarButtonItemStylePlain handler:^(id sender) {
//        
//        
//        BasketMessageViewCtrl *vc =[BasketMessageViewCtrl new];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }];
//    
//    self.navigationItem.rightBarButtonItem=rightBarButton;
    
    
    
    

    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
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
