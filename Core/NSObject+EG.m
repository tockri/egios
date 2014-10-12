//
//  NSObject_Util.m
//  EpubScratch
//
//  11/08/31.

//

#import "NSObject+EG.h"

@implementation NSObject(EG)

// allocしてinitして返す
+(id)eNew {
    return [[self alloc]init];
}
@end
