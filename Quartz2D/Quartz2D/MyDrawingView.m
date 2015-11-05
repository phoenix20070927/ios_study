//
//  MyDrawingView.m
//  Quartz2D
//
//  Created by yanyiming on 15/11/4.
//  Copyright © 2015年 ppl. All rights reserved.
//

#import "MyDrawingView.h"

@implementation MyDrawingView

//绘制直线
- (void)lineDrawing:(CGContextRef)context{
    //创建“可变”的路径，创建成非mutable类型了,将无法使用下面的cgpathmovetopoint和其他设置path的方法
    CGMutablePathRef path = CGPathCreateMutable();
    //设置直线起点
    CGPathMoveToPoint(path, nil, 50, 50);
    //设置直线第一个目标点
    CGPathAddLineToPoint(path, nil, 100, 100);
    //设置直线第二个目标点
    CGPathAddLineToPoint(path, nil, 50, 150);
    //设置直线第三个目标点
    CGPathAddLineToPoint(path, nil, 80, 200);
    //设置直线第四个目标点
    CGPathAddLineToPoint(path, nil, 100, 230);
    /*
     .
     .
     .
     .
     第N个目标点
    */

    //如果你希望画了N条直线之后，第一条直线起点和第N条直线的终点之间也自动连接起来，使用下面的闭合路径方法
    CGPathCloseSubpath(path);//注释掉这句可以对比效果。
    
    //添加路径到上下文
    CGContextAddPath(context, path);
    
    //设置上下文属性:
                    /*=========================================================*/
    
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.5, 1.0);//设置rgb颜色的时候最好不要同时指定alpha，会影响性能
    CGContextSetRGBFillColor(context, 0.8, 1.0, 0.8, 1.0);//填充颜色（填充指的是大于等于两条以上的直线围起来的区域）
    
    
                    /*=========================================================*/
    
    //你可以注释掉上面两句，使用下面的UIKit层封装好的方法来设置填充色
    [[UIColor blueColor]set];//这个方法封装了Stroke和Fill两种颜色的实现
    //你可以注释掉上面一句，使用下面两个方法设置Stroke和Fill中具体的一种直线颜色
    [[UIColor greenColor] setStroke];//设置直线颜色
    [[UIColor yellowColor] setFill];//设置填充区域颜色
    
                    /*=========================================================*/
    
    CGContextSetLineWidth(context, 5);//宽度
    
                    /*=========================================================*/
    
    CGFloat length[3] = {20.0, 5.0, 10.0};
    CGContextSetLineDash(context, 0.0, length, 3);//虚线
    /*
         CGContextSetLineDash(<#CGContextRef  _Nullable c#>, <#CGFloat phase#>, <#const CGFloat * _Nullable lengths#>, <#size_t count#>)
         context -上下文
         phase -相位，虚线起始的位置，通常使用0即可，从头开始画虚线
         lengths -长度的数组
         count -lengths数组的个数
     */
    
                    /*=========================================================*/
    
    CGContextSetLineCap(context, kCGLineCapRound);//顶点样式
    /*
         typedef CF_ENUM(int32_t, CGLineCap) {
             kCGLineCapButt,
             kCGLineCapRound,
             kCGLineCapSquare
         };
     */
    
                    /*=========================================================*/
    
    CGContextSetLineJoin(context, kCGLineJoinRound);//连接点样式
    /*
         typedef CF_ENUM(int32_t, CGLineJoin) {
             kCGLineJoinMiter,
             kCGLineJoinRound,
             kCGLineJoinBevel
         };
     */
    
                    /*=========================================================*/
    
    
    //绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
    /*
         该方法的第二个参数是路径绘制模式，是个枚举值，定义有如下几种
         typedef CF_ENUM (int32_t, CGPathDrawingMode) {
             kCGPathFill,//实心填充
             kCGPathEOFill,//
             kCGPathStroke,//空心填充
             kCGPathFillStroke,//
             kCGPathEOFillStroke//
         };
     */
    
    
    //释放路径
    CGPathRelease(path);
    
}


//绘制矩形
- (void)rectDrawing:(CGContextRef)context{
    //设置矩形位置、尺寸
    CGRect rect = CGRectMake(250, 64, 50, 30);
    CGRect rect2 = CGRectMake(250, 100, 80, 30);
    
    //设置上下文属性
    [[UIColor grayColor] setFill];
    [[UIColor blueColor] setStroke];
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10);
    
    //绘制矩形
    UIRectFill(rect);//实心模式,没有边，只显示采用Fill颜色的实心矩形，不显示Stroke颜色
    UIRectFrame(rect2);//只显示stroke，不显示Fill
    //UIRectClip(rect2);//不知道这个是干嘛的，有空去研究一下
}

//绘制圆
- (void)circleDrawing:(CGContextRef)context{
    CGRect rect = CGRectMake(10, 250, 50, 50);
    //设置路径
//    UIRectFrame(rect);
    CGContextAddEllipseInRect(context, rect);
    //绘制路径
    CGContextDrawPath(context, kCGPathFill);
}

//绘制弧形
- (void)arcDrawing:(CGContextRef)context{
    // 1. 设置路径
    /*
     CGContextAddArc(<#CGContextRef  _Nullable c#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat radius#>, <#CGFloat startAngle#>, <#CGFloat endAngle#>, <#int clockwise#>)

     context 上下文
     x,y 是圆弧所在圆的中心点坐标
     radius 半径，所在圆的半径
     startAngle endAngle 起始角度和截止角度 单位是弧度,0度 对应是圆的最右侧点
     clockwise 顺时针 0 或者逆时针 1
     */
    CGContextAddArc(context, 160, 230, 100, -M_PI_2, M_PI_2, 0);
    
    // 2. 绘制圆弧
    CGContextDrawPath(context, kCGPathFill);
    
}

//绘制文字
- (void)textDrawing:(CGContextRef)context{
    
                    /*==========================普通横向绘制文本===============================*/
    NSString* text = @"I'm super man！";
    //指定字体
    UIFont* font = [UIFont systemFontOfSize:14];
    CGRect rect = CGRectMake(50, 300, 120, 30);
    [[UIColor blueColor]setStroke];
    [text drawInRect:rect withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
    
                    /*===========================竖排绘制文本==============================*/
    //宽度不要太宽，不然就不是一行一个字了。
    CGRect rect2 = CGRectMake(50, 350, 15, 120);
    NSString* text2 = @"我不是超人!";
    //定义一个段落样式
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    //设置段落样式的断行 模式
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;

    [text2 drawInRect:rect2 withAttributes:@{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle}];
    
}

//绘制图片
- (void)imageDrawing:(CGContextRef)context{
    UIImage* img = [UIImage imageNamed:@"ppl"];
    
    [img drawAtPoint:CGPointMake(80, 300)];//以指定点为原点绘制，按照图片原始尺寸绘制
    
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(context, 1);
    UIRectFrame(CGRectMake(179, 299, 82, 82));
    
    [img drawInRect:CGRectMake(180, 300, 80, 80)];//拉伸
    [img drawAsPatternInRect:CGRectMake(50, 450, 100, 100)];//平铺
}





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.//注意这句默认自带的注释，如果在drawrect方法中没有任何代码将会降低界面有动画时候的性能！所以系统默认都是把它注释掉的。
- (void)drawRect:(CGRect)rect {
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self lineDrawing:context];
    [self rectDrawing:context];
    [self circleDrawing:context];
    [self arcDrawing:context];
    [self textDrawing:context];
    [self imageDrawing:context];
    
}

@end
