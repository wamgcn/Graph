//
//  GrahpView.m
//  Grahp
//
//  Created by Mastra on 2017/12/4.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "GrahpView.h"

@implementation GrahpView

-(id)initWithCenter:(CGPoint)center
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    
    if (self)
    {
//        (arc4random() % 4)
        self.center = center;
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        
//        curvePoint = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*0,155-155/6*3)],
//                           [NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*0,155-155/6*(arc4random() % 5))],
//                           [NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*1,155-155/6*(arc4random() % 5))],
//                           [NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*2,155-155/6*(arc4random() % 5))],
//                           [NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*3,155-155/6*(arc4random() % 5))],
//                           [NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*4,155-155/6*(arc4random() % 5))],
//                           [NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*5,155-155/6*(arc4random() % 5))],
//                           [NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*6,155-155/6*3)],nil];
        
        [self drawCoordinateAxis];
        
        for (int i = 1; i<6; i++)
        {
            [self drawAbscissaAxisWithIndex:i];
            [self addAbscissaAxisLabelWithIndex:i];
            [self drawVerticalAxisWithIndex:i];
        }
        
        for (int i = 0; i<6; i++)
        {
            [self addVerticalLabelWithIndex:i];
        }
        
//        [self drawCurve];
        
    }
    
    return self;
    
}
#pragma mark - 数据处理相关方法

-(void)setCurveInformationPoint:(NSArray *)curveInformationPoint
{
    if (!curvePoint)
    {
        curvePoint = [NSMutableArray array];
    }
    else
    {
        [curvePoint removeAllObjects];
        [curveLayer removeFromSuperlayer];
    }
    
    [curvePoint addObject:[NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*0,155-155/6*3)]];
    
    CGPoint point = CGPointZero;
    
    for (int i = 0; i<curveInformationPoint.count; i++)
    {
        point = [[curveInformationPoint objectAtIndex:i] CGPointValue];
         [curvePoint addObject:[NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*point.x,155-155/6*point.y)]];
    }
    
    [curvePoint addObject:[NSValue valueWithCGPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*6,155-155/6*3)]];
    
    [self drawCurve];
}

#pragma mark - 绘制曲线相关方法
-(void)drawCurve
{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    for (NSInteger i = 0; i < curvePoint.count-3; i++)
    {
        CGPoint p1 = [[curvePoint objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[curvePoint objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[curvePoint objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[curvePoint objectAtIndex:i+3] CGPointValue];
        if (i == 0)
        {
            [linePath moveToPoint:p2];
        }
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:linePath];
    }
    
    //线的样式
    if (!curveLayer)
    {
        curveLayer = [CAShapeLayer layer];
    }
    
    curveLayer.lineWidth = 2;
    curveLayer.strokeColor = [UIColor colorWithRed:255.0f/255.0f green:82.0f/255.0f blue:82.0f/255.0f alpha:1].CGColor;
    curveLayer.path = linePath.CGPath;
    curveLayer.fillColor = nil; // 默认为blackColor
    
    //显示
    [self.layer addSublayer:curveLayer];
    
    [self doAnimation];
}

//计算控制点
- (void)getControlPointx0:(CGFloat)x0 andy0:(CGFloat)y0
                       x1:(CGFloat)x1 andy1:(CGFloat)y1
                       x2:(CGFloat)x2 andy2:(CGFloat)y2
                       x3:(CGFloat)x3 andy3:(CGFloat)y3
                     path:(UIBezierPath*) path{
    CGFloat smooth_value =0.6;
    CGFloat ctrl1_x;
    CGFloat ctrl1_y;
    CGFloat ctrl2_x;
    CGFloat ctrl2_y;
    CGFloat xc1 = (x0 + x1) /2.0;
    CGFloat yc1 = (y0 + y1) /2.0;
    CGFloat xc2 = (x1 + x2) /2.0;
    CGFloat yc2 = (y1 + y2) /2.0;
    CGFloat xc3 = (x2 + x3) /2.0;
    CGFloat yc3 = (y2 + y3) /2.0;
    CGFloat len1 = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
    CGFloat len2 = sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1));
    CGFloat len3 = sqrt((x3-x2) * (x3-x2) + (y3-y2) * (y3-y2));
    CGFloat k1 = len1 / (len1 + len2);
    CGFloat k2 = len2 / (len2 + len3);
    CGFloat xm1 = xc1 + (xc2 - xc1) * k1;
    CGFloat ym1 = yc1 + (yc2 - yc1) * k1;
    CGFloat xm2 = xc2 + (xc3 - xc2) * k2;
    CGFloat ym2 = yc2 + (yc3 - yc2) * k2;
    ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
    ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
    ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
    ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
    [path addCurveToPoint:CGPointMake(x2, y2) controlPoint1:CGPointMake(ctrl1_x, ctrl1_y) controlPoint2:CGPointMake(ctrl2_x, ctrl2_y)];
}

#pragma mark 动画实现
-(void)doAnimation
{
    POPBasicAnimation * curveAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    curveAnimation.fromValue = @(0);
    curveAnimation.toValue = @(1);
    curveAnimation.duration = 2;//动画持续时间
    curveAnimation.removedOnCompletion = NO;
    [curveLayer pop_addAnimation:curveAnimation forKey:@"CurveAnimation"];
}


#pragma mark - 绘制坐标系相关方法

-(void)drawCoordinateAxis
{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(45,0)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(45,155)];
    [linePath addLineToPoint:CGPointMake(SCREEN_WIDTH-15, 155)];
    
    //线的样式
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    
    //显示
    [self.layer addSublayer:lineLayer];
}

//横轴相关
-(void)drawAbscissaAxisWithIndex:(NSInteger)index
{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(45,155-155/6*index)];
    // 终点
    [linePath addLineToPoint:CGPointMake(SCREEN_WIDTH-15,155-155/6*index)];
    //线的样式
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    //显示
    [self.layer addSublayer:lineLayer];
}

-(void)addAbscissaAxisLabelWithIndex:(NSInteger)index
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,(155-155/6*index)-6, 40, 12)];
    label.text = [NSString stringWithFormat:@"%ld",(long)index];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1];
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
}

//纵轴相关
-(void)drawVerticalAxisWithIndex:(NSInteger)index
{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*index,0)];
    // 终点
    [linePath addLineToPoint:CGPointMake(45+(SCREEN_WIDTH-15)/7*index,155)];
    //线的样式
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:3], nil];
    lineLayer.fillColor = nil; // 默认为blackColor
    //显示
    [self.layer addSublayer:lineLayer];
}

-(void)addVerticalLabelWithIndex:(NSInteger)index
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(42+(SCREEN_WIDTH-15)/7*index,167, 40, 12)];
    label.text = [NSString stringWithFormat:@"%ld",(long)index];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1];
//    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
