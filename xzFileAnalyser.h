//
//  xzFileAnalyser.h
//  CodeBrowser
//
//  Created by Xizhu on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xzFileAnalyser : NSObject

@property (nonatomic, readonly) NSArray     *classArray;
@property (nonatomic, readonly) NSArray     *methodArray;
@property (nonatomic, readonly) NSArray     *properteyArray;

+ (xzFileAnalyser *)fileAnalyserWithFile:(NSString *)path;

@end
