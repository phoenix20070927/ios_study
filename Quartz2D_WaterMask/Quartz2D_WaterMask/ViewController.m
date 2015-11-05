//
//  ViewController.m
//  Quartz2D_WaterMask
//
//  Created by yanyiming on 15/11/5.
//  Copyright © 2015年 ppl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
    NSString* path = [[NSBundle mainBundle]pathForResource:@"IMG_0010" ofType:@"JPG"];
    UIImage *originalImage = [UIImage imageWithContentsOfFile:path];
    
    UIImage *image = [self waterMaskImage:originalImage];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    [self.view addSubview:imageView];

}

#pragma mark - 打个水印
- (UIImage *)waterMaskImage:(UIImage* )originalImage
{
    //指定图片的大小
    CGSize imageSize = self.view.bounds.size;
    
    // 1. 建立图像的上下文，需要指定新生成的图像大小
    UIGraphicsBeginImageContext(imageSize);
    
    // 2. 绘制内容
    
    [originalImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    
    //设置颜色
    [[UIColor greenColor]set];
    
    [[UIColor blueColor] setStroke];
    
    // 3. 添加水印文字
    NSString *str = @"水印文字";
    
    //定义字体
    UIFont* font = [UIFont systemFontOfSize:14];
    
    //绘制水印文字
    [str drawInRect:CGRectMake(imageSize.width - 80, imageSize.height - 30, 80, 30) withFont:font lineBreakMode:NSLineBreakByCharWrapping];

    // 4. 从当前上下文中拿到新的图像
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5. 结束图像上下文
    UIGraphicsEndImageContext();
    
    /*
     
     //6.如果你想把新生产的图片写入文件，可以选择执行下面的代码
     
     //生产png数据流
     NSData *data = UIImagePNGRepresentation(newImage);
     //指定文件路径
     NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"new.png"];
     //开始写入图片文件
     [data writeToFile:path atomically:YES];
     NSLog(@"%@",path);
     
     */
    
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
