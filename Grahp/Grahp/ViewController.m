//
//  ViewController.m
//  Grahp
//
//  Created by Mastra on 2017/12/4.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>


@interface ViewController ()
{
    
}
@property(nonatomic,strong)CMPedometer *setpcount;
@property(nonatomic,assign)int mySetp;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    grahp = [[GrahpView alloc] initWithCenter:self.view.center];
    [self.view addSubview:grahp];
    
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x-100, 50, 200, 50)];
    testBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
    [testBtn setTitle:@"刷新数据" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:82.0f/255.0f blue:82.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(testBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    
    /*
    //HTML解析
    NSMutableAttributedString * content = [[NSMutableAttributedString alloc] initWithData:[self.model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, content.length-1)];
    */
    
}


-(void)testBtnClicked
{
    grahp.curveInformationPoint = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0,(arc4random() % 6))],
                                   [NSValue valueWithCGPoint:CGPointMake(1,(arc4random() % 6))],
                                   [NSValue valueWithCGPoint:CGPointMake(2,(arc4random() % 6))],
                                   [NSValue valueWithCGPoint:CGPointMake(3,(arc4random() % 6))],
                                   [NSValue valueWithCGPoint:CGPointMake(4,(arc4random() % 6))],
                                   [NSValue valueWithCGPoint:CGPointMake(5,(arc4random() % 6))],nil];
}

#pragma mark 计步

-(void)testMath
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        [self.setpcount startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
//            if (error == nil)
//            {
//                NSNumber *count = pedometerData.numberOfSteps;
//                NSLog(@"步数：%d",[count intValue]);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self->_testLabel.text = [NSString stringWithFormat:@"你现在的步数是：%d",count.intValue/*self->_mySetp*/];
//                });
//            }
//            else
//            {
//                NSLog(@"error");
//            }
//        }];
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
