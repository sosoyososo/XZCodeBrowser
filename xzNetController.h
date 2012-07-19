//
//  xzNetController.h
//  CodeBrowser
//
//  Created by Xizhu on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FileTanslationDelegate <NSObject>

@required
- (void)fileTranslateFinished;

@end

@interface xzNetController : UIViewController <UIAlertViewDelegate>

@property (assign) id<FileTanslationDelegate> fileTansFinishDelegate;

@end
