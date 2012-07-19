//
//  xzMenuItemView.h
//  CodeBrowser
//
//  Created by Xizhu on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface xzMenuItemView : UIView

@property (nonatomic, copy) NSString        *content;
@property (nonatomic, assign) BOOL          isDictionary;

- (UIView *)initWithContent:(NSString *)content isDictionary:(BOOL)isDictionary;

@end
