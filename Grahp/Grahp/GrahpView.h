//
//  GrahpView.h
//  Grahp
//
//  Created by Mastra on 2017/12/4.
//

#import <UIKit/UIKit.h>
#import "POP.h"

@interface GrahpView : UIView
{
    NSMutableArray *curvePoint;
    CAShapeLayer *curveLayer;
}

@property (nonatomic,copy)NSArray *curveInformationPoint;

-(id)initWithCenter:(CGPoint)center;
//@property (nonatomic, copy) void (^textFieldShouldReturn)(NSString *searchText);
@end
