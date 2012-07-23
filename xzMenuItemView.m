//
//  xzMenuItemView.m
//  CodeBrowser
//
//  Created by Xizhu on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "xzMenuItemView.h"

@interface xzMenuItemView()

@property (nonatomic, readonly) UILabel         *contentLabel;
@property (nonatomic, readonly) UIImageView     *iconView;

@end

@implementation xzMenuItemView

@synthesize content, isDictionary, contentLabel, iconView;

- (void)dealloc {
    [super dealloc];
    XZRelease(contentLabel)
    XZRelease(content)
    XZRelease(iconView)
}

- (UIView *)initWithContent:(NSString *)acontent isDictionary:(BOOL)is {
    if(self = [super initWithFrame:CGRectMake(0, 0, 500, 30)]) {
        [self setContent:acontent];
        [self setIsDictionary:is];
    }
    return self;
}

- (UILabel *)contentLabel {
    if(!contentLabel) {
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 470, 30)];
        [self addSubview:contentLabel];
    }
    return contentLabel;
}

- (void)setContent:(NSString *)aContent {
    content = [aContent copy];
    self.contentLabel.text = content;
}

- (UIImageView *)iconView {
    if(!iconView) {
        iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self addSubview:iconView];
    }
    return iconView;
}

- (void)setIsDictionary:(BOOL)is {
    isDictionary = is;
    UIImage *image = [UIImage imageNamed:(isDictionary ? @"dictionaryIcon" : @"fileIcon")];
    self.iconView.image = image;
}

@end
