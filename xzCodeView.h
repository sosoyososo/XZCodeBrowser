//
//  xzCodeView.h
//  CodeBrowser
//
//  Created by Xizhu on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xzCodeView : UIView <UIWebViewDelegate>

@property (nonatomic, copy) NSString        *filePath;

- (void)reloadData;

@end
