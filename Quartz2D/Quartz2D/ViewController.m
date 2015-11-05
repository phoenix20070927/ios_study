//
//  ViewController.m
//  Quartz2D
//
//  Created by yanyiming on 15/11/4.
//  Copyright © 2015年 ppl. All rights reserved.
//

#import "ViewController.h"
#import "MyDrawingView.h"
#import "FiveCornersStar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton* nextPage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextPage.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 20, [UIScreen mainScreen].bounds.size.width - 20, 20);
    [nextPage setTitle:@"绘制五角星" forState:UIControlStateNormal];
    [nextPage addTarget:self action:@selector(showFiveCornerStar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPage];
}

- (void)showFiveCornerStar{
    FiveCornersStar* view = [[FiveCornersStar alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.tag = 101;
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton* nextPage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextPage.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 20, [UIScreen mainScreen].bounds.size.width - 20, 20);
    [nextPage setTitle:@"绘制五角星" forState:UIControlStateNormal];
    [nextPage addTarget:self action:@selector(backFromFiveCornerStarPage) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:nextPage];
    
    [self.view addSubview:view];
    
}

- (void)backFromFiveCornerStarPage{
    [[self.view viewWithTag:101] removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
