//
//  UIWebView_EG.m
//

#import "UIWebView+EG.h"
#import "EGFile.h"
#import "EG.h"

@implementation UIWebView(EG)
// ロードが終わっていればdocument.titleを返す
-(NSString*)title {
    if (!self.loading) {
        return [self evalJs:@"document.title"];
    } else {
        return nil;
    }
}

-(UIScrollView *)eScrollView {
    for (UIView* v in self.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView*)v;
        }
    }
    return nil;
}

// URLをロードする
-(void)loadUrl:(NSString*)urlStr {
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLRequest* req = [[NSURLRequest alloc]initWithURL:url];
    [self loadRequest:req];    
}

// HTMLファイルをロードする
-(void)loadFile:(NSString*)path {
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* req = [[NSURLRequest alloc]initWithURL:url];
    [self loadRequest:req];
}


// ローカルにあるスクリプトファイルを実行する
-(void)loadLocalScriptFile:(NSString*)path {
    [self evalJs:[EGFile read:path]];
}


// JavaScriptを実行する
-(NSString*)evalJs:(NSString*)js {
    js = eJoin(@"try{", js, @"}catch(e){}", nil);
    NSString* result = [self stringByEvaluatingJavaScriptFromString:js];
    
    return result;
}
@end
