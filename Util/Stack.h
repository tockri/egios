//
//  Stack.h
//  Cocotouch
//
//  11/09/14.

//

#import <Foundation/Foundation.h>


@interface Stack : NSObject 
// 末尾に加える
-(void)push:(id)elem;
// 最後に加えた要素を削除して返す
-(id)pop;
// 最後に加えた要素を返す
-(id)peek;
// 要素数を返す
-(NSInteger)count;
@end
