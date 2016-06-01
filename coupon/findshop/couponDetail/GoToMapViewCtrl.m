//
//  GoToMapViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/22.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "GoToMapViewCtrl.h"

@interface GoToMapViewCtrl ()<CLLocationManagerDelegate,BMKMapViewDelegate,BMKRouteSearchDelegate>

@property (nonatomic, strong) CLLocationManager *lcManager;
@property(nonatomic,strong)BMKRouteSearch *searcher;

@end

@implementation GoToMapViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CLLocationManager *asd = [CLLocationManager new];
    
    
    self.navigationItem.title=@"导航位置";
    
//    BMKCoordinateRegion region ;//表示范围的结构体
    
//    CLLocationCoordinate2D l2d;
//    l2d.latitude = 23.13055306224895;
//    l2d.longitude=113.3219952545166;
//    region.center =l2d;
    
    // {113.3021,23.2123};
    //        region.span.latitudeDelta = 0.1;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    //        region.span.longitudeDelta = 0.1;//纬度范围
    //
    
    self.mapView = [[BMKMapView alloc] init];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        
        make.width.height.equalTo(self.view);
        
        
        
    }];
    
    _mapView.zoomLevel = 16;//地图显示比例
//    _mapView.rotateEnabled = NO; //设置是否可以旋转
//    
    _mapView.showMapScaleBar = YES;
//
//    //_mapView.baiduHeatMapEnabled = YES;
//    
    _mapView.showMapPoi = YES;
    _mapView.zoomEnabled = YES;
    _mapView.delegate = self;
    
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
//    BMKCoordinateRegion region ;//表示范围的结构体
////
////    float we = 0.012;
////    self.endLocation.latitude == we;
//    
//    region.center =self.endLocation;
//    
//    [self.mapView setRegion:region animated:YES];
    
    
 //   [self.mapView setRegion:self.endLocation];
    
    [self requestLocation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//暂时注释
/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"获取定位失败");
}

#pragma mark - 请求定位数据
-(void)requestLocation{
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        // 创建位置管理者对象
        self.lcManager = [[CLLocationManager alloc] init];
        self.lcManager.delegate = self; // 设置代理
        // 设置定位距离过滤参数 (当本次定位和上次定位之间的距离大于或等于这个值时，调用代理方法)
        self.lcManager.distanceFilter = 100;
        self.lcManager.desiredAccuracy = kCLLocationAccuracyBest; // 设置定位精度(精度越高越耗电)
        [self.lcManager startUpdatingLocation]; // 开始更新位置
        
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        [self.lcManager requestWhenInUseAuthorization];//⓵只在前台开启定位
        //[self.lcManager requestAlwaysAuthorization];//⓶在后台也可定位
    }
    // 5.iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        //self.lcManager.allowsBackgroundLocationUpdates = YES;
    }
    
    
    
    //[self.lcManager startUpdatingLocation];
   
    
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向得出位置城市信息
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
//            NSString *city = placeMark.locality;
            
            CGFloat lat = placeMark.location.coordinate.latitude;
            
            CGFloat lon = placeMark.location.coordinate.longitude;
            
            BMKCoordinateRegion region ;//表示范围的结构体
            //
            //    float we = 0.012;
            //    self.endLocation.latitude == we;
            
            region.center =self.endLocation;
            
            region.center.latitude = lat;
            region.center.longitude = lon;
            
            
            
            [self.mapView setRegion:region animated:YES];
            
        
            
        } else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error returned");
        } else if (error) {
            [iConsole error:@"定位出错 %@",error];
            
        }
    }];
    
    //[manager stopUpdatingLocation];
}


-(void)locationWithLatitude:(CGFloat)latitudes withLongitude:(CGFloat)longitudes withCity:(NSString *)city{

    //初始化检索对象
    _searcher = [[BMKRouteSearch alloc]init];
    _searcher.delegate = self;
    //发起检索
    BMKPlanNode* start = [[BMKPlanNode alloc]init];

    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    
    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
    transitRouteSearchOption.city= @"广州市";
    
    //（步行）
//    BMKWalkingRoutePlanOption *walkingRoutePlanOption = [BMKWalkingRoutePlanOption new];
    
    
    //起点
    CLLocationCoordinate2D asd;
    asd.latitude = latitudes;
    asd.longitude = longitudes;
    start.pt = asd;
    
    //终点
    end.pt = _endLocation;
    
    //（步行）
//    walkingRoutePlanOption.from = start;
//    walkingRoutePlanOption.to = end;
    
    start.name = @"南兴花园";
    end.name = @"景辉苑";
    
    transitRouteSearchOption.from= start;
    transitRouteSearchOption.to = end;
    
    
    
    //（步行）
//    BOOL flag = [_searcher walkingSearch:walkingRoutePlanOption];
    
    BOOL flag = [_searcher transitSearch:transitRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"bus检索发送成功");
    }
    else
    {
        NSLog(@"bus检索发送失败");
    }



}

//实现Deleage处理回调结果（路径规划）
-(void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:    (BMKTransitRouteResult*)result
                     errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        //当路线起终点有歧义时通，获取建议检索起终点
        //result.routeAddrResult
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

//不使用时将delegate设置为 nil（路径规划）
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
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
