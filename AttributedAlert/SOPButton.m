//
//  SOPButton.m
//  AttributedAlert
//
//  Created by Kocsis Olivér on 2014.08.14..
//  Copyright (c) 2014 Bert McDowell. All rights reserved.
//

#import "SOPButton.h"
#import "SOPButtonCell.h"



@implementation SOPButton

-(void)setIsSOPFocused:(BOOL)isSOPFocused
{
    
    [(SOPButtonCell *)[self cell] setIsSOPFocused:isSOPFocused];
    [self setNeedsDisplay:YES];
}
-(BOOL)isSOPFocused
{
    [self setNeedsDisplay:YES];
    return [(SOPButtonCell *)[self cell] isSOPFocused];
}
-(void)setupTrackingArea
{
    if (CGRectEqualToRect([self bounds], CGRectZero) )
    {
        return;
    }
    NSTrackingArea* trackingArea = [[NSTrackingArea alloc]
                                    initWithRect:[[[self cell] controlView] frame]
                                   options:NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways
                                   owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
}
-(void)preSetup
{
    [SOPButton setCellClass:[SOPButtonCell class]];
}
-(void)awakeFromNib
{
    [self preSetup];
    [super awakeFromNib];
    [self setupTrackingArea];
    
}

- (id)initWithFrame:(NSRect)frame
{
    [self preSetup];
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTrackingArea];
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
-(void)setFrame:(NSRect)frameRect
{
    [super setFrame:frameRect];
    [self setupTrackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent{
    NSLog(@"entered");
    [[self cell] setIsMosueOver:YES];
    
    
}

- (void)mouseExited:(NSEvent *)theEvent{
    [[self cell] setIsMosueOver:NO];
    NSLog(@"exited");
    
}

@end
