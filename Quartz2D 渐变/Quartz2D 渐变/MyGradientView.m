//
//  MyGradientView.m
//  Quartz2D 渐变
//
//  Created by yanyiming on 15/11/5.
//  Copyright © 2015年 ppl. All rights reserved.
//

#import "MyGradientView.h"

@implementation MyGradientView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawGradient:(CGContextRef)context{
    
    //创建颜色空间 颜色空间，用三维数据来描述一个颜色，在ios中其实就是RGB颜色模式。
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //创建渐变
    /*
     使用这个方法创建渐变：
     CGGradientCreateWithColorComponents(<#CGColorSpaceRef  _Nullable space#>, <#const CGFloat * _Nullable components#>, <#const CGFloat * _Nullable locations#>, <#size_t count#>)
     参数详解：
     CGColorSpaceRef 颜色空间
     components 一个表述渐变两端颜色的数组，8个元素，其中每四个元素构成一个颜色，{r, g, b, a, r, g, b, a},r、g、b、a分别代表红、绿、蓝和透明度alpha值
     locations 代表渐变起始的位置，有两个元素，起始位置范围用0~1之间的小数表示。
     
     */
    CGFloat components[8] = {1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0};//红到白
    CGFloat locations[2] = {0.0, 1.0};
//    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    
    //绘制渐变 前面四个参数看参数名即可理解， 最后一个options有如下定义：
    /*
    typedef CF_OPTIONS (uint32_t, CGGradientDrawingOptions) {
        kCGGradientDrawsBeforeStartLocation = (1 << 0),
        kCGGradientDrawsAfterEndLocation = (1 << 1)
    };
     */
    //渐变区域裁剪
    //    CGContextClipToRect(context, CGRectMake(0, 100, 100, 100));//裁剪成一个小块儿
    
    //裁剪的块数
    int slices = 400;
    //正方形数组
    CGRect rects[slices];
    //定义列数
    int colums = 10;
    //定义小方块的间距
    CGFloat lineSpace = 5;
    //定义小正方形的边长
    CGFloat sideLength = ([UIScreen mainScreen].bounds.size.width - (colums - 1) * lineSpace ) / colums;
    

    for (int i = 0 ; i < slices; i++) {
        rects[i] = CGRectMake(0 + (i % colums) * (sideLength + lineSpace), 0 + i / colums * (sideLength + lineSpace), sideLength, sideLength);
    }
    CGContextClipToRects(context, rects, slices);
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 0), CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height), kCGGradientDrawsAfterEndLocation);
    

    

    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
    //释放渐变
    CGGradientRelease(gradient);
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawGradient:context];
}

@end
