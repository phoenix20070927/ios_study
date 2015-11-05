//
//  ViewController.m
//  Quartz2D 渐变
//
//  Created by yanyiming on 15/11/5.
//  Copyright © 2015年 ppl. All rights reserved.
//

#import "ViewController.h"
#import "RidialGradientViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton* changeView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    changeView.frame = CGRectMake(0, 0, 120, 30);
    changeView.center = self.view.center;
    [changeView setTitle:@"去看看径向渐变" forState:UIControlStateNormal];
    [changeView addTarget:self action:@selector(changeViews) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeView];
    
}

- (void)changeViews{
    RidialGradientViewController* vc = [[RidialGradientViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
