//
//  CALayer_Effects.m
//  ForIphone
//
//  11/08/12.

//

#import "CALayer+EG.h"

#define ANIM_DURATION 0.3


@implementation CALayer(Effects)

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
    [self eMove:right - self.width :self.top];
}
-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
-(void)setBottom:(CGFloat)bottom {
    [self eMove:self.left :bottom - self.height];
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

// 同じサイズにする
-(void)eSameSize:(CALayer*)layer {
    [self eSize:layer.width :layer.height];
}

// 親に合わせる
-(void)eFittoSuperlayer {
    CGRect rc = [self superlayer].frame;
    rc.origin.x = 0;
    rc.origin.y = 0;
    self.frame = rc;
}
// 左端による
-(void)eFitLeft:(BOOL)fitHeight {
    CGRect rc = self.frame;
    rc.origin.x = 0;
    if (fitHeight) {
        rc.origin.y = 0;
        rc.size.height = [self superlayer].height;
    }
    self.frame = rc;
}
// 上端に寄せる
-(void)eFitTop:(BOOL)fitWidth {
    CGRect rc = self.frame;
    rc.origin.y = 0;
    if (fitWidth) {
        rc.origin.x = 0;
        rc.size.width = [self superlayer].width;
    }
    self.frame = rc;
}
// 右端に寄せる
-(void)eFitRight:(BOOL)fitHeight {
    CGSize ssz = [self superlayer].frame.size;
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
    CGSize ssz = [self superlayer].frame.size;
    CGRect rc = self.frame;
    rc.origin.y = ssz.height - rc.size.height;
    if (fitWidth) {
        rc.origin.x = 0;
        rc.size.width = [self superlayer].width;
    }
    self.frame = rc;
}
// フェードアウト
-(void)eFadeout {
    if (!self.hidden) {
        self.opacity = 1;
        [UIView animateWithDuration:ANIM_DURATION
                         animations:^{
                             self.opacity = 0;
                         }completion:^(BOOL finished) {
                             self.hidden = YES;
                         }];
    }
}
// フェードイン
-(void)eFadein {
    if (self.hidden) {
        self.opacity = 0;
        self.hidden = NO;
        [UIView animateWithDuration:ANIM_DURATION
                         animations:^{
                             self.opacity = 1;
                         }completion:^(BOOL finished) {
                         }];
        
    }
}
// 上端に隠す
-(void)eHidetoTop {
    if (!self.hidden) {
        [self eFitTop:NO];
        [UIView animateWithDuration:ANIM_DURATION animations:^{
            [self eOffset:0 :-self.height];
        }completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
}
// 下端に隠す
-(void)eHidetoBottom {
    if (!self.hidden) {
        [self eFitBottom:NO];
        [UIView animateWithDuration:ANIM_DURATION animations:^{
            [self eOffset:0 :self.height];
        }completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
    
}
// 上端から出現する
-(void)eShowFromTop {
    if (self.hidden) {
        [self eFitTop:NO];
        [self eOffset:0 :-self.height];
        self.hidden = NO;
        [UIView animateWithDuration:ANIM_DURATION animations:^{
            [self eOffset:0 :self.height];
        }completion:^(BOOL finished) {
            
        }];
    }
}
// 下端から出現する
-(void)eShowFromBottom {
    if (self.hidden) {
        [self eFitBottom:NO];
        [self eOffset:0 :self.height];
        self.hidden = NO;
        [UIView animateWithDuration:ANIM_DURATION animations:^{
            [self eOffset:0 :-self.height];
        }completion:^(BOOL finished) {
            
        }];
    }
    
}

// ログ出力用フォーマット
-(NSString*)eDesc {
    return [NSString stringWithFormat:@"%0.0f,%0.0f,%0.0f,%0.0f %@ %@",
            self.left,self.top,self.width,self.height,self.name,
            (self.hidden ? @"hidden" : @"visible")];
}


@end
