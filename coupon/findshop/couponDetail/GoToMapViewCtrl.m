//
//  GoToMapViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/22.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "GoToMapViewCtrl.h"

@interface GoToMapViewCtrl ()<CLLocationManagerDelegate,BMKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *lcManager;

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


/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"获取定位失败");
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向得出位置城市信息
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = placeMark.location.coordinate.latitude;
            coor.longitude = placeMark.location.coordinate.longitude;
            annotation.coordinate = coor;
            annotation.title = @"我在这里";
            [_mapView addAnnotation:annotation];
            
            //            SPVC.cityBlockView(self.city);
            
    
            
        } else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error returned");
        } else if (error) {
            [iConsole error:@"定位出错 %@",error];
            
        }
    }];
    
    [manager stopUpdatingLocation];
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
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
