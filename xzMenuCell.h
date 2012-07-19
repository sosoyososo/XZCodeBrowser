//
//  xzMenuCell.h
//  CodeBrowser
//
//  Created by Xizhu on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xzMenuCell : UITableViewCell {
    CGFloat _levelOffset;
    CGFloat _fileOffset;
}

@property (nonatomic, assign) NSUInteger        level;
@property (nonatomic, copy)   NSString          *content;
@property (nonatomic, assign) BOOL              isDictionary;

@end
