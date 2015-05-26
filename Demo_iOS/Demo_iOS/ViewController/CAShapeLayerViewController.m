//
//  CAShapeLayerViewController.m
//  Demo_iOS
//
//  Created by iStig on 15/5/26.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "CAShapeLayerViewController.h"
@interface CAShapeLayerViewController()
@property (strong,   nonatomic) CAShapeLayer *indefiniteAnimatedLayer;
@property (assign,   nonatomic) CGFloat strokeThickness;
@property (assign,   nonatomic) CGFloat radius;
@property (strong,   nonatomic) CAShapeLayer *eventLayer;
@end
@implementation CAShapeLayerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self setupEventLayer];
    [self setupIndefiniteAnimatedLayer];
    [self drawRect];
}

- (void)setupEventLayer {
    _eventLayer = [CAShapeLayer layer];
    _eventLayer.frame = CGRectMake(100,100,100,100);
    _eventLayer.backgroundColor = [UIColor clearColor].CGColor;
    _eventLayer.fillColor = [UIColor redColor].CGColor;
    _eventLayer.strokeColor = [UIColor yellowColor].CGColor;
//    _eventLayer.path = [UIBezierPath bezierPathWithOvalInRect:_eventLayer.bounds].CGPath;
//    _eventLayer.path = [UIBezierPath bezierPathWithRoundedRect:_eventLayer.bounds cornerRadius:_eventLayer.bounds.size.width/4].CGPath;
    _eventLayer.path = [self drawRect].CGPath;
    _eventLayer.lineWidth = 2;
    
    
    
    [self.view.layer addSublayer:_eventLayer];
    
//        _eventLayer.frame = CGRectMake(100,100,10,10);
//        _eventLayer.path = [UIBezierPath bezierPathWithOvalInRect:_eventLayer.bounds].CGPath;
//        _eventLayer.fillColor = [UIColor redColor].CGColor;
}


- (void)setupIndefiniteAnimatedLayer{
    self.strokeThickness = 2.0f;
    self.radius = 18.f;
    [self.view.layer addSublayer:self.indefiniteAnimatedLayer];
//    layer.position = CGPointMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(layer.bounds) / 2, CGRectGetHeight(self.bounds) - CGRectGetHeight(layer.bounds) / 2);
}


- (UIBezierPath *)drawRect
{
//    UIColor *color = [UIColor redColor];
//    [color set]; //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150)
                                                         radius:75
                                                     startAngle:0
                                                       endAngle:M_PI
                                                      clockwise:YES];
    
//    aPath.lineWidth = 10.0;
//    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
//    
//    [aPath stroke];
//    [aPath fill];
    
    return aPath;
}


- (CAShapeLayer*)indefiniteAnimatedLayer {
    if(!_indefiniteAnimatedLayer) {
        //24 24
        CGPoint arcCenter = CGPointMake(self.radius+self.strokeThickness/2+5, self.radius+self.strokeThickness/2+5);
//        CGRect rect = CGRectMake(0.0f, 0.0f, arcCenter.x*2, arcCenter.y*2);
                CGRect rect = CGRectMake(200.0f, 200.0f, arcCenter.x*2, arcCenter.y*2);
        
        //关于bezierPathWithArcCenter http://justsee.iteye.com/blog/1972853
        UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                                    radius:self.radius
                                                                 startAngle:M_PI*3/2
                                                                  endAngle:M_PI*5 + M_PI_2                                                              clockwise:YES];
        
        _indefiniteAnimatedLayer = [CAShapeLayer layer];
        _indefiniteAnimatedLayer.contentsScale = [[UIScreen mainScreen] scale];
        _indefiniteAnimatedLayer.frame = rect;
        _indefiniteAnimatedLayer.fillColor = [UIColor clearColor].CGColor;
        _indefiniteAnimatedLayer.strokeColor = [UIColor blackColor].CGColor;
        _indefiniteAnimatedLayer.lineWidth = self.strokeThickness;
        _indefiniteAnimatedLayer.lineCap = kCALineCapRound;
        _indefiniteAnimatedLayer.lineJoin = kCALineJoinBevel;
        _indefiniteAnimatedLayer.path = smoothedPath.CGPath;
        
        CALayer *maskLayer = [CALayer layer];
        maskLayer.contents = (id)[[UIImage imageNamed:@"angle_mask"] CGImage];
        maskLayer.frame = _indefiniteAnimatedLayer.bounds;
        _indefiniteAnimatedLayer.mask = maskLayer;
        
        NSTimeInterval animationDuration = 1;
        CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.fromValue = 0;
        animation.toValue = [NSNumber numberWithFloat:M_PI*2];
        animation.duration = animationDuration;
        animation.timingFunction = linearCurve;
        animation.removedOnCompletion = NO;
        animation.repeatCount = INFINITY;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses = NO;
        [_indefiniteAnimatedLayer.mask addAnimation:animation forKey:@"rotate"];
        
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue = @0.015;
        strokeStartAnimation.toValue = @0.515;
        
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @0.485;
        strokeEndAnimation.toValue = @0.985;
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = INFINITY;
        animationGroup.removedOnCompletion = NO;
        animationGroup.timingFunction = linearCurve;
        
        animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
        [_indefiniteAnimatedLayer addAnimation:animationGroup forKey:@"progress"];
        
    }
    return _indefiniteAnimatedLayer;
}


@end
