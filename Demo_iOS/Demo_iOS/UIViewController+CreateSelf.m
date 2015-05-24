//
//  UIViewController+CreateSelf.m
//  Demo_iOS
//
//  Created by iStig on 15/5/22.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "UIViewController+CreateSelf.h"

@implementation UIViewController (CreateSelf)
+ (instancetype)createSelf {
    UIStoryboard *story = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:[NSBundle mainBundle]];
    return [story instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}
@end
