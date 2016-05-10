//
//  TableTwoViewController.m
//  JCProgressView
//
//  Created by Jam on 16/5/9.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "TableTwoViewController.h"
#import "UIScrollView+JCParallaxHeader.h"

@interface TableTwoViewController ()

@property (strong, nonatomic) IBOutlet UIView *headerView;

@end

@implementation TableTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView setParallaxView:self.headerView withParallaxModel:JCParallaxModelTopFillFixed withWidth:[[UIScreen mainScreen] bounds].size.width andHeight:130];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setBackgroundColor:[UIColor greenColor]];
    [titleLabel setText:@"固定尾部"];
    
    [self.tableView.parallaxView setStickView:titleLabel withStickPosition:JCStickPositionBottom withHeight:20.0f];
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
