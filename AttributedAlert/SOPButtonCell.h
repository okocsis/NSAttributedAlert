//
//  SOPButtonCell.h
//  AttributedAlert
//
//  Created by Kocsis Olivér on 2014.08.14..
//  Copyright (c) 2014 Bert McDowell. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SOPButtonCell : NSButtonCell
@property (atomic) BOOL isMosueOver;
@property (nonatomic) BOOL isSOPFocused;

@end
