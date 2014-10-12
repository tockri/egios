//
//  LoadingView.m
//  ForIPad
//
//  11/07/31.

//

#import "EGLoading.h"
#import "EG.h"
#import "EG_ui.h"

@implementation EGLoading
@synthesize indicator;

- (id)init {
    self = [super init];
    if (self) {
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:indicator];
    }
    return self;
}

- (void)start:(UIView*)inView {
    [inView addSubview:self];
    [self eFittoSuperview];
    [indicator eCenter:self.center];
    [indicator startAnimating];
}

// 表示する
+ (EGLoading*)show: (UIView*)inView {
    return [self show:inView membrane:YES];
}

+ (EGLoading*)show:(UIView *)inView membrane:(BOOL)membraneVisible {
    if (inView == nil) {
        inView = [EG window];
    }
    EGLoading* lv = [[EGLoading alloc]init];
    [inView addSubview:lv];
    if (membraneVisible) {
        lv.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [lv.indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    } else {
        lv.backgroundColor = [UIColor clearColor];
        [lv.indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
    [lv performSelectorInBackground:@selector(start:) withObject:inView];
    [NSThread sleepForTimeInterval:0.05];
    return lv;
}


// 削除する
- (void)dismiss {
    [indicator stopAnimating];
    indicator = nil;
    [self removeFromSuperview];
}

@end
