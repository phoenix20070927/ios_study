//
//  FiveCornersStart.m
//  Quartz2D
//
//  Created by yanyiming on 15/11/4.
//  Copyright © 2015年 ppl. All rights reserved.
//

#import "FiveCornersStar.h"
#import "VertexOfFiveCornersStar.h"

@interface FiveCornersStar()
{
    CGPoint _center;
    BOOL _hasBeenComputed;
}
@property (nonatomic, strong)    NSMutableArray* starPoints;


@end

@implementation FiveCornersStar

- (NSMutableArray* )starPoints{
    if (!_starPoints) {
        _starPoints = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _starPoints;
}

#pragma mark - 获取随机颜色
- (UIColor *)randomColor
{
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

#pragma mark - 计算五角星的五个顶点坐标
- (void)getPointsOfFiveCornersStar
{
    //中心点
    CGPoint center = CGPointMake(0, 0);
    _center = center;
    
    //半径
    CGFloat radius = 30;
    NSLog(@"center.x = %lf center.y = %lf, radius = %lf", center.x, center.y, radius);

    //设置起点
    VertexOfFiveCornersStar* vertexPoint = [[VertexOfFiveCornersStar alloc]init];
    vertexPoint.x = center.x;
    vertexPoint.y = center.y - radius;
    [_starPoints addObject:vertexPoint];
    


    //定义一个圆形的全角角度
    CGFloat angle = 4.0 * M_PI / 5.0;
    
    for (int i = 1; i < 5; i++) {
        //相对于原点坐标计算每个顶点坐标
        VertexOfFiveCornersStar* vertextPoint = [[VertexOfFiveCornersStar alloc]init];
        vertextPoint.x = cosf(i * angle - M_PI_2) * radius;//
        vertextPoint.y = sinf(i * angle - M_PI_2) * radius;//sin和cos函数的执行很耗费资源，这样的计算要提出来只做一次。否则很影响性能。
        NSLog(@"vertextPoint.x = %lf, vertextPoint.y = %lf", vertextPoint.x, vertexPoint.y);
        [_starPoints addObject:vertextPoint];
    }
    _hasBeenComputed = YES;
}


#pragma mark - 绘制五角星
- (void)fiveCornersStartDrawing:(CGContextRef)contexts{

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 10);
    

    [[self randomColor] set];
    
    //取出起点
    VertexOfFiveCornersStar* vertexPoint = _starPoints[0];
    
    //获取五个顶点之后设置路径
    CGContextMoveToPoint(context, vertexPoint.x, vertexPoint.y);
    
    NSLog(@"poits[0].x = %lf .y = %lf", vertexPoint.x, vertexPoint
          .y);
    for (int i = 1; i < 5; i++) {//只需要处理剩下4个点，所以i = 1，而不是i = 0
        VertexOfFiveCornersStar* vertexPoint = _starPoints[i];
        CGContextAddLineToPoint(context, vertexPoint.x + _center.x, vertexPoint.y + _center.y);
    }
    

    
    //路径设置到最后一点之后需要闭合路径与起点连接
    CGContextClosePath(context);
    
    //绘制路径
    CGContextDrawPath(context, kCGPathFill);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (_hasBeenComputed == NO) {
        _starPoints = [[NSMutableArray alloc]initWithCapacity:0];
        [self getPointsOfFiveCornersStar];
    }
    CGContextRef context = UIGraphicsGetCurrentContext();

    for (int i = 0; i < 100; i++) {
        CGContextSaveGState(UIGraphicsGetCurrentContext());
        
        // 平移上下文
        CGFloat x = arc4random() % 320;
        CGFloat y = arc4random() % 568;
        CGContextTranslateCTM(context, x, y);
        
        // 旋转上下文
        CGFloat angle = (arc4random() % 180) * M_PI / 180.0;
        CGContextRotateCTM(context, angle);

        //缩放比例
        CGFloat scale = (arc4random() % 30) / 10 + 0.5;
        CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);//等比缩放
        NSLog(@"scale = %lf", scale);
        [self fiveCornersStartDrawing:context];

        
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
    }
    
}



@end
