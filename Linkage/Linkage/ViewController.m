//
//  ViewController.m
//  Linkage
//
//  Created by adminuser on 17/6/7.
//  Copyright © 2017年 adminuser. All rights reserved.
//

#import "ViewController.h"

#import "ViewPager.h"

#import "Test1ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Test1ViewController *te1 = [[Test1ViewController alloc] init];
    Test1ViewController *te2 = [[Test1ViewController alloc] init];
    te2.view.backgroundColor = [UIColor grayColor];
    
//    [self.view addSubview:te.view];
    [self addChildViewController:te1];
    
    ViewPager *pager = [[ViewPager alloc] initWithFrame:CGRectMake(10, 50, 300, 500) withTitles:@[@"测试1", @"测试2"] withViews:@[te1.view, te2.view]];
    
    [self.view addSubview:pager];
    
    [pager makeCurrentIndex:1];
    
    Test1ViewController *te3 = [[Test1ViewController alloc] init];
    te3.view.backgroundColor = [UIColor greenColor];
    [pager addTitle:@"测试3" withView:te3.view];
    
    Test1ViewController *te4 = [[Test1ViewController alloc] init];
    te4.view.backgroundColor = [UIColor blueColor];
    Test1ViewController *te5 = [[Test1ViewController alloc] init];
    te5.view.backgroundColor = [UIColor blackColor];
    [pager addTitles:@[@"测试4", @"测试5"] withViews:@[te4.view, te5.view]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
