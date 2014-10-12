//
//  NSDictionary_Util.m
//  Cocotouch
//
//  11/10/26.

//
#import "NSDictionary+EG.h"
#import "NSArray+EG.h"

@implementation NSDictionary(EG)
// valueForKeyのエイリアス
-(id)eAt:(NSString*)key {
    return [self valueForKey:key];
}

@end




@implementation NSMutableDictionary(EG)
// setValueのエイリアス
-(void)eSet:(NSString*)key :(id)value {
    [self setValue:value forKey:key];
    
}
// keyに対応するNSArrayに対してvalueを追加する
-(void)eAddtoArray:(NSString *)key :(id)value {
    NSMutableArray* arr = [self eAt:key];
    if (!arr) {
        arr = [NSMutableArray array];
        [self eSet:key :arr];
    }
    [arr eAdd:value];
}
@end


NSMutableDictionary* eMDic(NSDictionary* dic) {
    return [NSMutableDictionary dictionaryWithDictionary:dic];
}