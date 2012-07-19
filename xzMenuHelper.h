//
//  xzMenuHelper.h
//  CodeBrowser
//
//  Created by Xizhu on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xzMenuHelper : NSObject

- (id)initWithRootPath:(NSString *)path;
- (NSUInteger)numOfMenuCell;
- (NSString *)pathToBeShowAtIndex:(NSUInteger)index;
- (BOOL)pathAtIndexIsDictionary:(NSInteger)index;
- (NSUInteger)levelOfPathAtIndex:(NSUInteger)index;
- (NSUInteger)numOfSubContentAtIndex:(NSUInteger)index;
- (BOOL)isPathAtIndexUnfolded:(NSUInteger)index;

- (void)unFoldDictionaryAtIndex:(NSUInteger)index;
- (void)foldDictionaryAtIndex:(NSUInteger)index;
- (void)reloadFileList;

@end
