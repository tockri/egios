//
//  Singleton.h
//  Pages
//

#import <Foundation/Foundation.h>
// シングルトンパターンを実現する基底クラス
@interface Singleton : NSObject
// シングルトンを返す
+(id)singleton;
@end
