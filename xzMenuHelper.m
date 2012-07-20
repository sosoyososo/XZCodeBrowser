//
//  xzMenuHelper.m
//  CodeBrowser
//
//  Created by Xizhu on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "xzMenuHelper.h"

@interface xzMenuHelper()

@property (nonatomic, readonly) NSString                    *rootPath;
@property (nonatomic, readonly) NSMutableArray              *contentArray;
@property (nonatomic, readonly) NSFileManager               *fileManager;
@property (nonatomic, readonly) NSMutableArray              *unfoldedPath;

- (void)unFoldRoot;
- (void)unFoldDictionary:(NSString *)parentPath;

@end


@implementation xzMenuHelper

@synthesize rootPath, contentArray, fileManager, unfoldedPath;

- (void)dealloc {
    [super dealloc];
    [rootPath release];
    [contentArray release];
    [fileManager release];
    [unfoldedPath release];
}

- (id)initWithRootPath:(NSString *)path {

    if(self = [super init]) {
        rootPath = [path copy];
        [self unFoldRoot];
    }
    return self;
}

- (NSMutableArray *)unfoldedPath {
    if(!unfoldedPath) {
        unfoldedPath = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return unfoldedPath;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark menu Utiltty

- (NSArray *)contentArray {
    if(!contentArray) {
        contentArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return contentArray;
}


- (NSFileManager *)fileManager {
    if(!fileManager) {
        fileManager = [[NSFileManager alloc] init];
    }
    return fileManager;
}

- (NSInteger)numOfContentsInDictionary:(NSString *)path {
    if([self isDictionary:path]) {
        return [[fileManager contentsOfDirectoryAtPath:path error:nil] count];
    }
    return -1;
}

- (BOOL)isDictionary:(NSString *)path {
    BOOL isDictionary = NO;
    [self.fileManager fileExistsAtPath:path isDirectory:&isDictionary];
    return isDictionary;
}

- (NSString *)contentTobeShowInPath:(NSString *)path {
    NSArray *components = [path componentsSeparatedByString:@"/"];
    return [components objectAtIndex:(components.count-1)];
}

- (NSString *)parentDictionary:(NSString *)path {
    return [path stringByDeletingLastPathComponent];
}

- (NSUInteger)levelOfPath:(NSString *)path {
    return [path componentsSeparatedByString:@"/"].count - [self.rootPath componentsSeparatedByString:@"/"].count;
}

- (BOOL)isUnfoldedPath:(NSString *)path {
    return [self.unfoldedPath containsObject:path];
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark menu property

- (NSUInteger)numOfMenuCell {
    return self.contentArray.count;
}

- (NSString *)pathOfCellAtIndex:(NSUInteger)index {
    return [self.contentArray objectAtIndex:index];
}

- (NSString *)pathToBeShowAtIndex:(NSUInteger)index {
    return [self contentTobeShowInPath:[self pathOfCellAtIndex:index]];
}

- (BOOL)pathAtIndexIsDictionary:(NSInteger)index {
    return [self isDictionary:[self pathOfCellAtIndex:index]];
}

- (NSUInteger)levelOfPathAtIndex:(NSUInteger)index {
    return [self levelOfPath:[self pathOfCellAtIndex:index]];
}

- (NSUInteger)numOfSubContentAtIndex:(NSUInteger)index {
    return [self numOfContentsInDictionary:[self pathOfCellAtIndex:index]];
}

- (BOOL)isPathAtIndexUnfolded:(NSUInteger)index {
    return  [self isUnfoldedPath:[self pathOfCellAtIndex:index]];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark menu operation folding

- (void)foldDictionaryAtIndex:(NSUInteger)index {
    [self foldDictionary:[self pathOfCellAtIndex:index] atIndex:index];
}

- (void)foldDictionary:(NSString *)parentPath atIndex:(NSUInteger)index {
    [self.unfoldedPath removeObject:parentPath];
    
    NSArray *contents = [self.fileManager contentsOfDirectoryAtPath:parentPath error:nil];
    [self.contentArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index+1, contents.count)]];
}

- (void)reloadFileList {
    [self.contentArray removeAllObjects];
    [self unFoldRoot];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark menu operation unfolding

- (void)unFoldRoot {
    [self.contentArray addObject:rootPath];
    [self unFoldDictionary:self.rootPath];
}

- (void)unFoldDictionaryAtIndex:(NSUInteger)index {
    NSString *path = [self pathOfCellAtIndex:index];
    if([self isDictionary:path]) {
        [self unFoldDictionary:path atIndex:index];
    }
}

- (void)unFoldDictionary:(NSString *)parentPath {
    [self unFoldDictionary:parentPath atIndex:0];
}

- (void)unFoldDictionary:(NSString *)parentPath atIndex:(NSUInteger)index {
    [self.unfoldedPath addObject:parentPath];
    NSArray *contents = [self.fileManager contentsOfDirectoryAtPath:parentPath error:nil];
    NSMutableArray *contentsToBeAdd = [NSMutableArray arrayWithCapacity:1];
    for (NSString *content in contents) {
        [contentsToBeAdd addObject:[parentPath stringByAppendingPathComponent:content]];
    }
    [self.contentArray insertObjects:contentsToBeAdd atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index+1, contentsToBeAdd.count)]];
}

@end
