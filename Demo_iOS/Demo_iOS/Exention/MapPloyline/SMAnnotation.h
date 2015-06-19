//
//  SMAnnotation.h
//  Demo_iOS
//
//  Created by iStig on 15/6/2.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface SMAnnotation : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
