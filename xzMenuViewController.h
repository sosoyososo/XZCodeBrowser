//
//  xzMenuViewController.h
//  CodeBrowser
//
//  Created by Xizhu on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xzMenuViewController : UITableViewController

- (id)initWithRootPath:(NSString *)path;
- (void)reloadFileList;

@end
