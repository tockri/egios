//
//  EGFile.m
//  LiverliveRecipe
//
//  11/06/24.

//

#import "EGFile.h"
#import "EG.h"

@implementation EGFile


+ (BOOL)exists: (NSString*) path {
	NSFileManager* fm = [NSFileManager defaultManager];
	return [fm fileExistsAtPath:path];
}

// ファイルの時刻
+ (NSDate*) mtime: (NSString*) path {
	if ([EGFile exists:path]) {
		NSError* error;
		NSFileManager* fm = [NSFileManager defaultManager];
		NSDictionary* attrs = [fm attributesOfItemAtPath:path error: &error];
		if (attrs == nil) {
			NSException* ex = [NSException exceptionWithName:@"EGFileException"
													  reason:[error localizedDescription]
													userInfo:nil];
			@throw ex;
		}
		return [attrs objectForKey: NSFileModificationDate];
	} else {
		return nil;
	}
}

// path1 > path2
+ (BOOL) newer: (NSString*)path1 than:(NSString*) path2 {
	NSDate* mtime1 = [EGFile mtime:path1];
	NSDate* mtime2 = [EGFile mtime:path2];
	if (mtime1 == nil && mtime2 == nil) {
		return NO;
	} else if (mtime1 == nil) {
		return NO;
	} else if (mtime2 == nil) {
		return YES;
	} else {
		return ([mtime1 compare:mtime2] == NSOrderedDescending);
	}
}

// ディレクトリがなければ作成
+ (void) mkdir: (NSString*) dir {
    if (![self exists:dir]) {
        NSFileManager* fm = [NSFileManager defaultManager];
        NSError* error;
        if (![fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error]) {
            @throw [NSException exceptionWithName:@"CreateDirectoryException" 
                                           reason:[error localizedDescription]
                                         userInfo:nil];
        }
    }
}



// コピーする
+ (void) copy: (NSString*)src into:(NSString*) dst {
	NSError* error;
	NSFileManager* fm = [NSFileManager defaultManager];
    BOOL isdir;
	if ([fm fileExistsAtPath:dst isDirectory:&isdir]) {
		if (isdir) {
            dst = [dst eAddPath:[src eFname]];
        } else {
            if (![fm removeItemAtPath:dst error:&error]) {
                // 削除失敗
                @throw [NSException exceptionWithName:@"FileRemoveException" 
                                                          reason:[error localizedDescription]
                                                        userInfo:nil];
            }
		}
	}
    NSString* dir = [dst stringByDeletingLastPathComponent];
    if (![fm fileExistsAtPath:dir]) {
        [self mkdir:dir];
    }
    
	if (![fm copyItemAtPath:src toPath:dst error:&error]) {
		// コピー失敗
		@throw [NSException exceptionWithName:@"FileCopyException" 
									   reason:[error localizedDescription]
									 userInfo:nil];
	}
}

// 削除する
+ (void) rm: (NSString*) path {
    if ([self exists:path]) {
        NSFileManager* fm = [NSFileManager defaultManager];
        NSError* error;
        if (![fm removeItemAtPath:path error:&error]) {
            // 削除失敗
            @throw [NSException exceptionWithName:@"FileRemoveException" 
                                           reason:[error localizedDescription]
                                         userInfo:nil];
        }
    }
}

// ディレクトリかどうか判定する
+ (BOOL)isdir:(NSString *)path {
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isdir;
	if ([fm fileExistsAtPath:path isDirectory:&isdir]) {
        return isdir;
    } else {
        return NO;
    }
}
// ディレクトリ内のファイルのフルパス一覧を返す
+ (NSArray*) fileNames:(NSString*) dir extensions:(NSArray*) extensions {
    NSError* error;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *arr = [fm contentsOfDirectoryAtPath:dir error:&error];
    if (!arr) {
        @throw [NSException exceptionWithName:@"FileListException"
                                       reason:[error localizedDescription]
                                     userInfo:nil];
    }
    NSMutableArray* ret = [[NSMutableArray alloc]initWithCapacity:[arr count]];
    for (NSString *filename in arr) {
        BOOL append = YES;
        
        if ([extensions.eFirst eEq:@"/"]) {
            if (![self isdir:[dir eAddPath:filename]]) {
                append = NO;
            }
        } else if (extensions) {
            append = NO;
            for (NSString* e in extensions) {
                if ([e eiEq:filename.eExt]) {
                    append = YES;
                    break;
                }
            }
        }
        if (append) {
            [ret addObject:filename];
        }
    }
    return ret;
}


