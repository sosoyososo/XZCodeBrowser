
//
//  xzFileAnalyser.m
//  CodeBrowser
//
//  Created by Xizhu on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "xzFileAnalyser.h"

@interface xzFileAnalyser()

@property (nonatomic, copy) NSString    *filePath;
@property (nonatomic, copy) NSString    *fileContent;

- (xzFileAnalyser *)initWithFile:(NSString *)afilePath;

@end

@implementation xzFileAnalyser

@synthesize filePath, fileContent, classArray, methodArray, properteyArray;

+ (xzFileAnalyser *)fileAnalyserWithFile:(NSString *)path {
    return [[[xzFileAnalyser alloc] initWithFile:path] autorelease];
}

- (void)dealloc {
    [super dealloc];
    [filePath release];
    [fileContent release];
    [classArray release];
    [methodArray release];
    [properteyArray release];
}

- (xzFileAnalyser *)initWithFile:(NSString *)afilePath {
    if(self = [super init]) {
        self.filePath = afilePath;
    }
    return self;
}


- (void)setFilePath:(NSString *)afilePath {
    if([afilePath isEqualToString:filePath]) {
        return;
    }
    [afilePath copy];
    [filePath release];
    filePath = afilePath;
    
    [self loadFile];
    [self analyseFile];
}

- (NSString *)filePath {
    return filePath;
}

- (void)loadFile {
    if(self.filePath.length > 0) {
        NSUInteger encoding ;
        NSError *error = nil;
        NSString *fileContentStr = [NSString stringWithContentsOfFile:self.filePath usedEncoding:&encoding error:&error];
        if(fileContentStr.length > 0) {
            fileContentStr = [self removeStringAndAnnotation:fileContentStr];
        }
        self.fileContent = fileContentStr;
    }
}

- (NSString *)removeStringAndAnnotation:(NSString *)string {
    if(string.length > 0) {
        string = [self removeString:string];
        string = [self removeAnnotation:string];
    }
    return string;
}

- (NSString *)removeString:(NSString *)string {
    
    BOOL inAnnotationResult = NO;
    NSMutableString *resultString = [NSMutableString stringWithCapacity:1];
    NSRange range;
    while (string.length > 0) {
        if(!inAnnotationResult) {
            range = [string rangeOfString:@"@\""];
            if(range.length == 0) {
                [resultString appendString:string];
                break;
            }
            [resultString appendString:[string substringToIndex:range.location]];
            string = [string substringFromIndex:(range.location + range.length)];
            inAnnotationResult = YES;
        } else {
            range = [string rangeOfString:@"\""];
            
            //防止处理的字符是\"
            if(range.location > 0) {
                NSRange temRange = NSMakeRange(range.location-1, range.length + 1);
                NSString *temStr = [string substringWithRange:temRange];
                if([temStr isEqualToString:@"\\\""]) {
                    string = [string substringFromIndex:(temRange.length + temRange.location)];
                    continue;
                }
            }
            
            string = [string substringFromIndex:(range.location + range.length)];
            inAnnotationResult = NO;
        }
    }
    return resultString;
}

//应该处理一个文件的内容
- (NSString *)removeAnnotation:(NSString *)string {
    string = [self removeAnnotationStyle2:string inAnnotation:NO];
    NSArray *array = [string componentsSeparatedByString:@"\n"];
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:1];
    for (NSString *sub in array) {
        NSString *stringToBeAdd = [self removeAnnotationStyle1:sub];
        if(stringToBeAdd.length) {
            [resultArray addObject:stringToBeAdd];
        }
    }
    return [resultArray componentsJoinedByString:@"\n"];
}


//去掉处理使用“//”注释掉的内容，每次应只处理一行
- (NSString *)removeAnnotationStyle1:(NSString *)string {
    if(string.length > 0) {
        //rangeOfString 会返回第一次遇到这个字串的位置和被查询字串的长度
        NSRange range = [string rangeOfString:@"//"];
        if(range.length) {
            string = [string substringToIndex:range.location];
        }
    }
    return string;
}

//判断下一行是否还是注释
- (BOOL)isStringEndInAnnotation:(NSString *)string startInAnnotation:(BOOL)inAnnotation {
    
    BOOL inAnnotationResult = inAnnotation;
    NSRange range;
    while (string.length > 0) {
        if(!inAnnotationResult) {
            range = [string rangeOfString:@"/*"];
            string = [string substringFromIndex:(range.location + range.length)];
            inAnnotationResult = YES;
        } else {
            range = [string rangeOfString:@"*/"];
            string = [string substringFromIndex:(range.location + range.length)];
            inAnnotationResult = NO;
        }
    }
    return inAnnotationResult;
}

//去掉处理使用“/**/”注释掉的内容,
- (NSString *)removeAnnotationStyle2:(NSString *)string inAnnotation:(BOOL)inAnnotation {
    
    BOOL inAnnotationResult = inAnnotation;
    NSMutableString *resultString = [NSMutableString stringWithCapacity:1];
    NSRange range;
    while (string.length > 0) {
        if(!inAnnotationResult) {
            range = [string rangeOfString:@"/*"];
            if(range.length == 0) {
                [resultString appendString:string];
                break;
            }
            [resultString appendString:[string substringToIndex:range.location]];
            string = [string substringFromIndex:(range.location + range.length)];
            inAnnotationResult = YES;
        } else {
            range = [string rangeOfString:@"*/"];
            string = [string substringFromIndex:(range.location + range.length)];
            inAnnotationResult = NO;
        }
    }
    return resultString;
}


- (void)analyseFile {
    [self findClass];
    [self findProperty];
    [self findMethod];
}

//获取第一个在OC中可以充当名称的词
- (NSString *)getFirstWord:(NSString *)string {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@" \n:<>*+-\r\t"];
    NSRange range = [string rangeOfCharacterFromSet:set];
    return [string substringToIndex:range.location];
}

- (void)findClass {
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:1];
    NSString *string = self.fileContent;
    while (string.length > 0) {
        NSRange range = [string rangeOfString:@"@interface"];
        if(range.length > 0) {
            string = [string substringFromIndex:(range.location + range.length)];
            NSString *word = [self getFirstWord:string];
            [temArray addObject:word];
            string = [string substringFromIndex:word.length];
        }
    }
    classArray = [temArray retain];
}

- (void)findProperty {
}

- (void)findMethod {
}

@end
