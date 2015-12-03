//
//  CAShapeLayerViewController.m
//  Demo_iOS
//
//  Created by iStig on 15/5/26.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "CAShapeLayerViewController.h"
#import "ColorfulProgress.h"

@interface CAShapeLayerViewController()
@property (strong,   nonatomic) CAShapeLayer *indefiniteAnimatedLayer;
@property (assign,   nonatomic) CGFloat strokeThickness;
@property (assign,   nonatomic) CGFloat radius;
@property (strong,   nonatomic) CAShapeLayer *eventLayer;
@property (strong,   nonatomic) UIImageView *imgView;
@property (strong,   nonatomic) UIView *rotateView;
@property (nonatomic)  CGMutablePathRef  path;
@end
@implementation CAShapeLayerViewController
@synthesize path;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
//    [self setupKeyAnimation];
    
    [self setupRotateView];
    [self setupKeyAnimation];
    [self setupEventLayer];
    [self setupIndefiniteAnimatedLayer];
    [self drawRect];
    [self drawColorfulProgress];
}

- (void)drawColorfulProgress {
    ColorfulProgress *progress = [[ColorfulProgress alloc] initWithFrame:CGRectMake(30, 180, 400, 5) color:nil];
    progress.progress = 1;
    [self.view addSubview:progress];

}

//let replicatorLayer = CAReplicatorLayer()
//replicatorLayer.bounds = CGRect(x: 0, y: 0, width: activityIndicatorView.frame.size.width, height: activityIndicatorView.frame.size.height)
//replicatorLayer.position = CGPoint(x: activityIndicatorView.frame.size.width/2, y: activityIndicatorView.frame.size.height/2)
//replicatorLayer.backgroundColor = UIColor.lightGrayColor().CGColor
//activityIndicatorView.layer.addSublayer(replicatorLayer)
//
//let circle = CALayer()
//circle.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
//circle.position = CGPoint(x: activityIndicatorView.frame.size.width/2, y: activityIndicatorView.frame.size.height/2 - 55)
//circle.cornerRadius = 7.5
//circle.backgroundColor = UIColor.whiteColor().CGColor
//replicatorLayer.addSublayer(circle)
//
//replicatorLayer.instanceCount = 15
//let angle = CGFloat(2 * M_PI) / CGFloat(15)
//replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
//
//let scale = CABasicAnimation(keyPath: "transform.scale")
//scale.fromValue = 1
//scale.toValue = 0.1
//scale.duration = 1
//scale.repeatCount = HUGE
//circle.addAnimation(scale, forKey: nil)
//
//replicatorLayer.instanceDelay = 1/15
//
//circle.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)

- (void)setupRotateView {
    _rotateView = [[UIView alloc] initWithFrame:CGRectMake(50, 400, 140, 140)];
    _rotateView.backgroundColor = [UIColor blueColor];
//    _rotateView.layer.anchorPoint = CGPointMake(1, 1);
//    _rotateView.layer.position = CGPointMake(120, 120);
//    _rotateView.center = self.view.center;
    NSLog(@"POSITION.X:%f  POSITION.Y:%f",_rotateView.layer.position.x,_rotateView.layer.position.y);
    NSLog(@"anchorPoint.X:%f  anchorPoint.Y:%f",_rotateView.layer.anchorPoint.x,_rotateView.layer.anchorPoint.y);
    [self.view addSubview:_rotateView];
//    [self setAnchorPoint:CGPointMake(1, 1) forView:_rotateView];
    
    CAReplicatorLayer *replicatorLayer = [[CAReplicatorLayer alloc] init];
    replicatorLayer.bounds = CGRectMake(0, 0, _rotateView.frame.size.width, _rotateView.frame.size.height);
    replicatorLayer.position =CGPointMake(_rotateView.frame.size.width/2, _rotateView.frame.size.height/2);
    replicatorLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [_rotateView.layer addSublayer:replicatorLayer];
    
    CALayer *circle = [[CALayer alloc] init];
    circle.bounds = CGRectMake(0, 0, 15, 15);
    circle.cornerRadius = 7.5;
    circle.position = CGPointMake(_rotateView.frame.size.width/2, _rotateView.frame.size.height/2 - 55);
    circle.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:circle];
    
    replicatorLayer.instanceCount = 15;
    CGFloat angle = 2 * M_PI / 15 ;
    replicatorLayer.instanceTransform =  CATransform3DMakeRotation(angle, 0, 0, 1) ;
    
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @1;
    scale.toValue = @0.1;
    scale.duration = 1;
    scale.repeatCount = HUGE;
    [circle addAnimation:scale forKey:nil];
    
    replicatorLayer.instanceDelay = 0.06666667;
    circle.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
}


- (void) setAnchorPoint:(CGPoint)anchorpoint forView:(UIView *)view{
    CGRect oldFrame = view.frame;
    view.layer.anchorPoint = anchorpoint;
    view.frame = oldFrame;
}

//接着初始化路径
-(void)initPath{
    
    //设置路劲
     path = CGPathCreateMutable();
    //线
    CAShapeLayer *line =  [CAShapeLayer layer];
    //宽度
    line.lineWidth = 2.0f ;
    //线颜色
    line.strokeColor = [UIColor orangeColor].CGColor;
    //里面的填充色
    line.fillColor = [UIColor purpleColor].CGColor;
    //添加椭圆
    CGPathAddEllipseInRect(path, NULL, CGRectMake(50, 100, 200, 100));//椭圆路径，关键步骤。
    //线的路劲
    line.path = path;
//    CGPathRelease(path);
    [self.view.layer addSublayer:line];
}

- (void)setupKeyAnimation {
    
    [self initPath];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 20, 20)];
    _imgView.image = [UIImage imageNamed:@"boll"];
    _imgView.opaque = NO;
    [self.view addSubview:_imgView];
    
    [self startMoving];

}

//开始移动
-(void)startMoving{
    
    
    // [self.layer addAnimation:[self animation] forKey:@"position"];//圆周运动
    [_imgView.layer addAnimation:[self animation] forKey:@"position"];
    //在layer层添加
//    [self.view.layer addAnimation:[self fadeInOutAnimation] forKey:@"opacity"];//阴影转动效果
//    
//    self.view.layer.needsDisplayOnBoundsChange = YES;
//    self.view.backgroundColor = [UIColor redColor];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    self.view.layer.position = CGPointMake(10, 10);
//    self.view.layer.opacity = .4;
}


//图片
-(CAAnimation*)animation {
    
    CAKeyframeAnimation* animation;
    //创建一个动画对象
    animation = [CAKeyframeAnimation animation];
    //动画路径
    animation.path = path;
    //释放
//    CGPathRelease(path);
    //间隔时间.频率
    animation.duration = 5;
    //重复次数
    animation.repeatCount = 2;
    //计算模式
    animation.calculationMode = @"cubic";
    animation.calculationMode=kCAAnimationCubicPaced;
    return animation;
}

//当前视图
-(CAAnimation*)fadeInOutAnimation{
    //通过keypath创建路径
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 5;
    animation.repeatCount =10000;
    animation.toValue = [NSNumber numberWithFloat:.4];
    animation.autoreverses = YES;
    return animation;
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
