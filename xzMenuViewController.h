//
//  xzMenuViewController.h
//  CodeBrowser
//
//  Created by Xizhu on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol xzMenuDelegate <NSObject>

@required
- (void)didSelectedFileAtPath:(NSString *)path;

@end

@interface xzMenuViewController : UITableViewController 

@property (assign) id<xzMenuDelegate>  menuDelegate;


- (id)initWithRootPath:(NSString *)path;
- (void)reloadFileList;

@end
