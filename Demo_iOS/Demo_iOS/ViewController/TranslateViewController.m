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
    
//    [self constraintV1];
//    [self constraintV2];
    [self setUpRotateImage];
    [self setUpFlowImage];
  
//  UITextField *text  = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, 200, 50)];
//  [text becomeFirstResponder];
//  [self.view addSubview:text];
}

-(BOOL)canBecomeFirstResponder{
  return YES;
}

//-(NSArray *)keyCommands{
//  //组合键
//  return @[[UIKeyCommand keyCommandWithInput:UIKeyInputEscape modifierFlags:UIKeyModifierShift action:@selector(escapeShiftKeyPressed:)]];
//}
//
//-(void)escapeShiftKeyPressed:(UIKeyCommand *)keyCommand{
//  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"UIKeyCommand Demo" message:[NSString stringWithFormat:@"%@ pressed", keyCommand.input] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//  [alertView show];
//}

- (NSArray *)keyCommands
{
  return @[[UIKeyCommand keyCommandWithInput:@"f"
                               modifierFlags:UIKeyModifierCommand
                                      action:@selector(searchKeyPressed:)]];
}

- (void)searchKeyPressed:(UIKeyCommand *)keyCommand
{
  
  // Respond to the event
}

- (void)constraintV1 {
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [button1 setTitle:@"button 1 button 2" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor redColor];
    [button1 sizeToFit];
    
    [self.view addSubview:button1];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-150.0f];
    constraint.priority = 751.0f;//此时autolayout系统会去首先满足此constraint，再去满足Content Compression Resistance（其优先级为750，小于751）。 通俗点约束力比我自身默认的大  强行让我收缩
    [self.view addConstraint:constraint];
}

- (void)constraintV2 {
    UIButton*  button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [button1 setTitle:@"button 1 button 2" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor redColor];
    [button1 sizeToFit];
    
    [self.view addSubview:button1];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:200.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-10.0f];
    constraint.priority = 251.0f;//此时autolayout系统会去首先满足此constraint，再去满足Content Hugging（其优先级为250，小于251）。  通俗点约束力比我自身默认的大  强行让我拉伸
    [self.view addConstraint:constraint];
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
    CGRect frame = CGRectMake(0, 0, 320, 320*3/4);
    self.foldView = [[FoldingView alloc] initWithFrame:frame
                                                 image:[UIImage imageNamed:@"boat"]];
    self.foldView.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.imageFront.frame) + frame.size.height/2 + 10);
    [self.view addSubview:self.foldView];
}

@end
