//
//  Singleton.m
//  Pages
//
//

#import "Singleton.h"
#import "EG.h"

static NSMutableDictionary* instances;
@implementation Singleton

// initを禁止する
-(id)init {
    if (instances) {
        NSString* clsName = NSStringFromClass([self class]);
        if ([instances eAt:clsName]) {
            @throw [NSException exceptionWithName:@"SingletonException"
                                           reason:@"init is prohibited."
                                         userInfo:nil];
        }
    }
    self = [super init];
    return self;
}

// シングルトンを返す
+(id)singleton {
    if (!instances) {
        instances = [NSMutableDictionary dictionary];
    }
    NSString* clsName = NSStringFromClass([self class]);
    id s = [instances eAt:clsName];
    if (!s) {
        s = [[self alloc]init];
        [instances eSet:clsName :s];
    }
    return s;
}

@end
