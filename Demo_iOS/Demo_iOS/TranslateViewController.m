//
//  TranslateViewController.m
//  Demo_iOS
//
//  Created by iStig on 15/5/21.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "TranslateViewController.h"
@interface TranslateViewController ()
@property (nonatomic, strong) UIImageView *imageFront;
@property (nonatomic, strong) UIImageView *imageMiddle;
@property (nonatomic, strong) UIImageView *imageEnd;
@end
@implementation TranslateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRotateImage];
    
}

- (void)setUpRotateImage {
    
    CGFloat padding = 200 + 44;
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
        img.layer.transform = CATransform3DTranslate(img.layer.transform, 0, i*-5, 0);
        img.layer.transform = CATransform3DScale(img.layer.transform, 1-0.1*i, 1, 1);
        img.layer.transform = CATransform3DRotate(img.layer.transform, -1*M_PI/180, 1, 0, 0);
        img.layer.opacity = 1-0.1*i;
        img.layer.cornerRadius = 5;
        img.layer.masksToBounds = YES;
    }
    
}
@end
