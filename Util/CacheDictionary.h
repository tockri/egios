//
//  CacheDictionary.h
//  Cocotouch
//
//  11/09/12.

//

#import <Foundation/Foundation.h>


@interface CacheDictionary : NSObject 
// キャッシュする最大数
@property(nonatomic,assign)NSInteger cacheSize;
// キャッシュから取り出して先頭に置く
-(id)get:(NSString*)name;
// キャッシュ先頭にセットし、最大数を超えたぶんを削除する
-(void)set:(id)item forName:(NSString*)name;
// キャッシュを削除する
-(void)remove:(NSString*)name;
// キーの前方一致で削除する
-(void)removeMatched:(NSString*)prefix;
// キャッシュを全て削除する
-(void)purge;
@end
