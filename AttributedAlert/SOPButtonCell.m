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


@implementation SOPButtonCell
-(void)setIsSOPFocused:(BOOL)isSOPFocused
{
    _isSOPFocused = isSOPFocused;
    
}
-(void)setIsMosueOver:(BOOL)isMosueOver
{
    _isMosueOver = isMosueOver;
   
}

-(void)setup
{
    if (_isSetup == NO)
    {
        [self setFont:[NSFont fontWithName:@"OpenSans" size:12.f]];
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

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
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
//- (void)drawImage:(NSImage*)image
//        withFrame:(NSRect)frame
//           inView:(NSView*)controlView
//{
//    NSGraphicsContext *ctx = [NSGraphicsContext currentContext];
//    CGContextRef contextRef = [ctx graphicsPort];
//    
//    NSData *data = [image TIFFRepresentation]; // open for suggestions
//    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
//    if(source) {
//        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
//        CFRelease(source);
//        
//        // Draw shadow 1px below image
//        
//        CGContextSaveGState(contextRef);
//        {
//            NSRect rect = NSOffsetRect(frame, 0.0f, 1.0f);
//            CGFloat white = [self isHighlighted] ? 0.2f : 0.35f;
//            CGContextClipToMask(contextRef, NSRectToCGRect(rect), imageRef);
//            [[NSColor colorWithDeviceWhite:white alpha:1.0f] setFill];
//            NSRectFill(rect);
//        }
//        CGContextRestoreGState(contextRef);
//        
//        // Draw image
//        
//        CGContextSaveGState(contextRef);
//        {
//            NSRect rect = frame;
//            CGContextClipToMask(contextRef, NSRectToCGRect(rect), imageRef);
//            [[NSColor colorWithDeviceWhite:0.1f alpha:1.0f] setFill];
//            NSRectFill(rect);
//        } 
//        CGContextRestoreGState(contextRef);        
//        
//        CFRelease(imageRef);
//    }
//}

- (void)drawBezelWithFrame:(NSRect)frame
                    inView:(NSView *)controlView
{
//    NSGraphicsContext *ctx2 = [NSGraphicsContext currentContext];
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    CGFloat roundedRadius = 5.0f;
    
    // Outer stroke (drawn as gradient)
    CGContextSaveGState(ctx);
    
    CGPathRef outerClipPath = CGPathCreateWithRoundedRect(frame, roundedRadius, roundedRadius, NULL);
    CGContextAddPath(ctx, outerClipPath);
    CGContextClip(ctx);
    
    if ([self isMosueOver])
    {
        if ([self isHighlighted] == NO)
        {
            [[NSColor colorWithCalibratedRed:60.f/255.f green:195.f/255.f blue:220.f/255.f alpha:1.f]
         setFill];
        }
        else
        {
            [[NSColor colorWithCalibratedRed:49.f/255.f green:183.f/255.f blue:205.f/255.f alpha:.9f]
             setFill];
        }
    }
    else
    {
        if ([self isHighlighted] == NO)
        {
            [[NSColor colorWithCalibratedRed:49.f/255.f green:183.f/255.f blue:205.f/255.f alpha:1.f]
             setFill];
            
        }
        else // mosue pressed
        {
            [[NSColor colorWithCalibratedRed:49.f/255.f green:183.f/255.f blue:205.f/255.f alpha:.9f]
             setFill];
        }
    }
    
    CGContextFillRect(ctx,frame);
    CGContextRestoreGState(ctx);
    
//    [ctx2 saveGraphicsState];
//    NSBezierPath *outerClip = [NSBezierPath bezierPathWithRoundedRect:frame
//                                                              xRadius:roundedRadius
//                                                              yRadius:roundedRadius];
//    [outerClip setClip];
//    
//    NSGradient *outerGradient = [[NSGradient alloc] initWithColorsAndLocations:
//                                 [NSColor colorWithDeviceWhite:0.20f alpha:1.0f], 0.0f,
//                                 [NSColor colorWithDeviceWhite:0.21f alpha:1.0f], 1.0f,
//                                 nil];
//    
//    [outerGradient drawInRect:[outerClip bounds] angle:90.0f];
//    [ctx2 restoreGraphicsState];
//    
//    // Background gradient
//    
//    [ctx2 saveGraphicsState];
//    NSBezierPath *backgroundPath =
//    [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(frame, 2.0f, 2.0f)
//                                    xRadius:roundedRadius
//                                    yRadius:roundedRadius];
//    [backgroundPath setClip];
//    
//    NSGradient *backgroundGradient = [[NSGradient alloc] initWithColorsAndLocations:
//                                      [NSColor colorWithDeviceWhite:0.17f alpha:1.0f], 0.0f,
//                                      [NSColor colorWithDeviceWhite:0.20f alpha:1.0f], 0.12f,
//                                      [NSColor colorWithDeviceWhite:0.27f alpha:1.0f], 0.5f,
//                                      [NSColor colorWithDeviceWhite:0.30f alpha:1.0f], 0.5f,
//                                      [NSColor colorWithDeviceWhite:0.42f alpha:1.0f], 0.98f,
//                                      [NSColor colorWithDeviceWhite:0.50f alpha:1.0f], 1.0f,
//                                      nil];
//    
//    [backgroundGradient drawInRect:[backgroundPath bounds] angle:270.0f];
//    [ctx2 restoreGraphicsState];
//    
//    // Dark stroke
//    
//    [ctx2 saveGraphicsState];
//    [[NSColor colorWithDeviceWhite:0.12f alpha:1.0f] setStroke];
//    [[NSBezierPath bezierPathWithRoundedRect:NSInsetRect(frame, 1.5f, 1.5f)
//                                     xRadius:roundedRadius
//                                     yRadius:roundedRadius] stroke];
//    [ctx2 restoreGraphicsState];
//    
//    // Inner light stroke
//    
//    [ctx2 saveGraphicsState];
//    [[NSColor colorWithDeviceWhite:1.0f alpha:0.05f] setStroke];
//    [[NSBezierPath bezierPathWithRoundedRect:NSInsetRect(frame, 2.5f, 2.5f)
//                                     xRadius:roundedRadius
//                                     yRadius:roundedRadius] stroke];
//    [ctx2 restoreGraphicsState];
//    
//    // Draw darker overlay if button is pressed
//    
//    if([self isHighlighted]) {
//        [ctx2 saveGraphicsState];
//        [[NSBezierPath bezierPathWithRoundedRect:NSInsetRect(frame, 2.0f, 2.0f)
//                                         xRadius:roundedRadius
//                                         yRadius:roundedRadius] setClip];
//        [[NSColor colorWithCalibratedWhite:0.0f alpha:0.35] setFill];
//        NSRectFillUsingOperation(frame, NSCompositeSourceOver);
//        [ctx2 restoreGraphicsState];
//    }
    
}
-(NSRect)drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView
{
    NSRect newFrame = frame;
    newFrame.origin.y -=1.f; //vertical center for text
    return [super drawTitle:title withFrame:newFrame inView:controlView];
}
@end
