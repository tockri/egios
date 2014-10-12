//
//  NSMutableData+Util.h
//  MetalGearTwid
//
//  Created by 藤田正訓 on 2012/09/22.
//  Copyright (c) 2012年 SAT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData (Util)
// いくつものオブジェクトを追加する
-(void)appendMulti:(id)val, ... NS_REQUIRES_NIL_TERMINATION;
@end
