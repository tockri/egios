//
//  UIWebView_EG.h

//

#import <UIKit/UIKit.h>


@interface UIWebView(EG)

// ロードが終わっていればdocument.titleを返す
@property(nonatomic,readonly)NSString* title;
@property(readonly)UIScrollView* eScrollView;

// ファイルをロードする
-(void)loadFile:(NSString*)path;
// JavaScriptを実行する
-(NSString*)evalJs:(NSString*)js;

// URLをロードする
-(void)loadUrl:(NSString*)urlStr;
// ローカルにあるスクリプトファイルを実行する
-(void)loadLocalScriptFile:(NSString*)path;

@end
