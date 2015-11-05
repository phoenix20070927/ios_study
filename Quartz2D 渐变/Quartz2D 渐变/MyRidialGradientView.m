//
//  MyRidialGradientView.m
//  Quartz2D 渐变
//
//  Created by yanyiming on 15/11/5.
//  Copyright © 2015年 ppl. All rights reserved.
//

#import "MyRidialGradientView.h"

@implementation MyRidialGradientView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

//径向渐变
- (void)drawRidialGradient:(CGContextRef)context{
    //创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //创建渐变颜色数组 红/绿   绿/蓝   红/蓝
    CGFloat components[12] = {1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0};
    
    //创建起始位置数组
    CGFloat locations[3] = {0.0, 0.5, 1.0};
    /*
     看结果颜色应该是这样分布的：
        颜色数组第一组偏黄色          距离起点（圆心）最远处
        颜色数组第二组偏蓝绿色        距离起点（圆心）中等
        颜色数组最后一组偏紫色        距离起点（圆心）最近
     呃，其实两种颜色的时候比较好弄明白颜色和位置的关系，搞成三种颜色的时候我不明白是怎么回事儿了。。。大家自己贱一贱，看能领悟不！
     
     */
    
    //创建渐变
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 3);//资料上写的是两种颜色的，我想贱一贱3个颜色的，可以实现的
    
    //绘制渐变
    CGContextDrawRadialGradient(context, gradient, CGPointMake(self.bounds.size.width / 2 , self.bounds.size.height / 2),200, CGPointMake(self.bounds.size.width / 2 - 100, self.bounds.size.height / 2 - 100), 1.0, kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
    //释放渐变
    CGGradientRelease(gradient);
    
}

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor greenColor];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawRidialGradient:context];
}


@end
