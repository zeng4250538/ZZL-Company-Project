//
//  GoToMapViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/22.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "GoToMapViewCtrl.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}
@property (nonatomic) int type;
@property (nonatomic) int degree;

@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end


@interface GoToMapViewCtrl ()<CLLocationManagerDelegate,BMKMapViewDelegate,BMKRouteSearchDelegate,BMKLocationServiceDelegate>

@property (nonatomic, strong) CLLocationManager *lcManager;
@property(nonatomic,strong)BMKRouteSearch *searcher;
@property (nonatomic,assign)CLLocationCoordinate2D locals;
@property(nonatomic,strong)NSString *cityString;
@property(nonatomic,strong)BMKLocationService *locService;
@end

@implementation GoToMapViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"导航位置 - 步行";
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.desiredAccuracy = 0;
    //启动LocationService
    [_locService startUserLocationService];
    
    self.mapView = [[BMKMapView alloc] init];
    [self.view addSubview:self.mapView];
    [self buttonLayout];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        
        make.width.height.equalTo(self.view);
        
        
        
    }];
    
    _mapView.zoomLevel = 16;//地图显示比例
//
    _mapView.showMapScaleBar = YES;
//

//    
    _mapView.showMapPoi = YES;
    _mapView.zoomEnabled = YES;
    _mapView.delegate = self;
    
}

