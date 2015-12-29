//
//  ViewController.m
//  pictureDy
//
//  Created by 汤义 on 15/12/29.
//  Copyright © 2015年 汤义. All rights reserved.
//

#import "ViewController.h"
#import "TYShufflingView.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
@property (nonatomic, strong) UIView *largeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TYShufflingView *ShufflingView = [TYShufflingView initView];
    [self.view addSubview:ShufflingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
