//
//  UIScrollView+JCParallaxHeader.m
//  JCProgressView
//
//  Created by Jam on 16/5/5.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "UIScrollView+JCParallaxHeader.h"

NSString *const JCParallaxKeyPathContentOffset = @"contentOffset";
NSString *const JCParallaxKeyPathContentInset = @"contentInset";
NSString *const JCParallaxKeyPathContentSize = @"contentSize";

@interface JCParallaxView ()

@property (nonatomic, strong) UIView *wrapView;
@property (nonatomic, strong) UIView *stickView;
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@property (nonatomic, assign) CGFloat originTopInset;
@property (nonatomic, assign) CGFloat height;

@end

@implementation JCParallaxView

- (instancetype)initWithContentView:(UIView *)contentView inScrollView:(UIScrollView *)scrollView withParallaxModel:(JCParallaxModel)parallaxModel withWidth:(CGFloat)width andHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(0, 0, width, height)];
    
    if (self) {
        
        self.scrollView = scrollView;
        
        self.height = height;
        self.originTopInset = scrollView.contentInset.top;
        
        [self configWrapView];
        [self configContentView:contentView withParallaxModel:parallaxModel];
    }
    
    return self;
}

- (void)configWrapView {
    self.wrapView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.wrapView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.wrapView];
    
    [self.wrapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_wrapView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_wrapView)];
    [self addConstraints:constraint_H];
    
    self.topConstraint = [NSLayoutConstraint constraintWithItem:self.wrapView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0f];
    self.heightConstraint = [NSLayoutConstraint constraintWithItem:self.wrapView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.height];
    
    [self addConstraint:self.topConstraint];
    [self addConstraint:self.heightConstraint];
}

- (void)configContentView:(UIView *)contentView withParallaxModel:(JCParallaxModel)parallaxModel {

    [self.wrapView addSubview:contentView];
    self.wrapView.clipsToBounds = YES;
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    switch (parallaxModel) {
        case JCParallaxModelTopFill:
            [self addTopFillConstraintContentView:contentView];
            break;
        case JCParallaxModelTopFillFixed:
            [self addTopFillFixedConstraintContentView:contentView];
            break;
        case JCParallaxModelCenter:
            [self addCenterConstraintContentView:contentView];
            break;
        case JCParallaxModelStick:
            [self addStickConstraintContentView:contentView];
            break;
        default:
            break;
    }
}

- (void)addTopFillConstraintContentView:(UIView *)contentView {
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(contentView)];
    
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.wrapView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.height];
    constraint.priority = UILayoutPriorityRequired;
    
    NSLayoutConstraint *heighConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.wrapView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0f];
    heighConstraint.priority = UILayoutPriorityDefaultHigh;
    
    [self.wrapView addConstraints:constraint_H];
    [self.wrapView addConstraint:centerYConstraint];
    [self.wrapView addConstraint:constraint];
    [self.wrapView addConstraint:heighConstraint];
}

- (void)addTopFillFixedConstraintContentView:(UIView *)contentView {
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(contentView)];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.wrapView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.height];
    constraint.priority = UILayoutPriorityRequired;
    
    NSLayoutConstraint *heighConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.wrapView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0f];
    heighConstraint.priority = UILayoutPriorityDefaultHigh;
    
    [self.wrapView addConstraints:constraint_H];
    [self.wrapView addConstraint:topConstraint];
    [self.wrapView addConstraint:constraint];
    [self.wrapView addConstraint:heighConstraint];
}

- (void)addCenterConstraintContentView:(UIView *)contentView {
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(contentView)];
    
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.wrapView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.height];
    constraint.priority = UILayoutPriorityRequired;
    
    NSLayoutConstraint *heighConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.height];
    heighConstraint.priority = UILayoutPriorityDefaultHigh;
    
    [self.wrapView addConstraints:constraint_H];
    [self.wrapView addConstraint:centerYConstraint];
    [self.wrapView addConstraint:constraint];
    [self.wrapView addConstraint:heighConstraint];
}

