//
//  NSString_Util.h
//  ForIphone
//
//  11/08/13.

//

#import <Foundation/Foundation.h>


@interface NSString(EG)

// 文字列連結
-(NSString*)eAdd:(NSString*)str;
// パス結合
-(NSString*)eAddPath:(NSString*)str;
// ディレクトリだけ除く
-(NSString*)eFname;
// ディレクトリと拡張子を除く
-(NSString*)eBname;
// ファイル名を除く
-(NSString*)eDname;
// 拡張子を返す
-(NSString*)eExt;
// 大文字にする
-(NSString*)eUpper;
// 小文字にする
-(NSString*)eLower;
// 等しいかどうか
-(BOOL)eEq:(NSString*)str;
// 大文字小文字を無視して等しいかどうか
-(BOOL)eiEq:(NSString*)str;
// 含むかどうか
-(BOOL)eContains:(NSString*)str;
// MD5ハッシュ文字列を生成する
-(NSString*)eMd5;
// URLエンコード
-(NSString*)eUrlEncode;
// URLデコード
-(NSString*)eUrlDecode;
// Base64エンコード
-(NSString*)eBase64Encode;
// Base64デコード
-(NSString*)eBase64Decode;
// 正規表現に一致するかどうかを返す
-(BOOL)eIsMatch:(NSString*)pattern;
// 正規表現に一致する部分を返す
-(NSArray*)eMatch:(NSString*)pattern;
// 正規表現に一致する部分をすべて返す
-(NSArray*)eMatches:(NSString*)pattern;
// 正規表現に一致する部分のRangeの配列を返す
-(NSArray*)eMatchRanges:(NSString*)pattern;
// 正規表現に一致する部分をすべて置換する
-(NSString*)eReplace:(NSString*)pattern to:(NSString*)to ;
// 文字列セット置換
-(NSString*)eReplaceSet:(NSArray*)fromArray to:(NSArray*)toArray;
// HTMLエンティティのエスケープ
-(NSString*)eHtmlEscape;
// SQLエスケープ
-(NSString*)eSqlEscape;
// JavaScriptで使えるようにエスケープする
-(NSString*)eJsEscape;
// 分割する
-(NSArray*)eSplit:(NSString*)delim;

-(NSString*)eSanitize;
// 短くする
-(NSString*)eTruncate:(NSInteger)len;
// NSDataに変換する
-(NSData*)eToData;
// NSDataから生成する
+(NSString*)eFromData:(NSData*)data;



@end
// 文字列を連結する
NSString* eJoin(NSString* str, ...);
// nilだったら空文字を返す
NSString* eEmp(NSString* str);

// NSLocalizedStringのエイリアス
NSString* eRes(NSString* name);
// DateFormatter
NSString* eDatetimeFormatStr(NSDate* d, NSString* format);
// SQL用クオート済み文字列
NSString* eSqlQuote(NSString* s);
// 時刻
NSString* eTimeStr(NSDate* d);
// 日付文字列に変換
NSString* eDateStr(NSDate* d);
// 年月日、時分
NSString* eMinuteStr(NSDate* d);
// 数値
NSString* eIntStr(NSInteger i);
// 数値
NSString* eLongStr(unsigned long ul);
// 数値
NSString* eFormatIntStr(NSInteger i);
// 数値
NSString* eFloatStr(CGFloat f);
// 文字列から時刻に変換
NSDate* eStrTime(NSString* str);
// XML形式の文字列から時刻に変換
NSDate* eXMLStrTime(NSString* str);

#define eFormat( args... ) [NSString stringWithFormat:args ]


