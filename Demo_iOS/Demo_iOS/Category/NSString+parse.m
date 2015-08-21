//
//  NSString+parse.m
//  ShLibraryReader.iPhone
//
//  Created by iStig on 15/5/21.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "NSString+parse.h"
#import <objc/runtime.h>

@implementation NSString (parse)
+ (void)load {
    SEL oringinalSelector = @selector(isEqualToString:);
    SEL swizzledSelector = @selector(parse_isEqualToString:);
    Method orginalMethod = class_getInstanceMethod(self, oringinalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    method_exchangeImplementations(orginalMethod, swizzledMethod);
}

- (BOOL)parse_isEqualToString:(NSString *)aString {
    [self parse_isEqualToString:aString];
//    NSLog(@"$");
    return self == aString? YES: NO;
}

@end
