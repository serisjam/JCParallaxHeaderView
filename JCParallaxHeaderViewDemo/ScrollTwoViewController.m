//
//  ScrollTwoViewController.m
//  JCProgressView
//
//  Created by Jam on 16/5/9.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "ScrollTwoViewController.h"

#import "UIScrollView+JCParallaxHeader.h"

@interface ScrollTwoViewController ()

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ScrollTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 800.0f)];
    
    [self.scrollView setParallaxView:self.headerView withParallaxModel:JCParallaxModelTopFillFixed withWidth:[[UIScreen mainScreen] bounds].size.width andHeight:130];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setBackgroundColor:[UIColor greenColor]];
    [titleLabel setText:@"固定尾部"];
    
    [self.scrollView.parallaxView setStickView:titleLabel withStickPosition:JCStickPositionBottom withHeight:20.0f];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