- (void)addStickConstraintContentView:(UIView *)contentView {
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(contentView)];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.wrapView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *heighConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.height];
    heighConstraint.priority = UILayoutPriorityDefaultHigh;
    
    [self.wrapView addConstraints:constraint_H];
    [self.wrapView addConstraint:topConstraint];
    [self.wrapView addConstraint:heighConstraint];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:JCParallaxKeyPathContentOffset]) {
        CGPoint contentOffset = [[change valueForKey:@"new"] CGPointValue];
        CGFloat scaleProgress = fmaxf(0, (1 - ((contentOffset.y + self.originTopInset)/self.height)));
        _progress = scaleProgress;

        CGFloat height = self.height + contentOffset.y*-1.0f-self.originTopInset;
        height = height>=0 ? height : 0;
        self.heightConstraint.constant = height;
        self.topConstraint.constant = contentOffset.y+self.originTopInset;
        
    }
    
    if ([keyPath isEqualToString:JCParallaxKeyPathContentInset]) {
        UIEdgeInsets contentInset = [[change valueForKey:@"new"] UIEdgeInsetsValue];
        self.originTopInset = contentInset.top;
        
        self.heightConstraint.constant = self.height - self.originTopInset;
        self.topConstraint.constant = self.originTopInset;
        
        [self.scrollView setContentOffset:CGPointMake(0.0, -self.originTopInset)];
    }
}

- (void)setStickView:(UIView *)stickView withStickPosition:(JCStickPosition)stickPosition withHeight:(CGFloat)height; {
    
    if (_stickView) {
        [_stickView removeFromSuperview];
        
    }
    
    _stickView = stickView;
    [self.wrapView addSubview:_stickView];
    [_stickView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[stickView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(stickView)];
    NSArray *constraintV;
    if (stickPosition == JCStickPositionTop) {
        constraintV = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[stickView(==%f)]", height] options:0 metrics:0 views:NSDictionaryOfVariableBindings(stickView)];
    } else {
        constraintV = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[stickView(==%f)]|", height] options:0 metrics:0 views:NSDictionaryOfVariableBindings(stickView)];
    }
    
    [self.wrapView addConstraints:constraintH];
    [self.wrapView addConstraints:constraintV];
}

@end

static char JCParallaxHeader;

@implementation UIScrollView (JCParallaxHeader)

- (void)dealloc
{
	[self removeObserver:self.parallaxView forKeyPath:JCParallaxKeyPathContentOffset];
	[self removeObserver:self.parallaxView forKeyPath:JCParallaxKeyPathContentInset];
}

- (void)setParallaxView:(UIView *)parallaxView withParallaxModel:(JCParallaxModel)parallaxModel withWidth:(CGFloat)width andHeight:(CGFloat)height {
    
    self.parallaxView = [[JCParallaxView alloc] initWithContentView:parallaxView  inScrollView:self withParallaxModel:parallaxModel withWidth:width andHeight:height];
    
    [self addObserver:self.parallaxView forKeyPath:JCParallaxKeyPathContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self.parallaxView forKeyPath:JCParallaxKeyPathContentInset options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setParallaxView:(JCParallaxView *)parallaxView {
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if ([obj isKindOfClass:[JCParallaxView class]]) {
            [obj removeFromSuperview];
        }
    }];
    
    if ([self isKindOfClass:[UITableView class]]) {
        [(UITableView*)self setTableHeaderView:parallaxView];
    } else {
        [self addSubview:parallaxView];
    }
    
    objc_setAssociatedObject(self, &JCParallaxHeader, parallaxView, OBJC_ASSOCIATION_ASSIGN);
}

- (JCParallaxView *)parallaxView {
    return objc_getAssociatedObject(self, &JCParallaxHeader);
}

@end
