//
//  ViewController.m
//  Grahp
//
//  Created by Mastra on 2017/12/4.
//

#import "ViewController.h"
#import "GrahpView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GrahpView *grahp = [[GrahpView alloc] initWithCenter:self.view.center];
    [self.view addSubview:grahp];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
