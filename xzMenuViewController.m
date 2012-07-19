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

@synthesize rootPath, contentArray, menuHelper;

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuHelper numOfMenuCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    xzMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell) {
        cell = [[xzMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.isDictionary = [self.menuHelper pathAtIndexIsDictionary:indexPath.row];
    cell.content = [self.menuHelper pathToBeShowAtIndex:indexPath.row];
    cell.level = [self.menuHelper levelOfPathAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(![self.menuHelper isPathAtIndexUnfolded:indexPath.row]) {
        [self.menuHelper unFoldDictionaryAtIndex:indexPath.row];
    } else {
        [self.menuHelper foldDictionaryAtIndex:indexPath.row];
    }
    [tableView reloadData];
}

@end
