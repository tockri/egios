//
//  UIButton_EG.m
//  PicPages
//
//

#import "UIButton+EG.h"

@implementation UIButton(EG)

-(NSString *)eTitle {
    return [self titleForState:UIControlStateNormal];
}

-(void)setETitle:(NSString *)eTitle {
    [self setTitle:eTitle forState:UIControlStateNormal];
}
@end
