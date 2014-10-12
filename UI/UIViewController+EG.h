//
//  UIViewController+EG.h
//  PicPages
//
//  Created by 藤田正訓 on 2012/10/17.
//  Copyright (c) 2012年 tockri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (EG)
// storyboard-idを使用してUIViewControllerを生成して上にかぶせる
-(id)eAddPane:(NSString*)storyBoardId;
// eAddPaneでかぶさっているUIViewControllerをフェードアウトしてはずす
-(void)eRemovePaneFromParent;
// storyboard-idを使用してPopOverを表示する
-(UIPopoverController*)ePopoverPane:(NSString*)storyBoardId on:(UIBarButtonItem*)button;

// 戻る
-(void)ePop;
// 素早く戻る
-(void)ePopFast;
@end
