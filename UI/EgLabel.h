//
//  EgLabel.h
//  Cocotouch
//
//

#import <UIKit/UIKit.h>

// 細かい表示の設定ができる、UILabel派生クラス
@interface EgLabel : UILabel {
    @private
    CGFloat paddingTop;
    CGFloat paddingLeft;
    CGFloat paddingRight;
    CGFloat paddingBottom;
}
@property(nonatomic,assign)CGFloat paddingTop;
@property(nonatomic,assign)CGFloat paddingLeft;
@property(nonatomic,assign)CGFloat paddingRight;
@property(nonatomic,assign)CGFloat paddingBottom;
@end
