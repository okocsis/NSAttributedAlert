//
//  SOPButtonCell.m
//  AttributedAlert
//
//  Created by Kocsis Olivér on 2014.08.14..
//  Copyright (c) 2014 Bert McDowell. All rights reserved.
//

#import "SOPButtonCell.h"
@interface SOPButtonCell()
@property BOOL isSetup;
@end
#define roundedRadius 5.0f

@implementation SOPButtonCell
//@synthesize isMosueOver = _isMosueOver;
-(void)setIsSOPFocused:(BOOL)isSOPFocused
{
    _isSOPFocused = isSOPFocused;
    
}

-(void)setup
{
    if (_isSetup == NO)
    {
        [self setTitle:self.title];
//        [self setFont:[NSFont fontWithName:@"OpenSans" size:12.f]];
        _isSetup = YES;
    }
}
-(void)setTitle:(NSString *)aString
{
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSCenterTextAlignment]; //horizontal center for text
    // setting color and font
    NSAttributedString * attrStr = [[NSAttributedString alloc]
                                    initWithString:aString
                                    attributes:@{NSForegroundColorAttributeName: [NSColor whiteColor],
                                                 NSParagraphStyleAttributeName: style,
                                                 NSFontAttributeName : [NSFont fontWithName:@"OpenSans" size:12.f]
                                                 
                                                 }
                                    ];
    [self setAttributedTitle:attrStr];
    
}
-(void)setAttributedTitle:(NSAttributedString *)obj
{
    [super setAttributedTitle:obj];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initImageCell:(NSImage *)anImage
{
    self = [super initImageCell:anImage];
    if (self) {
        [self setup];
    }
    return self;
}
- (id)initTextCell:(NSString *)aString
{
    
    self = [super initTextCell:aString];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}
-(void)drawButtonStrokeInRect:(CGRect) rect
                    inContext:(CGContextRef) ctx
{
//    CGContextSaveGState(ctx);
    CGRect smallerRect = CGRectInset(rect, 1.f, 1.f);
    CGPathRef strokePath = CGPathCreateWithRoundedRect(smallerRect,
                                                       roundedRadius,
                                                       roundedRadius,
                                                       NULL);
    CGContextAddPath(ctx, strokePath);
    // drawing white stroke
    
    [[NSColor whiteColor] setStroke];
    CGContextSetLineWidth(ctx, 2.f);
    CGContextStrokePath(ctx);
//    CGContextRestoreGState(ctx);
    
    
    
}
-(void)drawButtonFillInRect:(CGRect) rect
       withColorStateNormal:(NSColor *) normalStateColor
        colorStateMouseOver:(NSColor *) mouseOverStateColor
          colorStatePressed:(NSColor *) pressedStateColor
                  inContext:(CGContextRef) ctx
{
//    CGContextSaveGState(ctx);
    if (_isMosueOver)
    {
        if ([self isHighlighted] == NO)
        {
            [mouseOverStateColor setFill];
        }
        else
        {
            [pressedStateColor setFill];
        }
    }
    else
    {
        if ([self isHighlighted] == NO)
        {
            [normalStateColor setFill];
        }
    }
    CGContextFillRect(ctx,rect);
//    CGContextRestoreGState(ctx);
}
- (void)drawBezelWithFrame:(NSRect)frame
                    inView:(NSView *)controlView
{
//    NSGraphicsContext *ctx2 = [NSGraphicsContext currentContext];
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    // Outer stroke (drawn as gradient)
    CGContextSaveGState(ctx);
    
    CGPathRef outerClipPath = CGPathCreateWithRoundedRect(frame,
                                                          roundedRadius,
                                                          roundedRadius,
                                                          NULL);
    CGContextAddPath(ctx, outerClipPath);
    CGContextClip(ctx);
    if (_isSOPFocused) // keyButton
    {
        [self drawButtonFillInRect:frame
              withColorStateNormal:[NSColor colorWithCalibratedRed:49.f/255.f green:183.f/255.f blue:205.f/255.f alpha:1.f]
               colorStateMouseOver:[NSColor colorWithCalibratedRed:60.f/255.f green:195.f/255.f blue:220.f/255.f alpha:1.f]
                 colorStatePressed:[NSColor colorWithCalibratedRed:49.f/255.f green:183.f/255.f blue:205.f/255.f alpha:.9f]
                         inContext:ctx];
    }
    else // simple button
    {
        
        [self drawButtonFillInRect:CGRectInset(frame, 2.f, 2.f)
              withColorStateNormal:[NSColor blackColor]
               colorStateMouseOver:[NSColor colorWithCalibratedRed:25.f/255.f green:93.f/255.f blue:104.f/255.f alpha:1.f]
                 colorStatePressed:[NSColor colorWithCalibratedRed:49.f/255.f green:183.f/255.f blue:205.f/255.f alpha:1.f]
                         inContext:ctx ];
        [self drawButtonStrokeInRect:frame
                           inContext:ctx];
    }
    
    CGContextRestoreGState(ctx);
    
    
}
-(NSRect)drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView
{
    NSRect newFrame = frame;
    newFrame.origin.y -=1.f; //vertical center for text
    return [super drawTitle:title withFrame:newFrame inView:controlView];
}
@end
