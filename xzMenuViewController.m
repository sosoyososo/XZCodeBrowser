//
//  xzMenuViewController.m
//  CodeBrowser
//
//  Created by Xizhu on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "xzMenuViewController.h"
#import "xzMenuHelper.h"
#import "xzMenuCell.h"

@interface xzMenuViewController ()

@property (nonatomic, readonly) NSString        *rootPath;
@property (nonatomic, readonly) NSArray         *contentArray;
@property (nonatomic, readonly) xzMenuHelper    *menuHelper;

@end

@implementation xzMenuViewController

@synthesize rootPath, contentArray, menuHelper, menuDelegate;

- (void)reloadFileList {
    [self.menuHelper reloadFileList];
    [self.tableView reloadData];
}

- (void)setShow:(BOOL)isShow {
    self.tableView.allowsSelection = isShow;
}

- (void)dealloc {
    [super dealloc];
    [rootPath release];
    [contentArray release];
}

- (id)initWithRootPath:(NSString *)path {
    
    if([super init]) {
        menuHelper = [[xzMenuHelper alloc] initWithRootPath:path];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuHelper numOfMenuCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    xzMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell) {
        cell = [[[xzMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.isDictionary = [self.menuHelper pathAtIndexIsDictionary:indexPath.row];
    cell.content = [self.menuHelper pathToBeShowAtIndex:indexPath.row];
    cell.level = [self.menuHelper levelOfPathAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.menuHelper pathAtIndexIsDictionary:indexPath.row]) {
        NSMutableArray *indexpaths = [NSMutableArray arrayWithCapacity:1];
        
        if(![self.menuHelper isPathAtIndexUnfolded:indexPath.row]) {
            int count = [self.menuHelper numOfSubContentAtIndex:indexPath.row];
            for (int i = 1; i <= count; ++ i) {
                [indexpaths addObject:[NSIndexPath indexPathForRow:indexPath.row + i inSection:0]];
            }
            
            [self.menuHelper unFoldDictionaryAtIndex:indexPath.row];
            [tableView insertRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationFade];
        } else {
            
            int count = [self.menuHelper foldDictionaryAtIndex:indexPath.row];
            for (int i = 1; i <= count; ++ i) {
                [indexpaths addObject:[NSIndexPath indexPathForRow:indexPath.row + i inSection:0]];
            }
            [tableView deleteRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationFade];
        }
    } else {
        if([menuDelegate conformsToProtocol:@protocol(xzMenuDelegate)]) {
            [menuDelegate didSelectedFileAtPath:[self.menuHelper pathOfCellAtIndex:indexPath.row]];
        }
    }
}

@end
