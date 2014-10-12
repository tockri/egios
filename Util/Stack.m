//
//  Stack.m
//  Cocotouch
//
//  11/09/14.

//

#import "Stack.h"
#import "EG.h"

@interface Stack()
@property(nonatomic,strong)NSMutableArray* array;
@end

@implementation Stack
@synthesize array;

// 末尾に加える
-(void)push:(id)elem {
    [array addObject:elem];
}
// 最後に加えた要素を削除して返す
-(id)pop {
    int c = [array count];
    if (c > 0) {
        id elem = [array eAt:c - 1];
        [array removeObjectAtIndex:c - 1];
        return elem;
    } else {
        return nil;
    }
}
// 最後に加えた要素を返す
-(id)peek {
    int c = [array count];
    if (c > 0) {
        return [array eAt:c - 1];
    } else {
        return nil;
    }
}

-(NSInteger)count {
    return [array count];
}


#pragma mark - object lifecycle

-(id)init {
    self = [super init];
    if (self) {
        self.array = [NSMutableArray array];
    }
    return self;
}
@end
