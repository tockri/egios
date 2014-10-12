//
//  NSString_Util.m
//  ForIphone
//
//  11/08/13.

//

#import "NSString+EG.h"
#import "EG.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSData+Base64.h"

@implementation NSString(EG)
// 文字列連結
-(NSString*)eAdd:(NSString *)str {
    return str ? [self stringByAppendingString:str] : self;
}
// パス結合
-(NSString*)eAddPath:(NSString*)str {
    return str ? [self stringByAppendingPathComponent:str] : self;
}
// ディレクトリだけ除く
-(NSString*)eFname {
    return [self lastPathComponent];
}
// ディレクトリと拡張子を除く
-(NSString*)eBname {
    return [[self lastPathComponent]stringByDeletingPathExtension];
}
// 拡張子を返す
-(NSString*)eExt {
    return [self pathExtension];
}
// ファイル名を除く
-(NSString*)eDname {
    return [self stringByDeletingLastPathComponent];
}
// 等しいかどうか
-(BOOL)eEq:(NSString*)str {
    return [self isEqualToString:str];
}
-(BOOL)eiEq:(NSString *)str {
    return ([self caseInsensitiveCompare:str] == NSOrderedSame);
}
// 大文字にする
-(NSString*)eUpper {
    return [self uppercaseString];
}
// 小文字にする
-(NSString*)eLower {
    return [self lowercaseString];
}

// 含むかどうか
-(BOOL)eContains:(NSString*)str {
    NSRange r = [self rangeOfString:str];
    return r.location != NSNotFound;
}
// MD5計算
-(NSString *)eMd5 {
    const char *test_cstr = [self UTF8String];
    unsigned char md5_result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(test_cstr, strlen(test_cstr), md5_result);
    return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",    
            md5_result[0], md5_result[1],
            md5_result[2], md5_result[3],
            md5_result[4], md5_result[5],
            md5_result[6], md5_result[7],
            md5_result[8], md5_result[9],
            md5_result[10], md5_result[11],
            md5_result[12], md5_result[13],
            md5_result[14], md5_result[15]];
}

// 正規表現に一致するかどうかを返す
-(BOOL)eIsMatch:(NSString*)pattern {
    NSRegularExpression* regex = [NSRegularExpression 
                                  regularExpressionWithPattern:pattern
                                  options:NSRegularExpressionCaseInsensitive
                                  | NSRegularExpressionDotMatchesLineSeparators
                                  error:NULL];
    NSTextCheckingResult* m = [regex 
                               firstMatchInString:self
                               options:0
                               range:NSMakeRange(0, [self length])];
    return m.numberOfRanges > 0;
    
}


// 正規表現に一致する部分を返す
-(NSArray*)eMatch:(NSString*)pattern {
    NSRegularExpression* regex = [NSRegularExpression 
                                  regularExpressionWithPattern:pattern
                                  options:NSRegularExpressionCaseInsensitive
                                  | NSRegularExpressionDotMatchesLineSeparators
                                  error:NULL];
    NSTextCheckingResult* m = [regex firstMatchInString:self
                                   options:0
                                     range:NSMakeRange(0, [self length])];
    
    NSMutableArray* ret = [NSMutableArray arrayWithCapacity:m.numberOfRanges];
    for (int i = 0; i < m.numberOfRanges; i++) {
        [ret addObject:[self substringWithRange:[m rangeAtIndex:i]]];
    }
    return ret;
}

// 正規表現に一致する部分をすべて返す
-(NSArray*)eMatches:(NSString *)pattern {
    NSRegularExpression* regex = [NSRegularExpression 
                                  regularExpressionWithPattern:pattern
                                  options:NSRegularExpressionCaseInsensitive
                                  | NSRegularExpressionDotMatchesLineSeparators
                                  error:NULL];
    NSArray* ms = [regex matchesInString:self
                                 options:0
                                   range:NSMakeRange(0, [self length])];
    NSMutableArray* ret = [NSMutableArray arrayWithCapacity:[ms count]];
    for (NSTextCheckingResult* m in ms) {
        NSMutableArray* elem = [NSMutableArray arrayWithCapacity:m.numberOfRanges];
        for (int i = 0; i < m.numberOfRanges; i++) {
            NSRange r = [m rangeAtIndex:i];
            NSString* sub = (r.location < [self length]) ? [self substringWithRange:r] : @"";
            [elem addObject:sub];
        }
        [ret addObject:elem];
    }
    return ret;
}

