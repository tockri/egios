//
//  UILabel+Util.h
//  MetalGearTwid
//
//  Created by 藤田正訓 on 2012/08/22.
//  Copyright (c) 2012年 SAT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Util)
// 内容に応じてサイズを変更する。
-(void)eFitWidthToText;
// 内容に応じてサイズを変更する。
-(void)eFitHeightToText:(CGFloat)width;
@end
