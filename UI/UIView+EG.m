//
//  ViewEG.m
//  ForIphone
//
//  11/08/12.

//

#import "UIView+EG.h"
#import "EG.h"
#import <QuartzCore/QuartzCore.h>

#define ANIM_DURATION 0.3

@implementation UIView(EG)


-(CGFloat)left {
    return self.frame.origin.x;
}
-(void)setLeft:(CGFloat)left {
    [self eMove:left :self.top];
}
-(CGFloat)top {
    return self.frame.origin.y;
}
-(void)setTop:(CGFloat)top {
    [self eMove:self.left :top];
}
-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
-(void)setRight:(CGFloat)right {
    [self eSize:right - self.left :self.height];
}
-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
-(void)setBottom:(CGFloat)bottom {
    [self eSize:self.width :bottom - self.top];
}
-(CGFloat)width {
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width {
    [self eSize:width :self.height];
}
-(CGFloat)height {
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height {
    [self eSize:self.width :height];
}
-(CGFloat)centerX {
    return self.left + self.width / 2;
}
-(void)setCenterX:(CGFloat)centerX {
    [self eMove:centerX - self.width / 2 :self.top];
}
-(CGFloat)centerY {
    return self.frame.origin.y + self.frame.size.height / 2;    
}
-(void)setCenterY:(CGFloat)centerY {
    [self eMove:self.left :centerY - self.height / 2];
}

// 移動
-(void)eMove:(CGFloat)x :(CGFloat)y {
    CGRect rc = self.frame;
    rc.origin.x = x;
    rc.origin.y = y;
    self.frame = rc;
}
// 移動
-(void)eMove:(CGPoint)p {
    [self eMove:p.x :p.y];
}
// 移動
-(void)eCenter:(CGFloat)x :(CGFloat)y {
    [self setCenter:CGPointMake(x, y)];
}
-(void)eCenter:(CGPoint)p {
    [self setCenter:p];
}

// 相対移動
-(void)eOffset:(CGFloat)x :(CGFloat)y {
    CGRect rc = self.frame;
    rc.origin.x += x;
    rc.origin.y += y;
    self.frame = rc;
}
// サイズ変更
-(void)eSize:(CGFloat)width :(CGFloat)height {
    CGRect rc = self.frame;
    rc.size.width = width;
    rc.size.height = height;
    self.frame = rc;
}
// サイズ変更
-(void)eSize:(CGSize)size {
    [self eSize:size.width :size.height];
}

// 拡大縮小して右下座標を決める。限界となるサイズを設定しておく。
-(void)eSetRight:(CGFloat)right bottom:(CGFloat)bottom minSize:(CGSize)minSize {
    CGFloat w = MAX(minSize.width, right - self.left);
    CGFloat h = MAX(minSize.height, bottom - self.top);
    [self eSize:w :h];
}


// 同じサイズにする
-(void)eSameSize:(UIView*)view {
    [self eSize:view.width :view.height];
}

// 親に合わせる
-(void)eFittoSuperview {
    UIView* sv = [self superview];
    if (sv) {
        CGRect rc = sv.frame;
        rc.origin.x = 0;
        rc.origin.y = 0;
        if (![EG isForIpad] && [sv isKindOfClass:[UIWindow class]]) {
            // UIWindowはPortraitのsizeを返すので
            UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
            if (orientation == UIInterfaceOrientationLandscapeLeft
                || orientation == UIInterfaceOrientationLandscapeRight) {
                CGFloat w = rc.size.width;
                rc.size.width = rc.size.height;
                rc.size.height = w;
            }
        }
        self.frame = rc;
    }
}
// 左端による
-(void)eFitLeft:(BOOL)fitHeight {
    CGRect rc = self.frame;
    rc.origin.x = 0;
    if (fitHeight) {
        rc.origin.y = 0;
        rc.size.height = [self superview].frame.size.height;
    }
    self.frame = rc;
}
// 上端に寄せる
-(void)eFitTop:(BOOL)fitWidth {
    CGRect rc = self.frame;
    rc.origin.y = 0;
    if (fitWidth) {
        rc.origin.x = 0;
        rc.size.width = [self superview].frame.size.width;
    }
    self.frame = rc;
}
// 右端に寄せる
-(void)eFitRight:(BOOL)fitHeight {
    CGSize ssz = [self superview].frame.size;
    CGRect rc = self.frame;
    rc.origin.x = ssz.width - rc.size.width;
    if (fitHeight) {
        rc.origin.y = 0;
        rc.size.height = ssz.height;
    }
    self.frame = rc;
}
// 下端に寄せる
-(void)eFitBottom:(BOOL)fitWidth {
    CGSize ssz = [self superview].frame.size;
    CGRect rc = self.frame;
    rc.origin.y = ssz.height - rc.size.height;
    if (fitWidth) {
        rc.origin.x = 0;
        rc.size.width = [self superview].frame.size.width;
    }
    self.frame = rc;
}

// 座標を含むかどうか
-(BOOL)eContains:(CGPoint)p {
    CGPoint lt = self.frame.origin;
    CGSize sz = self.frame.size;
    return (lt.x <= p.x && p.x < lt.x + sz.width)
    && (lt.y <= p.y && p.y < lt.y + sz.height);
}

// 指定したクラスの親
-(UIView*)eClosest:(Class)cls {
    for (UIView* v = self.superview; v; v = v.superview) {
        if ([v isKindOfClass:cls]) {
            return v;
        }
    }
    return nil;
}


#pragma mark - effect
-(void)eFadeout:(void (^)())complete {
    if (!self.hidden) {
        self.alpha = 1;
        [UIView animateWithDuration:ANIM_DURATION
                         animations:^{
                             self.alpha = 0;
                         }completion:^(BOOL finished) {
                             self.hidden = YES;
                             if (complete) {
                                 complete();
                             }
                         }];
    }
}
// フェードアウト
-(void)eFadeout {
    [self eFadeout:nil];
}
-(void)eFadein:(void (^)())complete {
    if (self.hidden) {
        self.alpha = 0;
        self.hidden = NO;
        [UIView animateWithDuration:ANIM_DURATION
                         animations:^{
                             self.alpha = 1;
                         }completion:^(BOOL finished) {
                             if (complete) {
                                 complete();
                             }
                         }];
        
    }
}
// フェードイン
-(void)eFadein {
    [self eFadein:nil];
}
-(void)eHidetoTop:(void (^)())complete {
    if (!self.hidden) {
        [self eFitTop:NO];
        [UIView animateWithDuration:ANIM_DURATION animations:^{
            [self eOffset:0 :-self.frame.size.height];
        }completion:^(BOOL finished) {
            self.hidden = YES;
            if (complete) {
                complete();
            }

        }];
    }
}
// 上端に隠す
-(void)eHidetoTop {
    [self eHidetoTop:nil];
}
-(void)eHidetoBottom:(void (^)())complete {
    if (!self.hidden) {
        [self eFitBottom:NO];
        [UIView animateWithDuration:ANIM_DURATION animations:^{
            [self eOffset:0 :self.frame.size.height];
        }completion:^(BOOL finished) {
            self.hidden = YES;
            if (complete) {
                complete();
            }

        }];
    }
    
}
// 下端に隠す
-(void)eHidetoBottom {
    [self eHidetoBottom:nil];
}

-(void)eShowFromTop:(void (^)())complete {
    if (self.hidden) {
        [self eFitTop:NO];
        [self eOffset:0 :-self.frame.size.height];
        self.hidden = NO;
        [UIView animateWithDuration:ANIM_DURATION animations:^{
            [self eOffset:0 :self.frame.size.height];
        }completion:^(BOOL finished) {
            if (complete) {
                complete();
            }
        }];
    }
}
// 上端から出現する
-(void)eShowFromTop {
    [self eShowFromTop:nil];
}
-(void)eShowFromBottom:(void (^)())complete {
    if (self.hidden) {
        [self eFitBottom:NO];
        [self eOffset:0 :self.frame.size.height];
        self.hidden = NO;
        [UIView animateWithDuration:ANIM_DURATION animations:^{
            [self eOffset:0 :-self.frame.size.height];
        }completion:^(BOOL finished) {
            if (complete) {
                complete();
            }
        }];
    }
}
// 下端から出現する
-(void)eShowFromBottom {
    [self eShowFromBottom:nil];
}

// ログ出力用フォーマット
-(NSString*)eDesc {
    return [NSString stringWithFormat:@"%0.0f,%0.0f,%0.0f,%0.0f %@",
            self.left,self.top,self.width,self.height,
            (self.hidden ? @"hidden" : @"")];
}
// 角丸にする
-(void)eCornerRadius:(CGFloat)r {
    self.layer.cornerRadius = r;
    self.clipsToBounds = YES;
}


@end
