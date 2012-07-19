//
//  xzNetController.m
//  CodeBrowser
//
//  Created by Xizhu on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "xzNetController.h"
#import "FtpServer.h"
#import "NetworkController.h"

@interface xzNetController ()

@property (nonatomic, readonly) FtpServer *ftpServer;

@end

@implementation xzNetController

@synthesize ftpServer, fileTansFinishDelegate;

- (void)loadView {
    [super loadView];
    
    UIButton *ftpServerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ftpServerButton.frame = CGRectMake(100, 100, 100, 40);
    [ftpServerButton setTitle:@"start ftpserver" forState:UIControlStateNormal];
    [ftpServerButton addTarget:self action:@selector(startFtp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ftpServerButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


- (void)startFtp:(id)sender {
    if(ftpServer) {
        [ftpServer release];
        ftpServer = nil;
    }
    ftpServer = [[FtpServer alloc] initWithPort:2000 withDir:[NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex:0] notifyObject:self];
    
    NSString *ipaddress = [NetworkController localWifiIPAddress];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ftp server" 
                                                    message:[NSString stringWithFormat:@"your ftp address is : %@", ipaddress] 
                                                   delegate:self 
                                          cancelButtonTitle:@"stop server" 
                                          otherButtonTitles:nil, nil
    ];    
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [ftpServer stopFtpServer];
    
    if([fileTansFinishDelegate conformsToProtocol:@protocol(FileTanslationDelegate)]) {
        [fileTansFinishDelegate fileTranslateFinished];
    }
    
    if(ftpServer) {
        [ftpServer release];
        ftpServer = nil;
    }
    NSLog(@"ftp server stoped!");
}


@end
