//
//  ViewController.m
//  Grahp
//
//  Created by Mastra on 2017/12/4.
//

#import "ViewController.h"


@interface ViewController ()

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
