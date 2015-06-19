//
//  MapPloylineViewController.m
//  Demo_iOS
//
//  Created by iStig on 15/6/2.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "MapPloylineViewController.h"
#import <MapKit/MapKit.h>
#import "SMAnnotation.h"
@interface MapPloylineViewController ()<MKMapViewDelegate>
@property (nonatomic, strong) MKMapView *map;
@property (nonatomic, strong) NSArray *pre;
@property (nonatomic, strong) NSArray *middle;
@property (nonatomic, strong) NSArray *end;
@property (nonatomic, strong) NSMutableArray *total;
@property (nonatomic, strong) NSMutableArray *use;
@end

@implementation MapPloylineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self data];
    [self setUpMap];
}


- (void)data {
//    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"EntranceToGoliathRoute" ofType:@"plist"];
//    NSArray *pointsArray = [NSArray arrayWithContentsOfFile:thePath];
//    
//    _use = [NSMutableArray new];
//    _pre = [NSMutableArray new];
//    _middle = [NSMutableArray new];
//    _end = [NSMutableArray new];
//    
//    [pointsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        CGPoint point = CGPointFromString(obj);
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        dic[@"lat"]= @(point.x);
//        dic[@"long"] = @(point.y);
//        [_use addObject:dic];
//    }];
}

- (void)addPloyline {
    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"EntranceToGoliathRoute" ofType:@"plist"];
    NSArray *pointsArray = [NSArray arrayWithContentsOfFile:thePath];
    NSInteger point2 = pointsArray.count/2;
    NSInteger restPoint = pointsArray.count-point2;
    CLLocationCoordinate2D *pointsToUse;
    pointsToUse = malloc(sizeof(CLLocationCoordinate2D)*point2);
    
    CLLocationCoordinate2D *pointsToUse2;
    pointsToUse2 = malloc(sizeof(CLLocationCoordinate2D)*restPoint);
    
    [pointsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGPoint point = CGPointFromString(pointsArray[idx]);
        if (idx > (point2-1)) {
            pointsToUse2[idx - point2] = CLLocationCoordinate2DMake(point.x, point.y);
        }else {
            pointsToUse[idx] = CLLocationCoordinate2DMake(point.x, point.y);
        }
        
    }];
    
    [self.map setRegion:MKCoordinateRegionMake(pointsToUse[0], MKCoordinateSpanMake(0.01, 0.01))];
    
    MKPolyline *myPolyline = [MKPolyline polylineWithCoordinates:pointsToUse count:point2];
    
    [self.map addOverlay:myPolyline];
    SMAnnotation *annotation = [[SMAnnotation alloc] init];
    annotation.coordinate = pointsToUse[point2 -1];
    annotation.title = @"我";
    annotation.subtitle = @"我是大帅哥";
    [self.map addAnnotation:annotation];
    
    [self.map setVisibleMapRect:myPolyline.boundingMapRect edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60/pointsArray.count * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MKPolyline *myPolyline = [MKPolyline polylineWithCoordinates:pointsToUse2 count:restPoint];
        [self.map addOverlay:myPolyline];
        [self.map setVisibleMapRect:myPolyline.boundingMapRect edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
        [self.map removeAnnotations:self.map.annotations];
        
        SMAnnotation *annotation = [[SMAnnotation alloc] init];
        annotation.coordinate = pointsToUse2[restPoint -1];
        annotation.title = @"我";
        annotation.subtitle = @"我是大帅哥";
        [self.map addAnnotation:annotation];
    });
}


- (void)setUpMap {
    [self.view addSubview:self.map];
    [self addPloyline];
}

- (MKMapView *)map {
    if (!_map) {
        _map = [[MKMapView alloc] initWithFrame:self.view.bounds];
        _map.delegate = self;
    }
    return _map;
}

#pragma mark MKMapViewDelegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:MKPolyline.class]) {
        MKPolylineRenderer *lineView = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [lineView setStrokeColor:[UIColor greenColor]];
        [lineView setLineWidth:5.f];
        return lineView;
    }
    return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    return nil;
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
