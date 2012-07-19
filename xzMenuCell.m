//
//  xzMenuCell.m
//  CodeBrowser
//
//  Created by Xizhu on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "xzMenuCell.h"
#import "xzMenuItemView.h"


@interface  xzMenuCell()

@property (nonatomic, readonly) xzMenuItemView  *itemView;

- (void)setItemviewPosition;

@end

@implementation xzMenuCell

@synthesize itemView, level, content, isDictionary;

- (void)dealloc {
    [super dealloc];
    [itemView release];
}

- (xzMenuItemView *)itemView {
    if(!itemView) {
        itemView = [[xzMenuItemView alloc] initWithContent:nil isDictionary:NO];
        [self.contentView  addSubview:itemView];
    }
    return itemView;
}

- (void)setLevel:(NSUInteger)l {
    level = l;
    _levelOffset = level * 30;
    [self setItemviewPosition];
}

- (void)setContent:(NSString *)acontent {
    content = [acontent copy];
    [self.itemView setContent:content];
}

- (void)setIsDictionary:(BOOL)is {
    isDictionary = is;
    _fileOffset = isDictionary ? 0 : 15;
    [self.itemView setIsDictionary:isDictionary];
    [self setItemviewPosition];
}

- (void)setItemviewPosition {
    CGRect rect = self.itemView.bounds;
    rect.origin.x = _levelOffset + _fileOffset;
    self.itemView.frame = rect;
}

@end
