//
//  CALayer_Effects.h
//  ForIphone
//
//  11/08/12.

//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface CALayer(Effects)

@property(nonatomic,readwrite)CGFloat left;
@property(nonatomic,readwrite)CGFloat top;
@property(nonatomic,readwrite)CGFloat right;
@property(nonatomic,readwrite)CGFloat bottom;
@property(nonatomic,readwrite)CGFloat width;
@property(nonatomic,readwrite)CGFloat height;
@property(nonatomic,readwrite) CGFloat centerX;
@property(nonatomic,readwrite)CGFloat centerY;

// 移動
-(void)eMove:(CGFloat)x :(CGFloat)y;
// 相対移動
-(void)eOffset:(CGFloat)x :(CGFloat)y;
// サイズ変更
-(void)eSize:(CGFloat)width :(CGFloat)height;
// 同じサイズにする
-(void)eSameSize:(CALayer*)layer;
// 親に合わせる
-(void)eFittoSuperlayer;
// 左端に寄せる
-(void)eFitLeft:(BOOL)fitHeight;
// 上端に寄せる
-(void)eFitTop:(BOOL)fitWidth;
// 右端に寄せる
-(void)eFitRight:(BOOL)fitHeight;
// 下端に寄せる
-(void)eFitBottom:(BOOL)fitWidth;
// フェードアウト
-(void)eFadeout;
// フェードイン
-(void)eFadein;
// 上端に隠す
-(void)eHidetoTop;
// 下端に隠す
-(void)eHidetoBottom;
// 上端から出現する
-(void)eShowFromTop;
// 下端から出現する
-(void)eShowFromBottom;

// ログ出力用フォーマット
-(NSString*)eDesc;

@end
