//
//  VertButtonsAlertView.m
//  Cocotouch
//
//

#import "VertButtonsAlertView.h"
#import "EG_ui.h"
#import "EG.h"

const CGFloat BUTTON_HEIGHT = 50.0;
const CGFloat BUTTON_WIDTH = 260;
const CGFloat BUTTON_LEFT = 12;
const CGFloat FRAME_BASEHEIGHT = 130;

@implementation VertButtonsAlertView

-(NSInteger) vButtonCount {
    return [[self valueForKey:@"_buttons"]count];
}

// 最後のボタンを非表示にする
-(void)setFrame:(CGRect)frame {
    int cnt = [self vButtonCount];
    if (cnt == 3) {
        frame.size.height = FRAME_BASEHEIGHT + BUTTON_HEIGHT * (cnt - 1);
    }
    RectLog(frame, @"setFrame");
    [super setFrame:frame];
}




-(void)layoutSubviews {
    [super layoutSubviews];
    int cnt = [self vButtonCount];
    if (cnt == 3) {
        int row = 0;
        for (UIView* v in self.subviews) {
            if ([[v class].description hasSuffix:@"Button"]) {
                if (++row == cnt) {
                    v.hidden = YES;
                }
            }
        }
    }
}

@end
