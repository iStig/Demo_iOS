//
//  ViewController.h
//  Demo_iOS
//
//  Created by iStig on 15/5/21.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef NS_ENUM(NSUInteger, VC_Type) {
    VC_Type_Translate = 0,
    VC_Type_ShapeLayer,
    VC_Type_MapPloyline,
    VC_Type_Autolayout,
    VC_Type_ResizeCell,
};

@interface ViewController : BaseViewController


@end

