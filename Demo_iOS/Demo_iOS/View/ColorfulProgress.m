//
//  ColorfulProgress.m
//  Demo_iOS
//
//  Created by iStig on 15/5/28.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "ColorfulProgress.h"


@implementation ColorfulProgress
@synthesize maskLayer,progress;

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color {
    if (self = [super initWithFrame:frame]) {
        CAGradientLayer *gradintLayer = (id) [self  layer];
        gradintLayer.startPoint = CGPointMake(0.f, 0.5f);
        gradintLayer.endPoint = CGPointMake(1.0f, 0.5f);
        
        NSMutableArray *colors = [NSMutableArray array];
        for (NSInteger hue = 0; hue <= 360; hue+=5) {
         UIColor    *color = [UIColor colorWithHue:1.0 * hue / 360.0
                               saturation:1.0
                               brightness:1.0
                                    alpha:1.0];
            [colors addObject:color];
        }
        
        gradintLayer.colors = [NSArray arrayWithArray:colors];
        
        maskLayer = [CALayer layer];
        [maskLayer setFrame:CGRectMake(0, 0, 0, frame.size.height)];
        [maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
        [gradintLayer setMask:maskLayer];
        
    }
    return self;
}

- (void)performAnimation {
    // Move the last color in the array to the front
    // shifting all the other colors.
    CAGradientLayer *layer = (id)[self layer];
    NSMutableArray *mutable = [[layer colors] mutableCopy];
    id lastColor = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:lastColor atIndex:0];

    NSArray *shiftedColors = [NSArray arrayWithArray:mutable];

    
    // Update the colors on the model layer
    [layer setColors:shiftedColors];
    
    // Create an animation to slowly move the gradient left to right.
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:shiftedColors];
    [animation setDuration:0.08];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    [self performAnimation];
}

- (void)setProgress:(CGFloat)value {
    if (progress != value) {
        // Progress values go from 0.0 to 1.0
        progress = MIN(1.0, fabs(value));
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    // Resize our mask layer based on the current progress
    CGRect maskRect = [maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * progress;
    [maskLayer setFrame:maskRect];
}

+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end
