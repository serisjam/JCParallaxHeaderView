//
//  JCProgressView.h
//  JCProgressView
//
//  Created by Jam on 16/5/4.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCProgressView : UIView

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, strong) UIColor *backGroundProgressColor;
@property (nonatomic, strong) UIColor *loadingTintColor;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat lineWidth;

- (void)startAnimating;
- (void)stopAnimating;

@end
