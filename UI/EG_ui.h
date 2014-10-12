//
//  EG_ui.h
//  Cocotouch
//
//  11/09/09.

//
#import "UIView+EG.h"
#import "UIWebView+EG.h"
#import "UIScrollView+EG.h"
#import "UIButton+EG.h"
#import "EgLabel.h"
#import "UIViewController+EG.h"

// InterfaceBuilderのファイルを使ってオブジェクトを生成する。
// @param cls クラス
// @param distinctDevice iPad / iPhoneで別のxibファイルを作ってある場合YES
id eNewFromNib(Class cls, BOOL distinctDevice);