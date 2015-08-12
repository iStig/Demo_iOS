//
//  UIView+loadFromNib.m
//  Demo_iOS
//
//  Created by iStig on 15/8/4.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "UIView+loadFromNib.h"

@implementation UIView (loadFromNib)
+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}
@end
