//
//  UIViewController+CreateSelf.m
//  Demo_iOS
//
//  Created by iStig on 15/5/21.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "UIViewController+CreateSelf.h"
#import <objc/runtime.h>
@implementation UIViewController (CreateSelf)
+ (void)load {
    SEL originalSelector = @selector(viewDidLoad);
    SEL swizzledSelector = @selector(demo_viewDidLoad);
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)demo_viewDidLoad {
    self.view.backgroundColor = [UIColor clearColor];
}
@end
