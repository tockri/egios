//
//  AlertDialog.h
//  ForIPad
//
//  11/07/18.

//

#import <UIKit/UIKit.h>


@interface EGAlert : NSObject<UIAlertViewDelegate> {
}

// ボタンの複数あるアラートダイアログを表示する
+ (void)alert:(NSString*)title
      message:(NSString*)message
      onClose:(void (^)(NSInteger idx))onCloseCallback
      buttons:(NSArray*)buttons;


// アラートダイアログを表示する
+ (void)alert:(NSString*)title 
      message:(NSString*)message 
         onOK:(void (^)())onOKCallback;

// 確認ダイアログを表示する
+ (void)confirm:(NSString*)title
        message:(NSString*)message
           onOK:(void (^)())onOKCallback;

// 確認ダイアログを生成する
+ (void)confirm:(NSString*)title 
        message:(NSString*)message 
           onOK:(void (^)())onOKCallback
       onCancel:(void (^)())onCancelCallback;

// 確認ダイアログを生成する
+ (void)confirm:(NSString*)title
        message:(NSString*)message
           onOK:(void (^)())onOKCallback
       onCancel:(void (^)())onCancelCallback
        okLabel:(NSString*)okLabel
    cancelLabel:(NSString*)cancelLabel;



// テキスト入力プロンプトを生成する
+ (void)prompt:(NSString*)title
       message:(NSString*)message
          onOK:(void (^)(NSString* str))onOKCallback
      onCancel:(void(^)())onCancelCallback;

// テキスト入力プロンプトを生成する
+ (void)prompt:(NSString*)title
       message:(NSString*)message
       initial:(NSString*)initial
          onOK:(void (^)(NSString* str))onOKCallback
      onCancel:(void(^)())onCancelCallback;

@end
