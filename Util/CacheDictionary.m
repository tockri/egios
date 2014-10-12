//
//  CacheDictionary.m
//  Cocotouch
//
//  11/09/12.

//

#import "CacheDictionary.h"
#import "EG.h"

// エントリー
@interface CacheEntry : NSObject 
@property(strong)NSString* name;
@property(strong)id item;
@end

@implementation CacheEntry
@synthesize name, item;
@end



@implementation CacheDictionary{
@private
    NSMutableArray* array;
}

@synthesize cacheSize;

// キャッシュから取り出して先頭に置く
-(id)get:(NSString*)name {
    int c = [array count];
    for (int i = 0; i < c; i++) {
        CacheEntry* ce = (CacheEntry*)[array eAt:i];
        if ([ce.name eEq:name]) {
            if (i > 0) {
                // 先頭に移動させる
                [array removeObjectAtIndex:i];
                [array insertObject:ce atIndex:0];
            }
            return ce.item;
        }
    }
    return nil;
}

// キャッシュ先頭にセットし、最大数を超えたぶんを削除する
-(void)set:(id)item forName:(NSString*)name {
    CacheEntry* ce = [CacheEntry eNew];
    ce.item = item;
    ce.name = name;
    if ([array count] > 0) {
        [array insertObject:ce atIndex:0];
    } else {
        [array addObject:ce];
    }
    while ([array count] > cacheSize) {
        [array removeObjectAtIndex:[array count] - 1];
    }
}

// キャッシュ削除
-(void)remove:(NSString *)name {
    int c = [array count];
    for (int i = 0; i < c; i++) {
        CacheEntry* ce = (CacheEntry*)[array eAt:i];
        if ([ce.name eEq:name]) {
            [array removeObjectAtIndex:i];
            break;
        }
    }
}

// 前方一致で削除する
-(void)removeMatched:(NSString*)prefix {
    for (CacheEntry* ce in array.reverseObjectEnumerator) {
        if ([ce.name hasPrefix:prefix]) {
            [array removeObject:ce];
        }
    }
}

// キャッシュを全て削除する
-(void)purge {
    [array removeAllObjects];
}

-(id)init {
    self = [super init];
    if (self) {
        array = [NSMutableArray array];
    }
    return self;
}

@end
