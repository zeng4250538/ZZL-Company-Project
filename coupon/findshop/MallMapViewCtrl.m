//
//  MallMapViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/5.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "MallMapViewCtrl.h"
#import "IndoorMapViewService.h"
@interface MallMapViewCtrl ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIImageView *mapImageView;

@end

@implementation MallMapViewCtrl

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [SVProgressHUD show];
    
    self.navigationItem.title=@"商场地图";
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self mapImageLayout];
    
    [self addGesture];
    
    [self loadData];
    
    
}

-(void)addGesture{

    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchClick:)];
    pinch.delegate = self;
    
    [_mapImageView addGestureRecognizer:pinch];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panClick:)];
    [_mapImageView addGestureRecognizer:pan];

}

-(void)panClick:(UIPanGestureRecognizer *)pan{

//    _mapImageView.center = [pan locationInView:self.view];
    
    
        CGPoint tran = [pan translationInView:self.view];
        pan.view.center = CGPointMake(pan.view.center.x + tran.x, pan.view.center.y + tran.y);
        [pan setTranslation:CGPointZero inView:self.view];
    
    

}

-(void)pinchClick:(UIPinchGestureRecognizer *)pinch{

    
    if (pinch.scale<1) {
        pinch.scale = 1;
    }
    _mapImageView.transform = CGAffineTransformMakeScale(pinch.scale, pinch.scale);
    
    
    
    
}

-(void)loadData{

    IndoorMapViewService *IMVS = [IndoorMapViewService new];
    [IMVS mapReqestSuccess:^(id data) {
        
        NSURL *url = data[0][@"mapPhotoUrl"];
        [_mapImageView sd_setImageWithURL:url];

        [SVProgressHUD dismiss];
    } withFailure:^(id data) {
        
    }];

}

-(void)mapImageLayout{

     _mapImageView = [[UIImageView alloc]init];
    [_mapImageView setUserInteractionEnabled:YES];
    _mapImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_mapImageView];

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
