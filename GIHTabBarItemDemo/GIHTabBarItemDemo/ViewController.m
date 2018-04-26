//
//  ViewController.m
//  GIHTabBarItemDemo
//
//  Created by 徐强 on 2018/4/25.
//  Copyright © 2018年 gaizhi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self redDot:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)redDot:(id)sender {
    self.tabBarItem.badgeValue = @"";
    self.tabBarItem.title = @"空字符";
}

- (IBAction)newBadge:(id)sender {
    self.tabBarItem.badgeValue = @"new";
    self.tabBarItem.title = @"new字符";
    self.tabBarItem.badgeColor = [UIColor redColor];
}
- (IBAction)tenBadge:(id)sender {
    self.tabBarItem.badgeValue = @"10";
    self.tabBarItem.title = @"10字符";
    self.tabBarItem.badgeColor = [UIColor greenColor];
}
- (IBAction)nilBadge:(id)sender {
    self.tabBarItem.badgeValue = nil;
    self.tabBarItem.title = @"nil字符";
}

@end
