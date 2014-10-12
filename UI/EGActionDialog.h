//
//  ActionDialog.h
//  ForIphone
//  ActionSheetのblock版
//  11/07/27.

//

#import <UIKit/UIKit.h>


@interface EGActionDialog : UIActionSheet<UIActionSheetDelegate> {
    @private
    void (^onSelected)(NSInteger index);
}

-(id)initWithTitle:(NSString *)title 
 cancelButtonTitle:(NSString *)cancelButtonTitle 
destructiveButtonTitle:(NSString *)destructiveButtonTitle 
 otherButtonTitles:(NSArray*)buttonTitles 
          callback:(void (^)(NSInteger index))onSelectCallback;

- (id)initWithTitle:(NSString *)title 
  otherButtonTitles:(NSArray *)buttonTitles
           callback:(void (^)(NSInteger))onSelectCallback;


@end
