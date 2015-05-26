//
//  UIImageView+shadower.m
//  Demo_iOS
//
//  Created by iStig on 15/5/24.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "UIImageView+shadower.h"

@implementation UIImageView (shadower)
- (void)shadower {
    
    self.layer.shadowColor = [UIColor redColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(4, 4);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowRadius = 5;//阴影半径，默认3
    self.layer.shadowOpacity = 0.8;//阴影透明度，默认0 透明
    
}

- (void)shadowerWithUIBezierPath {
    
    self.layer.shadowColor = [UIColor yellowColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowRadius = 3;//阴影半径，默认3
    self.layer.shadowOpacity = 0.5;//阴影透明度，默认0 透明
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat x = self.bounds.origin.x;
    CGFloat y = self.bounds.origin.y;
    
    CGFloat addWidthAndHeight = 10;
    
    CGPoint topLeft = self.bounds.origin;
    CGPoint topMiddle = CGPointMake(x + (width/2), y - addWidthAndHeight);
    CGPoint topRight = CGPointMake(x + width, y - addWidthAndHeight);
    
    CGPoint rightMiddle = CGPointMake(x + width + addWidthAndHeight,y + (height/2));
    
    CGPoint bottomRight  = CGPointMake(x + width,y + height);
    CGPoint bottomMiddle = CGPointMake(x + (width/2),y + height + addWidthAndHeight);
    CGPoint bottomLeft   = CGPointMake(x,y + height);
    
    CGPoint leftMiddle = CGPointMake(x - addWidthAndHeight,y + (height/2));
    
    [path moveToPoint:topLeft];
    
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    
    //设置阴影路径
    self.layer.shadowPath = path.CGPath;
}
@end
