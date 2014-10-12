//
//  EG.h

#import <UIKit/UIKit.h>
#import "NSObject+EG.h"
#import "NSString+EG.h"
#import "NSArray+EG.h"
#import "NSDictionary+EG.h"
#import "NSSet+EG.h"

// ファイルに関する便利メソッドを集めたクラス
@interface EG : UIView {
    
}
// 一番上にあるControllerを返す
+(UIViewController*)rootViewController;
// Windowを返す
+(UIWindow*)window;

// 向きを返す
+(BOOL)isPortrait;
+(BOOL)isLandscape;
// iPad向けかどうかを返す
+(BOOL)isForIpad;
+(BOOL)isForIphone;
// リソースのパスを返す
+(NSString*)resPath:(NSString*)subPath;
// ドキュメントディレクトリのパスを返す
+(NSString*)docPath:(NSString*)subPath;
// ライブラリディレクトリのパスを返す
+(NSString*)libPath:(NSString*)subPath;
// キャッシュディレクトリのパスを返す
+(NSString*)cachePath:(NSString*)subPath;
// テンポラリディレクトリのパスを返す
+(NSString*)tmpPath:(NSString*)subPath;
// プロセス中で唯一のオブジェクトを返す
+(NSObject*)mutex;
// 設定値オブジェクトを返す
+(NSUserDefaults*)userDefaults;
// 設定値を返す
+(BOOL)configBool:(NSString*)key;
// 設定値を設定する
+(void)setConfigBool:(BOOL)b forKey:(NSString*)key;
// 設定値を返す
+(NSInteger)configInt:(NSString*)key;
// 設定値を設定する
+(void)setConfigInt:(NSInteger)i forKey:(NSString*)key;

// 設定値を返す
+(id)configValue:(NSString*)key;
// 設定値を設定する
+(void)setConfigValue:(id)v forKey:(NSString*)key;
@end

// BOOL値にする
BOOL eBool(id value);
// int値にする
int eInt(id value);


// NSString値にする
NSString* eString(id value);
#pragma mark - ログ出力マクロ

#ifdef DEBUG

#if !defined(RectLog)
// ログ出力マクロ
#define NSLog( args... ) NSLog( args )
// CGRectログ出力
#define RectLog(rect, message) NSLog(@"%@[%0.1f,%0.1f,%0.1f,%0.1f] / %s", \
message, rect.origin.x, rect.origin.y, \
rect.size.width, rect.size.height, __func__)
// CGSizeログ出力
#define SizeLog(size, message) NSLog(@"%@[%0.1f,%0.1f] / %s", \
message, size.width, size.height, __func__)
#endif

#else

#if !defined (NSLog)
#define NSLog( args... )
#define RectLog(rect, message)
#define SizeLog(size, message)
#endif

#endif
