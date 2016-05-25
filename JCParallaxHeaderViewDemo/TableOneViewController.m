//
//  TableOneViewController.m
//  JCProgressView
//
//  Created by Jam on 16/5/9.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "TableOneViewController.h"
#import "UIScrollView+JCParallaxHeader.h"
#import "JCProgressView.h"

@interface TableOneViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet JCProgressView *progressView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView setParallaxView:self.headerView withParallaxModel:JCParallaxModelTopFill withWidth:[[UIScreen mainScreen] bounds].size.width andHeight:130];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setBackgroundColor:[UIColor greenColor]];
    [titleLabel setText:@"固定头部"];
    
    [self.tableView.parallaxView setStickView:titleLabel withStickPosition:JCStickPositionTop withHeight:20.0f];
    
    [_progressView setLineWidth:2.0f];
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

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.progressView.isAnimating) {
        [_progressView setProgress:self.tableView.parallaxView.progress - 1.0f];
    }
    
    if (self.progressView.progress >= 1.0 && !self.progressView.isAnimating) {
        [self.progressView setProgress:0.2f];
        [self.progressView startAnimating];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_progressView stopAnimating];
            });
        });
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.progressView.isAnimating) {
        [self.progressView setProgress:0.0f];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"row %ld", (long)indexPath.row]];
    
    return cell;
}

@end
