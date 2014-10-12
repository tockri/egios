//
//  EGData.m
//  PicPages
//
//  Created by 藤田正訓 on 2013/04/08.
//  Copyright (c) 2013年 tockri. All rights reserved.
//

#import "EG.h"
#import "EGData.h"

@implementation EGData {
    NSManagedObjectContext* ctx;
    NSString* entityName;
}

// CoreDataから集計値を一つ取得する
// expr : @"max:", @"min:"など
// column : 列
- (id)fetchValue:(NSString*)expr
          column:(NSString*)column
       predicate:(NSString*)predicate
       arguments:(NSArray*)arguments {
    NSFetchRequest *req = [NSFetchRequest eNew];
    // エンティティ
    req.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:ctx];

    // 検索表現
    NSExpressionDescription* desc = [NSExpressionDescription eNew];
    desc.name = @"fetchedValue";
    desc.expression = [NSExpression
                       expressionForFunction:expr
                       arguments:@[
                       [NSExpression expressionForKeyPath:column]]];
    req.propertiesToFetch = @[desc];
    req.resultType = NSDictionaryResultType;
    
    // 検索条件
    if (predicate) {
        req.predicate = [NSPredicate predicateWithFormat:predicate argumentArray:arguments];
    }

    // 検索実行
    NSError* error = nil;
    NSArray* result = [ctx executeFetchRequest:req error:&error];
    if (!error) {
        return [result.eFirst valueForKey:desc.name];
    } else {
        @throw [NSException exceptionWithName:@"EGDataException"
                                       reason:error.description
                                     userInfo:error.userInfo];
    }
}

// リクエストオブジェクトを生成する
- (NSFetchRequest*)createRequest:(NSString*)predicate
                       arguments:(NSArray*)arguments
                          sortBy:(NSArray*)columns
                           limit:(NSInteger)limit {
    NSFetchRequest *req = [NSFetchRequest eNew];
    // エンティティ名
    req.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:ctx];
    
    // LIMIT
    if (limit) {
        req.fetchBatchSize = limit;
    }
    
    // ソート条件
    if (columns) {
        NSMutableArray* sorts = [NSMutableArray arrayWithCapacity:columns.count];
        for (NSString* col in columns) {
            
            NSArray* elems = [col eSplit:@" "];
            NSSortDescriptor* sort;
            if (elems.count == 2 && [((NSString*)elems[1]).lowercaseString eEq:@"desc"]) {
                sort = [[NSSortDescriptor alloc]initWithKey:elems[0] ascending:NO];
            } else {
                sort = [[NSSortDescriptor alloc] initWithKey:col ascending:YES];
            }
            [sorts eAdd:sort];
        }
        req.sortDescriptors = sorts;
    }
    
    // 検索条件
    if (predicate) {
        req.predicate = [NSPredicate predicateWithFormat:predicate argumentArray:arguments];
    }
    return req;
}

-(NSArray *)fetchAll:(NSString *)predicate
           arguments:(NSArray *)arguments
              sortBy:(NSArray *)columns
               limit:(NSInteger)limit {
    NSFetchRequest* req = [self createRequest:predicate
                                    arguments:arguments
                                       sortBy:nil
                                        limit:limit];
    
    req.resultType = NSManagedObjectResultType;
    
	NSError *error = nil;
    NSArray* result = [ctx executeFetchRequest:req error:&error];
    if (!error) {
        return result;
    } else {
        NSLog(@"fetch error : %@", error);
        @throw [NSException exceptionWithName:@"EGDataException"
                                       reason:error.description
                                     userInfo:error.userInfo];
    }
}

// オブジェクトを一つ
- (id)fetchOne:(NSString*)predicate
                   arguments:(NSArray*)arguments {
    NSArray* ret = [self fetchAll:predicate
                        arguments:arguments
                           sortBy:nil
                            limit:1];
    return ret.eFirst;
}


// CoreDataからオブジェクト一覧を取得する
- (NSFetchedResultsController*)fetch:(NSString*)predicate
                           arguments:(NSArray*)arguments
                             sortBy:(NSArray*)columns {
    NSFetchRequest* req = [self createRequest:predicate
                                    arguments:arguments
                                       sortBy:columns
                                        limit:20];
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:req managedObjectContext:ctx sectionNameKeyPath:nil cacheName:nil];
    
	NSError *error = nil;
    [controller performFetch:&error];
	if (!error) {
        return controller;
    } else {
        NSLog(@"fetch error : %@", error);
        @throw [NSException exceptionWithName:@"EGDataException"
                                       reason:error.description
                                     userInfo:error.userInfo];
    }

}

// インスタンス化する
+(EGData *)egdata:(NSManagedObjectContext *)ctx entityName:(NSString *)entityName {
    EGData* ret = [EGData eNew];
    ret->ctx = ctx;
    ret->entityName = entityName;
    return ret;
}


@end
