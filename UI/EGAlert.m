//
//  AlertDialog.m
//  ForIPad
//
//  11/07/18.

//

#import "EGAlert.h"
#import "EGAlertInnerView.h"
#import "VertButtonsAlertView.h"
#import "EG.h"
#import "EG_ui.h"

@interface EGAlert()
@property(copy) void (^onOK)();
@property(copy)void (^onOKPrompt)(NSString* str);
@property(copy)void (^onCancel)();
@property(copy)void (^onClose)(NSInteger idx);
@property(assign)BOOL isAlert;
@property(strong) UITextField* textField;
@end



@implementation EGAlert
@synthesize textField, onOK, onClose, onCancel, onOKPrompt, isAlert;

static NSMutableSet* showingMessages;
static NSMutableSet* showingDelegates;

#pragma mark - UIAlertViewDelegate

-(id)init {
    self = [super init];
    if (!showingDelegates) {
        showingDelegates = [[NSMutableSet alloc]init];
    }
    [showingDelegates addObject:self];
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString* elem = [alertView.title eAdd:alertView.message];
    [showingMessages removeObject:elem];
    if (onClose) {
        onClose(buttonIndex);
    } if (buttonIndex == 0) {
        if (onCancel) {
            onCancel();
        } else if (isAlert && onOK) {
            onOK();
        }
    } else {
        if (onOK) {
            onOK();
        } else if (onOKPrompt) {
            onOKPrompt(textField.text);
        }
    }
    self.onCancel = nil;
    self.onOK = nil;
    self.onClose = nil;
    self.onOKPrompt = nil;
    self.textField = nil;
    alertView.delegate = nil;
    [showingDelegates removeObject:self];
}



#pragma mark - static methods

+(BOOL)hasShown:(NSString*)title message:(NSString*)message {
    if (!showingMessages) {
        showingMessages = [[NSMutableSet alloc]init];
    }
    NSString* elem = [title eAdd:message];
    if ([showingMessages containsObject:elem]) {
        return YES;
    } else {
        [showingMessages addObject:elem];
        return NO;
    }
}


// ボタンの複数あるアラートダイアログを表示する
+(void)alert:(NSString *)title
     message:(NSString *)message
     onClose:(void (^)(NSInteger))onCloseCallback
     buttons:(NSArray *)buttons{
    if ([self hasShown:title message:message]) {
        return;
    }
    EGAlert* ad = [[EGAlert alloc]init];
    ad.onClose = onCloseCallback;
    ad.isAlert = YES;
    
    VertButtonsAlertView* alert = [[VertButtonsAlertView alloc]init];
    alert.title = title;
    alert.message = message;
    alert.delegate = ad;
    
    for (NSString* b in buttons) {
        [alert addButtonWithTitle:b];
    }
    if (buttons.count == 2) {
        [alert addButtonWithTitle:@"  "];
    }
    alert.cancelButtonIndex = buttons.count;
    [alert show];
}


// アラートダイアログを表示する
+ (void)alert:(NSString*)title 
      message:(NSString*)message 
         onOK:(void (^)())onOKCallback {
    if ([self hasShown:title message:message]) {
        return;
    }
    EGAlert* ad = [[EGAlert alloc]init];
    ad.onOK = onOKCallback;
    ad.isAlert = YES;
    UIAlertView* alert = [[UIAlertView alloc]
                          initWithTitle:title 
                          message:message 
                          delegate:ad
                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                          otherButtonTitles:nil, nil];
    [alert show];
}

// 確認ダイアログを表示する
+ (void)confirm:(NSString*)title
        message:(NSString*)message
           onOK:(void (^)())onOKCallback {
    if ([self hasShown:title message:message]) {
        return;
    }
    EGAlert* ad = [[EGAlert alloc]init];
    ad.onOK = onOKCallback;
    ad.isAlert = NO;
    UIAlertView* alert = [[UIAlertView alloc]
                          initWithTitle:title 
                          message:message 
                          delegate:ad
                          cancelButtonTitle:NSLocalizedString(@"cancel",nil) 
                          otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
    [alert show];
}

// 確認ダイアログを生成する
+ (void)confirm:(NSString*)title 
        message:(NSString*)message 
           onOK:(void (^)())onOKCallback
       onCancel:(void (^)())onCancelCallback {
    if ([self hasShown:title message:message]) {
        return ;
    }
    EGAlert* ad = [[EGAlert alloc]init];
    ad.onOK = onOKCallback;
    ad.onCancel = onCancelCallback;
    
    UIAlertView* alert = [[UIAlertView alloc]
                          initWithTitle:title 
                          message:message 
                          delegate:ad
                          cancelButtonTitle:NSLocalizedString(@"cancel",nil) 
                          otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
    [alert show];
}

// 確認ダイアログを生成する
+ (void)confirm:(NSString*)title
        message:(NSString*)message
           onOK:(void (^)())onOKCallback
       onCancel:(void (^)())onCancelCallback
        okLabel:(NSString*)okLabel
    cancelLabel:(NSString*)cancelLabel {
    if ([self hasShown:title message:message]) {
        return;
    }
    EGAlert* ad = [[EGAlert alloc]init];
    ad.onOK = onOKCallback;
    ad.onCancel = onCancelCallback;
    ad.isAlert = NO;
    UIAlertView* alert = [[UIAlertView alloc]
                          initWithTitle:title 
                          message:message 
                          delegate:ad
                          cancelButtonTitle:cancelLabel
                          otherButtonTitles:okLabel, nil];
    [alert show];
}

// テキスト入力プロンプトを生成する
+ (void)prompt:(NSString*)title
       message:(NSString*)message
          onOK:(void (^)(NSString* str))onOKCallback
      onCancel:(void(^)())onCancelCallback {
    if ([self hasShown:title message:message]) {
        return;
    }
    EGAlert* ad = [[EGAlert alloc]init];
    ad.onOKPrompt = onOKCallback;
    ad.onCancel = onCancelCallback;
    
    EGAlertInnerView* alert = [[EGAlertInnerView alloc]
                          initWithTitle:title 
                          message:message 
                          delegate:ad
                          cancelButtonTitle:NSLocalizedString(@"cancel",nil) 
                          otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
    ad.textField = alert.textField;
    [alert show];
}


// テキスト入力プロンプトを生成する
+ (void)prompt:(NSString*)title
       message:(NSString*)message
       initial:(NSString*)initial
          onOK:(void (^)(NSString* str))onOKCallback
      onCancel:(void(^)())onCancelCallback {
    if ([self hasShown:title message:message]) {
        return;
    }
    EGAlert* ad = [[EGAlert alloc]init];
    ad.onOKPrompt = onOKCallback;
    ad.onCancel = onCancelCallback;
    
    EGAlertInnerView* alert = [[EGAlertInnerView alloc]
                            initWithTitle:title 
                            message:message 
                            delegate:ad
                            cancelButtonTitle:NSLocalizedString(@"cancel",nil) 
                            otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
    ad.textField = alert.textField;
    alert.textField.text = initial;
    [alert show];
}



@end
