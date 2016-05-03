//
//  GoToMapViewCtrl.h
//  coupon
//
//  Created by chijr on 16/4/22.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>









@interface GoToMapViewCtrl : UIViewController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic,strong)BMKPointAnnotation *currentPoint;
@property(nonatomic,assign)int flag;
@property(nonatomic,strong)BMKMapView *mapView;
@property(nonatomic,assign)BOOL isFirst;
@property(nonatomic,strong)BMKGeoCodeSearch *codeSearch;

@property(nonatomic,assign)CLLocationCoordinate2D endLocation;





@end
