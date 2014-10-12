//
//  NSSet+Util.h
//  PicPages
//
//  Created by 藤田正訓 on 2013/03/29.
//  Copyright (c) 2013年 tockri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (EG)
// containsObjectのエイリアス
-(BOOL)eHas:(id)obj;

@end




@interface NSMutableSet(EG)
// addObjectのエイリアス
-(void)eAdd:(id)obj;

@end



//[NSMutableSet setWithObjects:....]のかわり
NSMutableSet* eSet(id obj, ...);