-(void)buttonLayout{

    UIButton *oneButton = [UIButton new];
    UIButton *twoButton = [UIButton new];
    UIButton *threeButton = [UIButton new];
    
    oneButton.frame = CGRectMake(30, 100, 30, 40);
    
    twoButton.frame = CGRectMake(30, 200, 30, 40);
    
    threeButton.frame = CGRectMake(30, 300, 30, 40);
    
    oneButton.backgroundColor = [UIColor whiteColor];
    twoButton.backgroundColor = [UIColor whiteColor];
    threeButton.backgroundColor = [UIColor whiteColor];
    
    oneButton.layer.cornerRadius = 3;
    twoButton.layer.cornerRadius = 3;
    threeButton.layer.cornerRadius = 3;
    
    oneButton.titleLabel.font = [UIFont systemFontOfSize:10];
    twoButton.titleLabel.font = [UIFont systemFontOfSize:10];
    threeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [oneButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [threeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [oneButton setTitle:@"驾车" forState:UIControlStateNormal];
    [twoButton setTitle:@"步行" forState:UIControlStateNormal];
    [threeButton setTitle:@"公交" forState:UIControlStateNormal];
    
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    [self.view addSubview:threeButton];
    
    //驾车
    [oneButton bk_addEventHandler:^(id sender) {
        
        self.navigationItem.title=@"导航位置 - 驾车";
        
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        
        BMKPlanNode* end = [[BMKPlanNode alloc]init];

        
        //起点
        CLLocationCoordinate2D asd;
        asd.latitude = _locals.latitude;
        asd.longitude = _locals.longitude;
        start.pt = asd;
        
        start.cityName = _cityString;
        end.cityName = _cityString;
        
        //终点
        end.pt = _endLocation;
        BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
        drivingRouteSearchOption.from = start;
        drivingRouteSearchOption.to = end;
        drivingRouteSearchOption.drivingRequestTrafficType = BMK_DRIVING_REQUEST_TRAFFICE_TYPE_NONE;//不获取路况信息
        BOOL flag = [_searcher drivingSearch:drivingRouteSearchOption];
        if(flag)
        {
            NSLog(@"car检索发送成功");
        }
        else
        {
            NSLog(@"car检索发送失败");
        }

        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [twoButton bk_addEventHandler:^(id sender) {
        
        self.navigationItem.title=@"导航位置 - 步行";
        
        //初始化检索对象
        _searcher = [[BMKRouteSearch alloc]init];
        _searcher.delegate = self;
        //发起检索
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        
        //起点
        CLLocationCoordinate2D asd;
        asd.latitude = _locals.latitude;
        asd.longitude = _locals.longitude;
        start.pt = asd;
        start.cityName = _cityString;
        end.cityName = _cityString;
    
        //终点
        end.pt = _endLocation;
        
        //（步行）
        BMKWalkingRoutePlanOption *walkingRoutePlanOption = [BMKWalkingRoutePlanOption new];
        //（步行）
        walkingRoutePlanOption.from = start;
        walkingRoutePlanOption.to = end;
        
        
        
        
        
        //（步行）
        BOOL flag = [_searcher walkingSearch:walkingRoutePlanOption];
        
        
        if(flag)
        {
            NSLog(@"bus检索发送成功");
        }
        else
        {
            NSLog(@"bus检索发送失败");
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [threeButton bk_addEventHandler:^(id sender) {
        
        self.navigationItem.title=@"导航位置 - 公交";
        
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        //起点
        CLLocationCoordinate2D asd;
        asd.latitude = _locals.latitude;
        asd.longitude = _locals.longitude;
        start.pt = asd;
        start.cityName = _cityString;
        end.cityName = _cityString;
        
        //终点
        end.pt = _endLocation;
        
        BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
        transitRouteSearchOption.city= @"北京市";
        transitRouteSearchOption.from = start;
        transitRouteSearchOption.to = end;
        BOOL flag = [_searcher transitSearch:transitRouteSearchOption];
        
        if(flag)
        {
            NSLog(@"bus检索发送成功");
        }
        else
        {
            NSLog(@"bus检索发送失败");
        }
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    


}

#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _codeSearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    [self requestLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        self.lcManager.distanceFilter = 1000;
        self.lcManager.desiredAccuracy = kCLLocationAccuracyBest; // 设置定位精度(精度越高越耗电)
        [self.lcManager startUpdatingLocation]; // 开始更新位置
        
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        [self.lcManager requestWhenInUseAuthorization];//⓵只在前台开启定位
        [self.lcManager requestAlwaysAuthorization];//⓶在后台也可定位
    }
    // 5.iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        //self.lcManager.allowsBackgroundLocationUpdates = YES;
    }
    
    
    
    //[self.lcManager startUpdatingLocation];
   
    
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    CLLocation *currentLocation = userLocation.location;
    [_locService stopUserLocationService];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    // 根据经纬度反向得出位置城市信息
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSString *city = placeMark.locality;
            
//            CGFloat lat = placeMark.location.coordinate.latitude;
            
            CGFloat lat = _locService.userLocation.location.coordinate.latitude;
            
//            CGFloat lon = placeMark.location.coordinate.longitude;
            
            CGFloat lon = _locService.userLocation.location.coordinate.longitude;
            
            BMKCoordinateRegion region ;//表示范围的结构体
            //
            //    float we = 0.012;
            //    self.endLocation.latitude == we;
            
            region.center =self.endLocation;
            
            region.center.latitude = lat;
            region.center.longitude = lon;
            
            _locals.latitude = lat;
            _locals.longitude = lon;
            
            NSLog(@"经度》》》----%f   纬度》》》----%f",lon,lat);
            
            
            [self locationWithLatitude:lat withLongitude:lon withCity:city];
            
            [self.mapView setRegion:region animated:YES];
            
            
            
        } else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error returned");
        } else if (error) {
            [iConsole error:@"定位出错 %@",error];
            
        }
    }];
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

-(void)locationWithLatitude:(CGFloat)latitudes withLongitude:(CGFloat)longitudes withCity:(NSString *)city{

    //初始化检索对象
    _searcher = [[BMKRouteSearch alloc]init];
    _searcher.delegate = self;
    //发起检索
    BMKPlanNode* start = [[BMKPlanNode alloc]init];

    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    
    //起点
    CLLocationCoordinate2D asd;
    asd.latitude = latitudes;
    asd.longitude = longitudes;
    start.pt = asd;
    start.cityName = city;
    end.cityName = city;
    _cityString = city;
    //终点
    end.pt = _endLocation;
    
    //（步行）
    BMKWalkingRoutePlanOption *walkingRoutePlanOption = [BMKWalkingRoutePlanOption new];
    //（步行）
    walkingRoutePlanOption.from = start;
    walkingRoutePlanOption.to = end;
    
    
    
    
    
    //（步行）
    BOOL flag = [_searcher walkingSearch:walkingRoutePlanOption];
    
    
    if(flag)
    {
        NSLog(@"bus检索发送成功");
    }
    else
    {
        NSLog(@"bus检索发送失败");
    }

}

#pragma mark - 私有

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        
        default:
            break;
    }
    
    return view;
}

- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.type = 3;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}



//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}

//不使用时将delegate设置为 nil（路径规划）
-(void)viewWillDisappear:(BOOL)animated
{
    _mapView.delegate = nil; // 不用时，置nil
    _codeSearch.delegate = nil; // 不用时，置nil
}


- (void)dealloc {
    if (_codeSearch != nil) {
        _codeSearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
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
