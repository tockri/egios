//
//  ViewEG.h
//  ForIphone
//
//  11/08/12.

//

#import <UIKit/UIKit.h>

@interface UIView(EG)

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
// 移動
-(void)eMove:(CGPoint)p;
// 移動
-(void)eCenter:(CGFloat)x :(CGFloat)y;
-(void)eCenter:(CGPoint)p;
// 相対移動
-(void)eOffset:(CGFloat)x :(CGFloat)y;
// サイズ変更
-(void)eSize:(CGFloat)width :(CGFloat)height;
// サイズ変更
-(void)eSize:(CGSize)size;
// 拡大縮小して右下座標を決める
-(void)eSetRight:(CGFloat)right bottom:(CGFloat)bottom minSize:(CGSize)minSize ;
// 同じサイズにする
-(void)eSameSize:(UIView*)view;
// 親に合わせる
-(void)eFittoSuperview;
// 左端に寄せる
-(void)eFitLeft:(BOOL)fitHeight;
// 上端に寄せる
-(void)eFitTop:(BOOL)fitWidth;
// 右端に寄せる
-(void)eFitRight:(BOOL)fitHeight;
// 下端に寄せる
-(void)eFitBottom:(BOOL)fitWidth;
// 座標を含むかどうか
-(BOOL)eContains:(CGPoint)p;
// フェードアウト
-(void)eFadeout:(void(^)())complete;
// フェードアウト
-(void)eFadeout;
// フェードイン
-(void)eFadein:(void(^)())complete;
// フェードイン
-(void)eFadein;
// 上端に隠す
-(void)eHidetoTop:(void(^)())complete;
// 上端に隠す
-(void)eHidetoTop;
// 下端に隠す
-(void)eHidetoBottom:(void(^)())complete;
// 下端に隠す
-(void)eHidetoBottom;
// 上端から出現する
-(void)eShowFromTop:(void(^)())complete;
// 上端から出現する
-(void)eShowFromTop;
// 下端から出現する
-(void)eShowFromBottom:(void(^)())complete;
// 下端から出現する
-(void)eShowFromBottom;
// ログ出力用フォーマット
-(NSString*)eDesc;
// 指定したクラスの親を返す
-(UIView*)eClosest:(Class)cls;
// 角丸にする
-(void)eCornerRadius:(CGFloat)r;
@end


