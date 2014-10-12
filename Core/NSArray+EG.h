//
//  NSArray_Util.h
//  ForIphone
//
//  11/08/17.

//

#import <Foundation/Foundation.h>


@interface NSArray(EG)
// 最初のオブジェクト
@property(nonatomic,readonly)id eFirst;
// 最後のオブジェクト
@property(nonatomic,readonly)id eLast;

// objectAtIndexのエイリアス
-(id)eAt:(NSInteger)idx;
// 文字列として連結する
-(NSString*)eJoin:(NSString*)delim;
// 辞書順にソートする
-(NSArray*)eDicSort;
// containsObjectのエイリアス
-(BOOL)eHas:(id)obj;
@end


@interface NSMutableArray(EG)
// addObjectのエイリアス
-(void)eAdd:(id)obj;
// 並べ替える。from番目をto番目に移動する
-(void)eMove:(NSInteger)from to:(NSInteger)to;
@end




// [NSArray arrayWithObjects]の代わりに使える
NSMutableArray* eArray(id obj, ...);
// MutableArrayのオブジェクトを生成して返す
NSMutableArray* eMArray(NSArray* arr);