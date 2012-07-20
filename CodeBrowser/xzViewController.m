//
//  xzViewController.m
//  CodeBrowser
//
//  Created by Xizhu on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "xzViewController.h"
#import "xzMenuViewController.h"
#import "FtpServer.h"
#import "NetworkController.h"
#import "xzNetController.h"
#import "xzCodeView.h"

@interface  xzViewController()

@property (nonatomic, readonly) xzMenuViewController            *menuController;
@property (nonatomic, readonly) xzNetController                 *netController;
@property (nonatomic, readonly) xzCodeView                      *codeView;

@end

@implementation xzViewController

@synthesize menuController, netController, codeView;

- (void)dealloc {
    [super dealloc];
    netController.fileTansFinishDelegate = nil;
    menuController.menuDelegate = nil;
    [menuController release];
    [netController release];
    [codeView release];
}

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.codeView];
    
    [self addChildViewController:self.menuController];
    [self.view addSubview:self.menuController.view];

    [self addChildViewController:self.netController];
    [self.view addSubview:self.netController.view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if(toInterfaceOrientation == UIDeviceOrientationPortrait || toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        return NO;
    }
    return YES;
}

- (void)showMenu:(UISwipeGestureRecognizer *)sender {
    [UIView beginAnimations:@"showMenu" context:nil];
    CGRect rect = self.menuController.view.bounds;
    rect.origin.x = 0;
    self.menuController.view.frame = rect;
    [UIView commitAnimations];
}

- (void)hideMenu:(UISwipeGestureRecognizer *)sender {
    [UIView beginAnimations:@"showMenu" context:nil];
    CGRect rect = self.menuController.view.bounds;
    rect.origin.x = 20 - rect.size.width;
    self.menuController.view.frame = rect;
    [UIView commitAnimations];
}

- (void)showNetWork:(UISwipeGestureRecognizer *)sender {
    [UIView beginAnimations:@"showMenu" context:nil];
    CGRect rect = self.netController.view.bounds;
    rect.origin.x = 1024 - rect.size.width;
    self.netController.view.frame = rect;
    [UIView commitAnimations];
}


- (void)hideNet:(UISwipeGestureRecognizer *)sender {
    [UIView beginAnimations:@"showMenu" context:nil];
    CGRect rect = self.netController.view.bounds;
    rect.origin.x = 1024 - 20;
    self.netController.view.frame = rect;
    [UIView commitAnimations];
}


- (xzNetController *)netController {
    if(!netController) {
        netController = [[xzNetController alloc] init];
        netController.fileTansFinishDelegate = self;
        netController.view.backgroundColor = [UIColor grayColor];
        CGRect rect = self.view.bounds;
        rect.size.width /= 2;
        rect.origin.x = self.view.bounds.size.width - 20;
        netController.view.frame = rect;
        
        UISwipeGestureRecognizer *showNet = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showNetWork:)];
        showNet.direction = UISwipeGestureRecognizerDirectionLeft;
        showNet.numberOfTouchesRequired = 1;
        [netController.view addGestureRecognizer:showNet];
        [showNet release];
        
        
        UISwipeGestureRecognizer *hideNet = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideNet:)];
        hideNet.direction = UISwipeGestureRecognizerDirectionRight;
        hideNet.numberOfTouchesRequired = 1;
        [netController.view addGestureRecognizer:hideNet];
        [hideNet release];
    }
    return netController;
}

- (xzMenuViewController *)menuController {
    if(!menuController) {
        NSString *path = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex:0];
        menuController = [[xzMenuViewController alloc] initWithRootPath:path];
        menuController.menuDelegate = self;
        menuController.view.backgroundColor = [UIColor grayColor];
        CGRect rect = self.view.bounds;
        rect.size.width /= 2;
        rect.origin.x = 20 - rect.size.width;
        menuController.view.frame = rect;
        
        
        UISwipeGestureRecognizer *showMenu = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
        showMenu.direction = UISwipeGestureRecognizerDirectionRight;
        showMenu.numberOfTouchesRequired = 1;
        [menuController.view addGestureRecognizer:showMenu];
        [showMenu release];
        
        UISwipeGestureRecognizer *hideMenu = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu:)];
        hideMenu.direction = UISwipeGestureRecognizerDirectionLeft;
        hideMenu.numberOfTouchesRequired = 1;
        [menuController.view addGestureRecognizer:hideMenu];
        [hideMenu release];
    }
    return menuController;
}


- (xzCodeView *)codeView {
    if(!codeView) {
        codeView = [[xzCodeView alloc] initWithFrame:self.view.bounds];
    }
    return codeView;
}

- (void)fileTranslateFinished {
    [self.menuController reloadFileList];
}

- (void)didSelectedFileAtPath:(NSString *)path {
    self.codeView.filePath = path;
    [self.codeView reloadData];
}


@end
