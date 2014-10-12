//
//  NSSet+Util.m
//  PicPages
//
//  Created by 藤田正訓 on 2013/03/29.
//  Copyright (c) 2013年 tockri. All rights reserved.
//

#import "NSSet+EG.h"

@implementation NSSet (EG)
// containsObjectのエイリアス
-(BOOL)eHas:(id)obj {
    return [self containsObject:obj];
}
@end



@implementation NSMutableSet(EG)

// addObjectのエイリアス
-(void)eAdd:(id)obj {
    [self addObject:obj];
}

@end


NSMutableSet* eSet(id obj, ...) {
    va_list args;
    va_start(args, obj);
    NSMutableSet* set = [NSMutableSet setWithObject:obj];
    while ((obj = va_arg(args, id))) {
        [set addObject:obj];
    }
    va_end(args);
    return set;
}