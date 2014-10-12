//
//  EGData.h
//  PicPages
//
//  Created by 藤田正訓 on 2013/04/08.
//  Copyright (c) 2013年 tockri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface EGData : NSObject

// CoreDataから集計値を一つ取得する
// expr : @"max:", @"min:"など
// column : 列
- (id)fetchValue:(NSString*)expr
          column:(NSString*)column
       predicate:(NSString*)predicate
       arguments:(NSArray*)arguments;


// オブジェクトを一つ返す
- (id)fetchOne:(NSString*)predicate
                   arguments:(NSArray*)arguments;

// オブジェクトを全部返す
- (NSArray*)fetchAll:(NSString*)predicate
           arguments:(NSArray*)arguments
              sortBy:(NSArray*)columns
               limit:(NSInteger)limit;


// CoreDataからオブジェクト一覧を取得する
- (NSFetchedResultsController*)fetch:(NSString*)predicate
                           arguments:(NSArray*)arguments
                              sortBy:(NSArray*)columns;

// インスタンス化する
+ (EGData*)egdata:(NSManagedObjectContext*)ctx
       entityName:(NSString*)entityName;

@end
