//
//  NSDictionary_Util.h
//  Cocotouch
//
//  11/10/26.

//

#import <Foundation/Foundation.h>

@interface NSDictionary(EG)
// valueForKeyのエイリアス
-(id)eAt:(NSString*)key;

@end


@interface NSMutableDictionary(EG)
// setValueのエイリアス
-(void)eSet:(NSString*)key :(id)value;
// keyに対応するNSArrayに対してvalueを追加する
-(void)eAddtoArray:(NSString*)key :(id)value;
@end


NSMutableDictionary* eMDic(NSDictionary* dic);