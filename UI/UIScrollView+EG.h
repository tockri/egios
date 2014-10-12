//
//  UIScrollView_EG.h
//  Cocotouch
//
//

#import <UIKit/UIKit.h>


@interface UIScrollView(EG)

@property(readwrite)CGFloat eScrollX;
@property(readwrite)CGFloat eScrollY;

@property(readwrite)CGFloat eContentWidth;
@property(readwrite)CGFloat eContentHeight;

-(void)eAnimScrollX:(CGFloat)x;
-(void)eAnimScrollY:(CGFloat)y;
@end
