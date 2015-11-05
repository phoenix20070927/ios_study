//
//  RidialGradientViewController.m
//  Quartz2D 渐变
//
//  Created by yanyiming on 15/11/5.
//  Copyright © 2015年 ppl. All rights reserved.
//

#import "RidialGradientViewController.h"
#import "MyRidialGradientView.h"

@interface RidialGradientViewController ()

@end

@implementation RidialGradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    MyRidialGradientView* view = [[MyRidialGradientView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    UIButton* changeView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    changeView.frame = CGRectMake(0, 0, 120, 30);
    changeView.center = self.view.center;
    [changeView setTitle:@"去看看线性渐变" forState:UIControlStateNormal];
    [changeView addTarget:self action:@selector(changeViews) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeView];
}

- (void)changeViews{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
