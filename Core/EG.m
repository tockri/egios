//
//  EG.m

#import "EG.h"

static NSObject* MUTEX;

@implementation EG

// 一番上にあるControllerを返す
+(UIViewController*)rootViewController {
    UIApplication* app = [UIApplication sharedApplication];
	UIWindow* window = app.keyWindow;
    return window.rootViewController;
}

// MainWindowを返す
+(UIWindow*)window {
    return [[UIApplication sharedApplication].windows objectAtIndex:0];
}

// 現在縦置きかどうかを返す
+ (BOOL) isPortrait {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait
        || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    } else {
        return NO;
    }
}
+ (BOOL)isLandscape {
    return ![self isPortrait];
}

// iPad向けかどうかを返す
+(BOOL)isForIpad {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    } else {
        return YES;
    }
}
+(BOOL)isForIphone {
    return ![self isForIpad];
}



// リソースのパスを返す
+(NSString*)resPath:(NSString*)subPath {
    return [[[NSBundle mainBundle]resourcePath]eAddPath:subPath];
}
// ドキュメントディレクトリのパスを返す
+(NSString*)docPath:(NSString*)subPath {
    return [[NSHomeDirectory() 
             eAddPath:@"Documents"]
            eAddPath:subPath];
}
+(NSString *)libPath:(NSString *)subPath {
    return [[NSHomeDirectory()
             eAddPath:@"Library"]
            eAddPath:subPath];
}
// キャッシュディレクトリのパスを返す
+(NSString*)cachePath:(NSString*)subPath {
    return [[NSHomeDirectory()
             eAddPath:@"Library/Caches"]
            eAddPath:subPath];
    
}
// テンポラリディレクトリのパスを返す
+(NSString*)tmpPath:(NSString*)subPath {
    return [[NSHomeDirectory()
             eAddPath:@"tmp"]
            eAddPath:subPath];
}

+(NSObject *)mutex {
    if (!MUTEX) {
        // なんでもいいオブジェクト
        MUTEX = @"";
    }
    return MUTEX;
}
// 設定値オブジェクトを返す
+(NSUserDefaults*)userDefaults {
    return [NSUserDefaults standardUserDefaults];
}


// 設定値を返す
+(BOOL)configBool:(NSString*)key {
    return [[self configValue:key]boolValue];
}
// 設定値を設定する
+(void)setConfigBool:(BOOL)b forKey:(NSString*)key {
    NSNumber* n = b ? [NSNumber numberWithBool:YES] : nil;
    [self setConfigValue:n forKey:key];
}
// 設定値を返す
+(NSInteger)configInt:(NSString*)key {
    return [[self configValue:key]intValue];
}
// 設定値を設定する
+(void)setConfigInt:(NSInteger)i forKey:(NSString*)key {
    NSNumber* n = i ? [NSNumber numberWithInt:i] : nil;
    [self setConfigValue:n forKey:key];
}


// 設定値を返す
+(id)configValue:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults]valueForKey:key];
}
// 設定値を設定する
+(void)setConfigValue:(id)v forKey:(NSString*)key {
    NSUserDefaults* ud = [self userDefaults];
    [ud setValue:v forKey:key];
    [ud synchronize];
}



@end


BOOL eBool(id value) {
    if (value) {
        if ([value isKindOfClass:[NSValue class]]) {
            return [value boolValue];
        } else if ([value isKindOfClass:[NSNull class]]) {
            return NO;
        } else if ([value isKindOfClass:[NSString class]]) {
            NSString* v = value;
            if ([v eEq:@""] || [v eEq:@"0"] || [v eEq:@"false"]) {
                return NO;
            } else {
                return YES;
            }
        } else {
            return YES;
        }
    } else {
        return NO;
    }
}

int eInt(id value) {
    if (value) {
        if ([value isKindOfClass:[NSValue class]]) {
            return [value intValue];
        } else if ([value isKindOfClass:[NSNull class]]) {
            return 0;
        } else if ([value isKindOfClass:[NSString class]]) {
            NSString* v = value;
            if ([v eEq:@""]) {
                return 0;
            } else {
                return [v integerValue];
            }
        } else {
            return YES;
        }
    } else {
        return 0;
    }
}


NSString* eString(id val) {
    if (val) {
        if ([val isKindOfClass:[NSNull class]]) {
            return nil;
        } else if ([val isKindOfClass:[NSString class]]) {
            NSString* vstr = val;
            if ([vstr eEq:@"<null>"]) {
                return nil;
            } else {
                return vstr;
            }
        } else if ([val isKindOfClass:[NSValue class]]) {
            NSValue* vval = val;
            return vval.description;
        } else if ([val isKindOfClass:[NSObject class]]) {
            NSObject* valo = val;
            return valo.description;
        } else {
            NSLog(@"eString:unexpected object: %@", val);
            return nil;
        }
    } else {
        return nil;
    }
}