// ディレクトリ内のファイルのフルパス一覧を返す
+ (NSArray*) files:(NSString*) dir extensions:(NSArray*) extensions {
    NSError* error;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *arr = [fm contentsOfDirectoryAtPath:dir error:&error];
    if (!arr) {
        @throw [NSException exceptionWithName:@"FileListException"
                                       reason:[error localizedDescription]
                                     userInfo:nil];
    }
    NSMutableArray* ret = [[NSMutableArray alloc]initWithCapacity:[arr count]];
    for (NSString *filename in arr) {
        BOOL append = YES;
        
        if ([extensions.eFirst eEq:@"/"]) {
            if (![self isdir:[dir eAddPath:filename]]) {
                append = NO;
            }
        } else if (extensions) {
            append = NO;
            for (NSString* e in extensions) {
                if ([e eiEq:filename.eExt]) {
                    append = YES;
                    break;
                }
            }
        }
        if (append) {
            [ret addObject:[dir eAddPath:filename]];
        }
    }
    return ret;
}

// ディレクトリを再帰的にたどる
+ (void)rfilesInner:(NSMutableArray*)result dir:(NSString*)dir extensions:(NSArray*)extensions {
    
	NSFileManager* fm = [NSFileManager defaultManager];
    BOOL isdir;
    
    for (NSString* file in [self files:dir extensions:extensions]) {
        [fm fileExistsAtPath:file isDirectory:&isdir];
        if (isdir) {
            if ([extensions.eFirst eEq:@"/"]) {
                [result addObject:file];
            }
            [self rfilesInner:result dir:file extensions:extensions];
        } else {
            [result addObject:file];
        }
    }
}

// ディレクトリを再帰的にたどってファイル一覧を返す
+ (NSArray*) rfiles:(NSString*)dir extensions:(NSArray*)extensions {
    NSMutableArray* ret = [NSMutableArray array];
    [self rfilesInner:ret dir:dir extensions:extensions];
    return ret;
}


// かぶらない名前を生成する
+ (NSString*) unexistingPath:(NSString *)path {
    NSString* ret = path;
    NSString* base = [path stringByDeletingPathExtension];
    NSString* ext = [path pathExtension];
    NSInteger i = 1;
    while ([self exists:ret]) {
        ret = [base stringByAppendingFormat:@"-%d.%@", i++, ext];
    }
    return ret;
}

// テキストファイルの中身を読み取って返す
+ (NSString*) read:(NSString*) path {
    if ([self exists:path]) {
        return [NSString stringWithContentsOfFile:path 
                                         encoding:NSUTF8StringEncoding 
                                            error:nil];
    } else {
        return nil;
    }
}

// テキストファイルに書きこむ
+ (void) write:(NSString*) str path:(NSString*)path {
    [self mkdir:[path eDname]];
    [str writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

// 追記する
+ (void) append:(NSData*) data path:(NSString*)path {
    if ([self exists:path]) {
        NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:path];
        [fh seekToEndOfFile];
        [fh writeData:data];
        [fh closeFile];
    } else {
        NSString* dir = [path eDname];
        [self mkdir:dir];
        [data writeToFile:path atomically:NO];
    }
}

// 移動（名前変更）
+ (void) mv:(NSString*)from toPath:(NSString*)to {
    if ([self exists:from]) {
        NSFileManager* fm = [NSFileManager defaultManager];
        [self mkdir:[to stringByDeletingLastPathComponent]];
        NSError* error;
        [self rm:to];
        if (![fm moveItemAtPath:from toPath:to error:&error]) {
            @throw [NSException exceptionWithName:@"FileMoveException"
                                           reason:[error localizedDescription]
                                         userInfo:nil];
        }
    }
}
// ファイル名が大丈夫かどうか
+ (BOOL)isValidFilename:(NSString*)fileName {
    NSString* pattern = @"[/¥\\\\!. \\[\\]\\'\\\"\\?\\t\\n\\r:]";
    if ([fileName eIsMatch:pattern]) {
        return NO;
    } else {
        return YES;
    }
}

// ファイルサイズを返す
+ (NSUInteger)length:(NSString*)path {
    NSFileManager* fm = [NSFileManager defaultManager];
    NSDictionary* attrs = [fm attributesOfItemAtPath:path error:nil];
    NSString* sizeStr = [attrs objectForKey:NSFileSize];
    NSUInteger size = [sizeStr intValue];
    return size;
}



@end
