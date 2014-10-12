//
//  UIScrollView().m
//  Cocotouch
//

#import "UIScrollView+EG.h"

@implementation UIScrollView(EG)
-(CGFloat) eScrollX {
    return self.contentOffset.x;
}
-(void) setEScrollX:(CGFloat)x {
    CGPoint co = self.contentOffset;
    co.x = x;
    self.contentOffset = co;
}
-(void)eAnimScrollX:(CGFloat)x {
    CGPoint co = self.contentOffset;
    co.x = x;
    [self setContentOffset:co animated:YES];
}

-(CGFloat) eScrollY {
    return self.contentOffset.y;
}
-(void) setEScrollY:(CGFloat) y {
    CGPoint co = self.contentOffset;
    co.y = y;
    self.contentOffset = co;    
}
-(void)eAnimScrollY:(CGFloat)y {
    CGPoint co = self.contentOffset;
    co.y = y;
    [self setContentOffset:co animated:YES];
}

-(CGFloat) eContentWidth {
    return self.contentSize.width;
}
- (void)setEContentWidth:(CGFloat)width {
    CGSize sz = self.contentSize;
    sz.width = width;
    self.contentSize = sz;
}

-(CGFloat)eContentHeight {
    return self.contentSize.height;
}
-(void)setEContentHeight:(CGFloat)height {
    CGSize sz = self.contentSize;
    sz.height = height;
    self.contentSize = sz;
}

@end
