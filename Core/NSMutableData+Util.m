//
//  NSMutableData+Util.m
//  MetalGearTwid
//
//  Created by 藤田正訓 on 2012/09/22.
//  Copyright (c) 2012年 SAT. All rights reserved.
//

#import "NSMutableData+Util.h"
#import "NSString_Util.h"

@implementation NSMutableData (Util)
-(void)appendMulti:(id)val, ... {
    va_list arguments;
    va_start(arguments, val);
    while (val) {
        if ([val isKindOfClass:[NSString class]]) {
            NSString* strVal = val;
            [self appendData:strVal.eToData];
            
        } else if ([val isKindOfClass:[NSNumber class]]) {
            NSNumber* nval = val;
            [self appendData:nval.stringValue.eToData];
            
        } else if ([val isKindOfClass:[NSData class]]) {
            [self appendData:(NSData*)val];
        }
        val = va_arg(arguments, typeof(id));
    }
    va_end(arguments);
}
@end
