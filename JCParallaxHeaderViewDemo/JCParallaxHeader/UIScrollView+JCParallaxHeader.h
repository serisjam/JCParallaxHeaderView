//
//  UIScrollView+JCParallaxHeader.h
//  JCProgressView
//
//  Created by Jam on 16/5/5.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef enum : NSUInteger {
    JCParallaxModelTopFill,
    JCParallaxModelTopFillFixed,
    JCParallaxModelCenter,
    JCParallaxModelStick,
} JCParallaxModel;

typedef enum : NSUInteger {
    JCStickPositionTop,
    JCStickPositionBottom,
} JCStickPosition;

@interface JCParallaxView : UIView

@property (nonatomic, readonly, assign) CGFloat progress;

- (void)setStickView:(UIView *)stickView withStickPosition:(JCStickPosition)stickPosition withHeight:(CGFloat)height;

@end

@interface UIScrollView (JCParallaxHeader)

@property (nonatomic, strong, readonly) JCParallaxView *parallaxView;

- (void)setParallaxView:(UIView *)parallaxView withParallaxModel:(JCParallaxModel)parallaxModel withWidth:(CGFloat)width andHeight:(CGFloat)height;

@end
