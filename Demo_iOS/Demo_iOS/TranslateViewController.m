//
//  TranslateViewController.m
//  Demo_iOS
//
//  Created by iStig on 15/5/21.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "TranslateViewController.h"
#import "FoldingView.h"

@interface TranslateViewController ()
@property (nonatomic, strong) UIImageView *imageFront;
@property (nonatomic, strong) UIImageView *imageMiddle;
@property (nonatomic, strong) UIImageView *imageEnd;
@property(nonatomic) FoldingView *foldView;
@end
@implementation TranslateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRotateImage];
//    [self setUpFlowImage];
}

- (void)setUpRotateImage {
    
    CGFloat padding = 40 + 44;
    CGFloat height = 310;
    CGFloat width = 210;
    
    NSArray *images = @[@"wukong",@"sweetgirl",@"lovelygirl"];
    self.imageFront = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width- width)/2,padding, width , height)];
    self.imageMiddle = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width- width)/2,padding , width , height)];
    self.imageEnd = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width- width)/2,padding , width , height)];

    NSArray *arr = @[self.imageFront,self.imageMiddle,self.imageEnd];
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -2.5/2000;

    //BUG FIX:吓尿了  NSUInteger  i = 0 改成 NSInteger  i = 0 才正常，什么问题没分析出来啊
    for (NSInteger i = 0; i < arr.count; i++) {
        UIImageView *img = arr[i];
        img.image = [UIImage imageNamed:images[i]];
        [self.view addSubview:img];
        
        img.layer.zPosition = (2-i)*100;
        img.layer.transform = perspective;
        img.layer.transform = CATransform3DTranslate(img.layer.transform, 0, i*-5, 0);//改变y轴
        img.layer.transform = CATransform3DScale(img.layer.transform, 1-0.1*i, 1, 1);//不改变y和z轴，只改变x轴尺寸
        img.layer.transform = CATransform3DRotate(img.layer.transform, -1*M_PI/180, 1, 0, 0);//改变x轴转角,角度转换成弧度：角度 * M_PI / 180 这里只改变了一个单位
        img.layer.opacity = 1-0.1*i;//改变透明度
        img.layer.cornerRadius = 5;//改变圆角弧度
        img.layer.masksToBounds = YES;
//        img.layer.borderWidth = 5;
//        img.layer.borderColor = [UIColor redColor].CGColor;
//        [img shadower];
//        [img shadowerWithUIBezierPath];
    }
}

- (void)setUpFlowImage {
    CGFloat padding = 30.f;
    CGFloat width = CGRectGetWidth(self.view.bounds) - padding * 2;
    CGRect frame = CGRectMake(0, CGRectGetMaxX(self.imageFront.frame) + 20, width, width);
    
    self.foldView = [[FoldingView alloc] initWithFrame:frame
                                                 image:[UIImage imageNamed:@"boat"]];
    self.foldView.center = self.view.center;
    [self.view addSubview:self.foldView];

}

@end
