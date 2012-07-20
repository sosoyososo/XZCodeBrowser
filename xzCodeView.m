//
//  xzCodeView.m
//  CodeBrowser
//
//  Created by Xizhu on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "xzCodeView.h"

@interface xzCodeView()

@property (nonatomic, readonly) UIWebView           *codeView;

- (NSString *)contentOfFile:(NSString *)path;

@end


@implementation xzCodeView

@synthesize codeView, filePath;

- (void)dealloc {
    [super dealloc];
    [codeView release];
    [filePath release];
}

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        codeView = [[UIWebView alloc] initWithFrame:frame];
        codeView.delegate = self;
        [self addSubview:codeView];
        filePath = @"/Users/wangxizhu/Library/Application Support/iPhone Simulator/4.3.2/Applications/6F3435FE-EA4A-4173-B049-9B187353D4BD/Documents/browserTest/browserTestTests/browserTestTests.m";
        [self reloadData];
    }
    return self;
}

- (void)reloadData {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath]; 
    NSString *htmlFilePath = [resourcePath stringByAppendingPathComponent:@"index.html"];
    NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:htmlFilePath  encoding:NSUTF8StringEncoding error:nil]; 
    [codeView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:resourcePath]];
}


- (void)webViewDidFinishLoad:(UIWebView *)qwebView {

    NSString *fileContent = [self contentOfFile:filePath];
    NSString *script1 = [NSString stringWithFormat:@"document.getElementsByName('code')[0].value=\'%@\';",fileContent];
    NSString *script = @"CodeMirror.fromTextArea(document.getElementById('code'), {lineNumbers: true,matchBrackets: true,mode:'text/x-csrc'});";
    [codeView stringByEvaluatingJavaScriptFromString:script1];
    [codeView stringByEvaluatingJavaScriptFromString:script];
}


- (NSString *)contentOfFile:(NSString *)path {
    NSUInteger encoding ;
    NSError *error = nil;
    NSString *fileContent = [NSString stringWithContentsOfFile:path usedEncoding:&encoding error:&error];
    NSLog(@"%@", fileContent);
    NSArray *array = [[NSArray alloc] initWithObjects:@"\n", @"\t", @"\r", @"\v", @"\"", @"\'", nil];
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"\\n", @"\\t", @"\\r",@"\\v",@"\\\"", @"\\\'", nil];
    for (NSString *sub in array) {
        NSString *tobe = [array1 objectAtIndex:[array indexOfObject:sub]];
        fileContent = [fileContent stringByReplacingOccurrencesOfString:sub withString:tobe];
    }
    return fileContent;
}


@end
