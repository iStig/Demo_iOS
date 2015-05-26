//
//  UIViewController+CreateSelf.h
//  Demo_iOS
//
//  Created by iStig on 15/5/22.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CreateSelf)
+ (instancetype)createSelf;
+ (instancetype)createSelfWithXib;
+ (instancetype)createSelfWithStoryboard;

@end