// 正規表現に一致する部分のRangeの配列を返す
-(NSArray *)eMatchRanges:(NSString *)pattern {
    NSRegularExpression* regex = [NSRegularExpression
                                  regularExpressionWithPattern:pattern
                                  options:NSRegularExpressionCaseInsensitive
                                  | NSRegularExpressionDotMatchesLineSeparators
                                  error:NULL];
    NSArray* ms = [regex matchesInString:self
                                 options:0
                                   range:NSMakeRange(0, [self length])];
    NSMutableArray* ret = [NSMutableArray arrayWithCapacity:[ms count]];
    for (NSTextCheckingResult* m in ms) {
        for (int i = 0; i < m.numberOfRanges; i++) {
            NSRange r = [m rangeAtIndex:i];
            [ret eAdd:[NSValue valueWithRange:r]];
        }
    }
    return ret;
}


// 正規表現に一致する部分をすべて置換する
-(NSString*)eReplace:(NSString*)pattern to:(NSString*)to {
    NSRegularExpression* regex = [NSRegularExpression 
                                  regularExpressionWithPattern:pattern
                                  options:NSRegularExpressionCaseInsensitive
                                  | NSRegularExpressionDotMatchesLineSeparators
                                  error:NULL];
    return [regex stringByReplacingMatchesInString:self
                                           options:0
                                             range:NSMakeRange(0, [self length])
                                      withTemplate:to];
}


// 文字列セット置換
-(NSString*)eReplaceSet:(NSArray*)fromArray to:(NSArray*)toArray {
    NSMutableString* ret = [NSMutableString stringWithString:self];
    for (int i = 0; i < fromArray.count; i++) {
        NSString* from = [fromArray eAt:i];
        NSString* to = [toArray eAt:i];
        [ret replaceOccurrencesOfString:from
                             withString:to 
                                options:NSBackwardsSearch 
                                  range:NSMakeRange(0, self.length)];
    }
    return ret;
    
}
// SQLエスケープ
-(NSString*)eSqlEscape {
    NSArray* froms = eArray(@"'", @"\n", @"\r", nil);
    NSArray* tos = eArray(@"''", @"\\n", @"\\r", nil);
    return [self eReplaceSet:froms to:tos];
}


// JavaScriptで使えるようにエスケープする
-(NSString*)eJsEscape {
    NSArray* froms = eArray(@"'", @"\"", @"\n", @"\r", @"\t", nil);
    NSArray* tos = eArray(@"\\'", @"\\\"", @"\\n", @"\\r", @"\\t", nil);
    return [self eReplaceSet:froms to:tos];
}

// HTMLエンティティのエスケープ
-(NSString *)eHtmlEscape {
    NSArray* froms = eArray(@"&", @"<", @">", @"\"", nil);
    NSArray* tos = eArray(@"&amp;", @"&lt;", @"&gt;", @"&quot;", nil);
    return [self eReplaceSet:froms to:tos];    
}

// 怪しい文字を含まないパスに変換する
-(NSString *)eSanitize {
    NSString* pattern = @"[%%&=\\?\\!\\|</ \\\\]";
    return [self eReplace:pattern to:@""];
}



// 分割する
-(NSArray*)eSplit:(NSString *)delim {
    return [self componentsSeparatedByString:delim];
}

