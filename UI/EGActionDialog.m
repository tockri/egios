//
//  ActionDialog.m
//  ForIphone
//
//  11/07/27.

//

#import "EGActionDialog.h"
#import "EG.h"


@implementation EGActionDialog

// 全部入り
-(id)initWithTitle:(NSString *)title 
 cancelButtonTitle:(NSString *)cancelButtonTitle 
destructiveButtonTitle:(NSString *)destructiveButtonTitle 
 otherButtonTitles:(NSArray*)buttonTitles
          callback:(void (^)(NSInteger index))onSelectCallback
{
    self = [super initWithTitle:title
                       delegate:self
              cancelButtonTitle:nil
         destructiveButtonTitle:destructiveButtonTitle
              otherButtonTitles:nil];
    if (self) {
        for (NSString* t in buttonTitles) {
            [self addButtonWithTitle:t];
        }
        onSelected = [onSelectCallback copy];
        if (cancelButtonTitle) {
            // キャンセルボタンを後から足す
            [self addButtonWithTitle:cancelButtonTitle];
            if ([EG isForIpad]) {
                [self addButtonWithTitle:nil];
            }
            NSInteger cnt = [buttonTitles count];
            if (destructiveButtonTitle) {
                cnt++;
            }
            self.cancelButtonIndex = cnt;
        }
    }
    return self;
}

// 簡易版
- (id)initWithTitle:(NSString *)title 
  otherButtonTitles:(NSArray *)buttonTitles 
           callback:(void (^)(NSInteger))onSelectCallback {
    self = [super initWithTitle:title
                       delegate:self
              cancelButtonTitle:nil
         destructiveButtonTitle:nil
              otherButtonTitles:nil];
    if (self) {
        for (NSString* t in buttonTitles) {
            [self addButtonWithTitle:t];
        }
        // キャンセルボタンを後から足す
        [self addButtonWithTitle:NSLocalizedString(@"cancel", nil)];
        if ([EG isForIpad]) {
            [self addButtonWithTitle:nil];
        }
        self.cancelButtonIndex = [buttonTitles count];
        onSelected = [onSelectCallback copy];
    }
    
    return self;
}


-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (onSelected) {
        onSelected(buttonIndex);
    }
}


@end
