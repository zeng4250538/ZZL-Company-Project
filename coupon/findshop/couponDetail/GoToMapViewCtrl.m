//
//  GoToMapViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/22.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "GoToMapViewCtrl.h"

@interface GoToMapViewCtrl ()


@end

@implementation GoToMapViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"导航位置";
    
    BMKCoordinateRegion region ;//表示范围的结构体
    
    CLLocationCoordinate2D l2d;
    l2d.latitude = 23.13055306224895;
    l2d.longitude=113.3219952545166;
    region.center =l2d;
    
    // {113.3021,23.2123};
    //        region.span.latitudeDelta = 0.1;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    //        region.span.longitudeDelta = 0.1;//纬度范围
    //
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 230)];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        
        make.width.height.equalTo(self.view);
        
        
        
    }];
    
    _mapView.zoomLevel = 16;//地图显示比例
    _mapView.rotateEnabled = NO; //设置是否可以旋转
    
    _mapView.showMapScaleBar = YES;
    
    //_mapView.baiduHeatMapEnabled = YES;
    
    _mapView.showMapPoi = YES;
    _mapView.zoomEnabled = YES;
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    BMKCoordinateRegion region ;//表示范围的结构体
    
    region.center =self.endLocation;
    
    [self.mapView setRegion:region animated:YES];
    
    
 //   [self.mapView setRegion:self.endLocation];
    
    
    
    
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
