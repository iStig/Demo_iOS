//
//  MapPloylineViewController.m
//  Demo_iOS
//
//  Created by iStig on 15/6/2.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "MapPloylineViewController.h"
#import <MapKit/MapKit.h>
@interface MapPloylineViewController ()<MKMapViewDelegate>
@property (nonatomic, strong) MKMapView *map;
@end

@implementation MapPloylineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpMap];
}

- (void)setUpMap {
    [self.view addSubview:self.map];
}

- (MKMapView *)map {
    if (!_map) {
        _map = [[MKMapView alloc] initWithFrame:self.view.bounds];
        _map.delegate = self;
    }
    return _map;
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
