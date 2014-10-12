//
//  NSArray_Util.m
//  ForIphone
//
//  11/08/17.

//

#import "NSArray+EG.h"


@implementation NSArray(EG)
-(id)eAt:(NSInteger)idx {
    if (0 <= idx && idx < self.count) {
        return [self objectAtIndex:idx];
    } else {
        return nil;
    }
}

-(id)eFirst {
    return [self count] > 0 ? [self objectAtIndex:0] : nil;
}
-(id)eLast {
    int c = [self count];
    return c > 0 ? [self objectAtIndex:c - 1] : nil;
}

-(NSString*)eJoin:(NSString *)delim {
    return [self componentsJoinedByString:delim];
}

-(NSArray*)eDicSort {
    return [self sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(BOOL)eHas:(id)obj {
    return [self containsObject:obj];
}
@end


@implementation NSMutableArray(EG)

-(void)eAdd:(id)obj {
    [self addObject:obj];
}


// 並べ替える
-(void)eMove:(NSInteger)from to:(NSInteger)to {
    id b = [self eAt:from];
    [self removeObjectAtIndex:from];
    if (to < [self count]) {
        [self insertObject:b atIndex:to];
    } else {
        [self addObject:b];
    }
}

@end


NSMutableArray* eArray(id obj, ...) {
    va_list args;
    va_start(args, obj);
    NSMutableArray* ar = [NSMutableArray arrayWithObject:obj];
    while ((obj = va_arg(args, id))) {
        [ar addObject:obj];
    }
    va_end(args);
    return ar;
}

// MutableArrayのオブジェクトを生成して返す
NSMutableArray* eMArray(NSArray* arr) {
    return [NSMutableArray arrayWithArray:arr];
}