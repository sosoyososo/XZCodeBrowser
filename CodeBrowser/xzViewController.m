//
//  xzViewController.m
//  CodeBrowser
//
//  Created by Xizhu on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "xzViewController.h"
#import "xzMenuViewController.h"

@interface  xzViewController()

@property (nonatomic, readonly) xzMenuViewController            *menuController;

@end

@implementation xzViewController

@synthesize menuController;

- (void)loadView {
    [super loadView];
    [self addChildViewController:self.menuController];
    [self.view addSubview:self.menuController.view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if(toInterfaceOrientation == UIDeviceOrientationPortrait || toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        return NO;
    }
    return YES;
}

- (xzMenuViewController *)menuController {
    if(!menuController) {
        menuController = [[xzMenuViewController alloc] initWithRootPath:@"/Users/wangxizhu/Desktop"];
        menuController.view.frame = self.view.bounds;
    }
    return menuController;
}


@end
