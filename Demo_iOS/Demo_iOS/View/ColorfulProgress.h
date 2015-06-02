//
//  ColorfulProgress.h
//  Demo_iOS
//
//  Created by iStig on 15/5/28.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorfulProgress : UIView
@property (nonatomic, readonly) CALayer *maskLayer;
@property (nonatomic, assign) CGFloat progress;

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;
@end
