//
//  EgLabel.m
//  Cocotouch
//
//

#import "EgLabel.h"

@implementation EgLabel
@synthesize paddingLeft, paddingTop, paddingRight, paddingBottom;

- (void)drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = {paddingTop, paddingLeft, paddingBottom, paddingRight};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
