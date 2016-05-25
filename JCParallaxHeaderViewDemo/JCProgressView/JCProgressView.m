//
//  JCProgressView.m
//  JCProgressView
//
//  Created by Jam on 16/5/4.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCProgressView.h"

@interface JCProgressView ()

@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) CAShapeLayer *cycleLayer;
@property (nonatomic, strong) CAShapeLayer *progressBackgroundLayer;
@property (nonatomic, strong) UIBezierPath *cyclePath;

@end

@implementation JCProgressView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _isAnimating = NO;
        self.lineWidth = 1.0f;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
//        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _isAnimating = NO;
        self.lineWidth = 1.0f;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
//        [self setup];
    }
    
    return self;
}

- (void)layoutSubviews {
    [self setup];
}

#pragma mark self method

- (void)setup {
    
    self.backGroundProgressColor = self.tintColor;
    self.loadingTintColor = self.tintColor;
    
    if (self.bounds.size.width >= self.bounds.size.height) {
        self.size = CGSizeMake(self.bounds.size.height, self.bounds.size.height);
    } else {
        self.size = CGSizeMake(self.bounds.size.width, self.bounds.size.width);
    }
    
    [self setToNormalState];
    
    CGFloat radius = MIN(_size.width/2, _size.height/2);
    CGPoint center = CGPointMake(radius, radius);
    
    self.progressBackgroundLayer = [CAShapeLayer layer];
    self.progressBackgroundLayer.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    self.progressBackgroundLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _progressBackgroundLayer.strokeColor = self.backGroundProgressColor.CGColor;
    _progressBackgroundLayer.fillColor = [UIColor clearColor].CGColor;
    _progressBackgroundLayer.lineCap = kCALineCapRound;
    _progressBackgroundLayer.lineWidth = self.lineWidth;
    _progressBackgroundLayer.allowsEdgeAntialiasing = YES;
    [self.layer addSublayer:_progressBackgroundLayer];
    
    self.cycleLayer = [CAShapeLayer layer];
    self.cycleLayer.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    self.cycleLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.cycleLayer.strokeColor = self.loadingTintColor.CGColor;
    self.cycleLayer.fillColor = [UIColor clearColor].CGColor;
    self.cycleLayer.lineCap = kCALineCapRound;
    self.cycleLayer.lineWidth = self.lineWidth;
    self.cycleLayer.allowsEdgeAntialiasing = YES;
    
    self.cyclePath = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-(M_PI_2)
                                                      endAngle:-(M_PI_2)
                                                     clockwise:YES];
    self.cycleLayer.path = self.cyclePath.CGPath;
    
    [self.layer addSublayer:self.cycleLayer];
}

#pragma mark - Indicator animation methods

- (void)setToNormalState{
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.layer.speed = 1.0f;
    self.layer.opacity = 1.0;
}

- (void)setToFadeOutState{
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.layer.sublayers = nil;
    self.layer.opacity = 0.f;
}

- (void)fadeOutWithAnimation:(BOOL)animated{
    if (animated) {
        CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnimation.delegate = self;
        fadeAnimation.beginTime = CACurrentMediaTime();
        fadeAnimation.duration = 0.35;
        fadeAnimation.toValue = @(0);
        [self.layer addAnimation:fadeAnimation forKey:@"fadeOut"];
    }
}

#pragma mark self public methods

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    _progressBackgroundLayer.lineWidth = _lineWidth;
    _cycleLayer.lineWidth = _lineWidth;
}

- (void)setProgress:(CGFloat)progress {
    
    if (progress > 1.0) {
        _progress = 1.0f;
    }
    
    if (progress <= 0.0f) {
        _progress = 0.0f;
        self.cycleLayer.path = nil;
        return ;
    }
    
    _progress = progress;
    
    CGFloat radius = MIN(_size.width/2, _size.height/2);
    CGPoint center = CGPointMake(radius, radius);
    CGFloat endAngle = -(M_PI_2) + M_PI*progress*2.0f;
    self.cyclePath = [UIBezierPath bezierPathWithArcCenter:center
                                                    radius:radius
                                                startAngle:-(M_PI_2)
                                                  endAngle:endAngle
                                                 clockwise:YES];
    self.cycleLayer.path = self.cyclePath.CGPath;
}

- (void)startAnimating {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.8f;
    animation.repeatCount = CGFLOAT_MAX;
    animation.fromValue = @0;
    animation.toValue = @(2*M_PI);
    [self.cycleLayer addAnimation:animation forKey:@"animation"];
    [self.progressBackgroundLayer setOpacity:1.0f];
    self.isAnimating = YES;
    
    CGFloat radius = MIN(_size.width/2, _size.height/2);
    CGPoint center = CGPointMake(radius, radius);
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:-(M_PI_2) endAngle:2*M_PI clockwise:YES];
    _progressBackgroundLayer.path = processBackgroundPath.CGPath;
    _progressBackgroundLayer.opacity = 0.3f;
}

- (void)stopAnimating {
    if (self.isAnimating == YES) {
        [self.cycleLayer removeAnimationForKey:@"animation"];
        self.cycleLayer.path = nil;
        self.progressBackgroundLayer.path = nil;
        self.isAnimating = NO;
        [self fadeOutWithAnimation:YES];
    }
}

- (void)setLoadingTintColor:(UIColor *)color {
    _loadingTintColor = color;
    self.cycleLayer.strokeColor = _loadingTintColor.CGColor;
}

#pragma mark - Did enter background

- (void)appWillEnterBackground{
    if (self.isAnimating == YES) {
        [self.cycleLayer removeAnimationForKey:@"animation"];
    }
}

- (void)appWillBecomeActive{
    if (self.isAnimating == YES) {
        [self startAnimating];
    }
}

@end
