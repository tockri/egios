//
//  UILabel+Util.m
//  MetalGearTwid
//
//  Created by 藤田正訓 on 2012/08/22.
//  Copyright (c) 2012年 SAT. All rights reserved.
//

#import "UILabel+Util.h"
#import "egios_ui.h"

@implementation UILabel (Util)

// 内容に応じてサイズを変更する。
-(void)eFitWidthToText {
    CGSize sz = [self.text sizeWithFont:self.font];
    self.width = sz.width;
}

// 内容に応じてサイズを変更する。
-(void)eFitHeightToText:(CGFloat)width {
    if (width > 0) {
        CGSize cst = CGSizeMake(width, 99999);
        CGSize sz = [self.text sizeWithFont:self.font
                      constrainedToSize:cst
                              lineBreakMode:self.lineBreakMode];
        self.height = sz.height;
    }
}

@end
