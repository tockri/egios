//
//  LoadingView.h
//  ForIPad
//
//  11/07/31.

//

#import <UIKit/UIKit.h>

@interface EGLoading : UIView {
    @private
    UIActivityIndicatorView* indicator;
}
@property(nonatomic,readonly) UIActivityIndicatorView* indicator;
// 表示する
+ (EGLoading*)show: (UIView*)inView;
+ (EGLoading*)show: (UIView*)inView membrane:(BOOL)membraneVisible;
// 削除する
- (void)dismiss;

@end