// URLエンコード
-(NSString*)eUrlEncode {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

// URLデコード
-(NSString*)eUrlDecode {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

// Base64エンコード
-(NSString*)eBase64Encode {
    NSData *plainTextData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64EncodedString];
    return base64String;
}
// Base64デコード
-(NSString*)eBase64Decode {
    NSData *plainTextData = [NSData dataFromBase64String:self];
    NSString *plainText = [[NSString alloc] initWithData:plainTextData encoding:NSUTF8StringEncoding];
    return plainText;
}

-(NSString *)eTruncate:(NSInteger)len {
    if (self.length <= len) {
        return self;
    } else {
        return [self substringToIndex:len];
    }
}
-(NSData *)eToData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
// NSDataから生成する
+(NSString*)eFromData:(NSData*)data {
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}



@end

NSString* eJoin(NSString* str, ...) {
    NSMutableString* ret = [NSMutableString stringWithString:str];
    va_list args;
    va_start(args, str);
    NSString* s;
    while ((s = va_arg(args, NSString*))) {
        [ret appendString:s];
    }
    va_end(args);
    return ret;
}

// nilだったら空文字を返す
NSString* eEmp(NSString* str) {
    return str ? str : @"";
}

// リソース文字列
NSString* eRes(NSString* name) {
    return NSLocalizedString(name, nil);
}

NSString* eDatetimeFormatStr(NSDate* d, NSString* format) {
    if (!d) {
        d = [NSDate date];
    }
    NSDateFormatter* df = [NSDateFormatter eNew];
    df.dateFormat = format;
    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"JST"];
    NSString* now = [df stringFromDate:d];
    return now;
    
}

// 時刻から文字列に変換
NSString* eTimeStr(NSDate* d) {
    return eDatetimeFormatStr(d, @"yyyy-MM-dd HH:mm:ss");
}

// 日付文字列に変換
NSString* eDateStr(NSDate* d) {
    return eDatetimeFormatStr(d, @"yyyy-MM-dd");    
}

// SQL用クオート済み文字列
NSString* eSqlQuote(NSString* s) {
    if (s) {
        return [NSString stringWithFormat:@"'%@'", s.eSqlEscape];
    } else {
        return @"NULL";
    }
}


// 数値
NSString* eIntStr(NSInteger i) {
    return [NSString stringWithFormat:@"%d", i];
}

NSString* eLongStr(unsigned long ul) {
    return [NSString stringWithFormat:@"%ld", ul];
}

NSString* eFormatIntStr(NSInteger i) {
    NSNumberFormatter *formatter = [NSNumberFormatter eNew];
    [formatter setPositiveFormat:@",###"];
    NSNumber* num = [NSNumber numberWithInt:i];
    return [formatter stringForObjectValue:num];
}


// 数値
NSString* eFloatStr(CGFloat f) {
    return [NSString stringWithFormat:@"%f", f];
}


// 文字列から時刻に変換
NSDate* eStrTime(NSString* str) {
    if (!str || [str eEq:@""]) {
        return nil;
    }
    NSDateFormatter *df = [NSDateFormatter eNew];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [df dateFromString:str];    
}
// XML形式の時刻文字列から時刻に変換
NSDate* eXMLStrTime(NSString* str) {
    // タイムゾーンの書式が+09:00でも+0900でも受け入れられるようにするには
    // 正規表現を使うしかなかった。
    NSArray* elems = [str eMatches:@"^(\\d+)\\-(\\d+)\\-(\\d+)T(\\d+):(\\d+):(\\d+)(\\+|\\-)(\\d{2}):?(\\d{2})$"].eFirst;
    
    NSDateComponents* dc = [NSDateComponents eNew];
    dc.year = [[elems eAt:1] intValue];
    dc.month = [[elems eAt:2] intValue];
    dc.day = [[elems eAt:3] intValue];
    dc.hour = [[elems eAt:4] intValue];
    dc.minute = [[elems eAt:5] intValue];
    dc.second = [[elems eAt:6] intValue];
    int tznp = [[elems eAt:7]  eEq:@"+"] ? 1 : -1;
    int tzhour = [[elems eAt:8] intValue];
    int tzmin = [[elems eAt:9] intValue];
    dc.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:(tzhour * 3600 + tzmin * 60) * tznp];
    
    NSCalendar* cal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    return [cal dateFromComponents:dc];
}