//
//  SOPButton.m
//  AttributedAlert
//
//  Created by Kocsis Olivér on 2014.08.14..
//  Copyright (c) 2014 Bert McDowell. All rights reserved.
//

#import "SOPButton.h"
#import "SOPButtonCell.h"

@interface SOPButton()
@property (nonatomic) NSTrackingArea* trackingArea;
@end

@implementation SOPButton

-(void)setIsSOPFocused:(BOOL)isSOPFocused
{
    
    [(SOPButtonCell *)[self cell] setIsSOPFocused:isSOPFocused];
    [self setNeedsDisplay:YES];
}
-(BOOL)isSOPFocused
{
    return [(SOPButtonCell *)[self cell] isSOPFocused];
}
-(void)setupTrackingArea
{
    if (CGRectEqualToRect([self bounds], CGRectZero) )
    {
        return;
    }
    if (_trackingArea)
    {
        [self removeTrackingArea:_trackingArea];
    }
    _trackingArea = [[NSTrackingArea alloc]
                                    initWithRect:[self bounds]
                                    options:NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways
                                    owner:self
                                    userInfo:nil];

    [self addTrackingArea:_trackingArea];
}
-(void)preSetup
{
    [SOPButton setCellClass:[SOPButtonCell class]];
}
-(void)awakeFromNib
{
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
-(void)setKeyEquivalent:(NSString *)charCode
{
    if ([charCode isEqualToString:@"\r"])
    {
        self.isSOPFocused = YES;
    }
    else
    {
        self.isSOPFocused = NO;
    }
    [super setKeyEquivalent:charCode];
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

- (void)mouseEntered:(NSEvent *)theEvent
{
    [self setNeedsDisplay:YES];
    [(SOPButtonCell *)[self cell] setIsMosueOver:YES];
    NSLog(@"enter :: %@",self);
}

- (void)mouseExited:(NSEvent *)theEvent
{
    [self setNeedsDisplay:YES];
    [(SOPButtonCell *)[self cell] setIsMosueOver:NO];
    NSLog(@"exit :: %@",self);
}

@end
